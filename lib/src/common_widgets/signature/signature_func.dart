import 'package:db_atom/src/common_widgets/signature/signature_controller.dart';
import 'package:db_atom/src/common_widgets/signature/signature_painter.dart';
import 'package:flutter/material.dart';

/// signature canvas. Controller is required, other parameters are optional.
/// widget/canvas expands to maximum by default.
/// this behaviour can be overridden using width and/or height parameters.
class Signature extends StatefulWidget {
  /// constructor
  const Signature({
    required this.controller,
    Key? key,
    this.backgroundColor = Colors.grey,
    this.dynamicPressureSupported = false,
    this.width,
    this.height,
  }) : super(key: key);

  /// signature widget controller
  final SignatureController controller;

  /// signature widget width
  final double? width;

  /// signature widget height
  final double? height;

  /// signature widget background color
  final Color backgroundColor;

  /// support dynamic pressure for width (if has support for it)
  final bool dynamicPressureSupported;

  @override
  State createState() => SignatureState();
}

/// signature widget state
class SignatureState extends State<Signature> {
  /// Helper variable indicating that user has left the canvas so we can prevent linking next point
  /// with straight line.
  bool _isOutsideDrawField = false;

  /// Active pointer to prevent multitouch drawing
  int? activePointerId;

  /// Real widget size
  Size? screenSize;

  /// Max width of canvas
  late double maxWidth;

  /// Max height of canvas
  late double maxHeight;

  @override
  void initState() {
    super.initState();
    _updateWidgetSize();
  }

  @override
  Widget build(BuildContext context) {
    final GestureDetector signatureCanvas = GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) {
        //NO-OP
      },
      child: Container(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            if (!widget.controller.disabled &&
                (activePointerId == null || activePointerId == event.pointer)) {
              activePointerId = event.pointer;
              widget.controller.onDrawStart?.call();
              _addPoint(event, PointType.tap);
            }
          },
          onPointerUp: (PointerUpEvent event) {
            _ensurePointerCleanup();
            if (activePointerId == event.pointer) {
              _addPoint(event, PointType.tap);
              widget.controller.pushCurrentStateToUndoStack();
              widget.controller.onDrawEnd?.call();
              activePointerId = null;
            }
          },
          onPointerCancel: (PointerCancelEvent event) {
            _ensurePointerCleanup();
            if (activePointerId == event.pointer) {
              _addPoint(event, PointType.tap);
              widget.controller.pushCurrentStateToUndoStack();
              widget.controller.onDrawEnd?.call();
              activePointerId = null;
            }
          },
          onPointerMove: (PointerMoveEvent event) {
            _ensurePointerCleanup();
            if (activePointerId == event.pointer) {
              _addPoint(event, PointType.move);
              widget.controller.onDrawMove?.call();
            }
          },
          child: RepaintBoundary(
            child: CustomPaint(
              painter: SignaturePainter(widget.controller),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: maxWidth,
                  minHeight: maxHeight,
                  maxWidth: maxWidth,
                  maxHeight: maxHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.width != null || widget.height != null) {
      //IF DOUNDARIES ARE DEFINED, USE LIMITED BOX
      return Center(
        child: LimitedBox(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          child: signatureCanvas,
        ),
      );
    } else {
      //IF NO BOUNDARIES ARE DEFINED, RETURN THE WIDGET AS IS
      return signatureCanvas;
    }
  }

  @override
  void didUpdateWidget(covariant Signature oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateWidgetSize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
  }

  void _addPoint(PointerEvent event, PointType type) {
    final Offset o = event.localPosition;

    // IF WIDGET IS USED WITHOUT DIMENSIONS, WE WILL FALLBACK TO SCREENSIZE
    // DIMENSIONS
    final double maxSafeWidth =
        maxWidth == double.infinity ? screenSize!.width : maxWidth;
    final double maxSafeHeight =
        maxHeight == double.infinity ? screenSize!.height : maxHeight;

    //SAVE POINT ONLY IF IT IS IN THE SPECIFIED BOUNDARIES
    if ((screenSize?.width == null || o.dx > 0 && o.dx < maxSafeWidth) &&
        (screenSize?.height == null || o.dy > 0 && o.dy < maxSafeHeight)) {
      // IF USER LEFT THE BOUNDARY AND ALSO RETURNED BACK
      // IN ONE MOVE, RETYPE IT AS TAP, AS WE DO NOT WANT TO
      // LINK IT WITH PREVIOUS POINT
      PointType t = type;
      if (_isOutsideDrawField) {
        t = PointType.tap;
      }
      setState(() {
        //IF USER WAS OUTSIDE OF CANVAS WE WILL RESET THE HELPER VARIABLE AS HE HAS RETURNED
        _isOutsideDrawField = false;
        widget.controller.addPoint(Point(
          o,
          t,
          widget.dynamicPressureSupported ? event.pressure : 1.0,
        ));
      });
    } else {
      //NOTE: USER LEFT THE CANVAS!!! WE WILL SET HELPER VARIABLE
      //WE ARE NOT UPDATING IN setState METHOD BECAUSE WE DO NOT NEED TO RUN BUILD METHOD
      _isOutsideDrawField = true;
    }
  }

  void _updateWidgetSize() {
    maxWidth = widget.width ?? double.infinity;
    maxHeight = widget.height ?? double.infinity;
  }

  /// METHOD THAT WILL CLEANUP ANY REMNANT POINTER AFTER DISABLING
  /// WIDGET
  void _ensurePointerCleanup() {
    if (widget.controller.disabled && activePointerId != null) {
      // WIDGET HAS BEEN DISABLED DURING DRAWING.
      // CANCEL CURRENT DRAW
      activePointerId = null;
    }
  }
}
