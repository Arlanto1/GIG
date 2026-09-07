// // // import 'package:db_atom/index.dart';
// // //
// // // class MultiSelectDropdown extends StatefulWidget {
// // //   const MultiSelectDropdown({
// // //     super.key,
// // //     required this.briefingPoints,
// // //     required this.selectedPoints,
// // //     required this.onSelectedBriefingPointsChanged,
// // //   });
// // //
// // //   final List<String> briefingPoints;
// // //   final List<String> selectedPoints;
// // //   final Function(List<String>) onSelectedBriefingPointsChanged;
// // //
// // //   @override
// // //   State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
// // // }
// // //
// // // class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
// // //   final TextEditingController _customValueController = TextEditingController();
// // //   late List<String> _selectedPoints;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _selectedPoints = List.from(
// // //         widget.selectedPoints); // Copy of selected points to preserve state
// // //   }
// // //
// // //   void _removePoint(String point) {
// // //     setState(() {
// // //       _selectedPoints.remove(point);
// // //       widget.onSelectedBriefingPointsChanged(_selectedPoints);
// // //     });
// // //   }
// // //
// // //   void _addPoint(String point) {
// // //     if (point.isNotEmpty && !_selectedPoints.contains(point)) {
// // //       setState(() {
// // //         _selectedPoints.add(point);
// // //         widget.onSelectedBriefingPointsChanged(_selectedPoints);
// // //         _customValueController.clear();
// // //       });
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(1.0),
// // //       child: Column(
// // //         children: [
// // //           if (_selectedPoints.isNotEmpty) ...[
// // //             Container(
// // //               decoration: BoxDecoration(
// // //                 border: Border.all(color: Colors.white),
// // //                 borderRadius: BorderRadius.circular(2.0),
// // //               ),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(7.0),
// // //                 child: Wrap(
// // //                   spacing: 4.0,
// // //                   runSpacing: 2.0,
// // //                   children: _selectedPoints
// // //                       .map(
// // //                         (point) => InkWell(
// // //                       onTap: () => _removePoint(point),
// // //                       child: Chip(
// // //                         label: Padding(
// // //                           padding: const EdgeInsets.symmetric(vertical: 4.0),
// // //                           child: SizedBox(
// // //                             width: double.infinity,
// // //                             child: Row(
// // //                               children: [
// // //                                 Expanded(
// // //                                   child: Text(
// // //                                     point,
// // //                                     maxLines: 2,
// // //                                     overflow: TextOverflow.ellipsis,
// // //                                     style: const TextStyle(
// // //                                       color: AppColors.black,
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                                 const SizedBox(width: 4),
// // //                                 const Icon(
// // //                                   Icons.clear,
// // //                                   size: 15,
// // //                                   color: AppColors.black,
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   )
// // //                       .toList(),
// // //
// // //                 ),
// // //               ),
// // //             ),
// // //             CommonWidgets.verticalSpacerWidget(
// // //                 MediaQuery.of(context).size.height * 0.01),
// // //           ],
// // //           DropdownButtonFormField<String>(
// // //             isExpanded: true,
// // //             decoration: const InputDecoration(
// // //               labelText: 'Select Items',
// // //               labelStyle: TextStyle(
// // //                 color: Colors.white70, //  change as needed
// // //                 fontSize: 16,
// // //               ),
// // //               // focusedBorder: OutlineInputBorder(
// // //               //   borderSide: BorderSide(
// // //               //     color: AppColors.white,
// // //               //   ),
// // //               // ),
// // //               enabledBorder: OutlineInputBorder(
// // //                 borderSide: BorderSide(
// // //                   color: Colors.white, //  idle border
// // //                   width: 1.2,
// // //                 ),
// // //               ),
// // //               border: OutlineInputBorder(
// // //                 borderSide: BorderSide(
// // //                   color: AppColors.white,
// // //                 ),
// // //               ),
// // //             ),
// // //             // value: null,
// // //             onChanged: (value) {
// // //               if (value != null) {
// // //                 _addPoint(value);
// // //               }
// // //             },
// // //             items: widget.briefingPoints.map((point) {
// // //               return DropdownMenuItem<String>(
// // //                 value: point,
// // //                 child: Text(point),
// // //               );
// // //             }).toList(),
// // //           ),
// // //           const SizedBox(height: 20),
// // //           Row(
// // //             children: [
// // //               SizedBox(
// // //                 width: 280,
// // //                 child: TextField(
// // //                   style: Styles.textStyleWhite16,
// // //                   controller: _customValueController,
// // //                   decoration: InputDecoration(
// // //                     fillColor: Colors.transparent,
// // //                     filled: true,
// // //                     border: const OutlineInputBorder(),
// // //                     focusedBorder: OutlineInputBorder(
// // //                       borderSide: const BorderSide(
// // //                           color: AppColors.white, width: 1.0),
// // //                       borderRadius: BorderRadius.circular(8.0),
// // //                     ),
// // //                     enabledBorder: OutlineInputBorder(
// // //                       borderSide: const BorderSide(
// // //                           color: AppColors.white, width: 1.0),
// // //                       borderRadius: BorderRadius.circular(8.0),
// // //                     ),
// // //                     hintText: 'Add Custom Briefing Point',
// // //                     hintStyle: const TextStyle(
// // //                       color: Colors.white70, //  change to whatever you want
// // //                     ),
// // //                     disabledBorder: OutlineInputBorder(
// // //                       borderSide: const BorderSide(
// // //                           color: AppColors.white, width: 1.0),
// // //                       borderRadius: BorderRadius.circular(8.0),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const Spacer(),
// // //               AppButton(
// // //                 width: 70,
// // //                 buttonText: 'Add',
// // //                 buttonTextKey: Keys.submitButton,
// // //                 onTap: () => _addPoint(_customValueController.text.trim()),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:db_atom/index.dart';
// //
// // /// A combined "type or pick" multi-select widget.
// // ///
// // /// - Selected values render as pill-shaped chips *inside* the same bordered
// // ///   box as the text field (matches the reference screenshot).
// // /// - Typing filters `briefingPoints` into a dropdown suggestion list shown
// // ///   just below the box; tapping a suggestion adds it as a chip.
// // /// - Pressing enter / submitting with custom text adds it as a chip too,
// // ///   even if it isn't in `briefingPoints`.
// // /// - Tapping the (empty) field shows the full list of remaining options,
// // ///   so it still behaves like a dropdown when the user wants to browse.
// // class MultiSelectDropdown extends StatefulWidget {
// //   const MultiSelectDropdown({
// //     super.key,
// //     required this.briefingPoints,
// //     required this.selectedPoints,
// //     required this.onSelectedBriefingPointsChanged,
// //   });
// //
// //   final List<String> briefingPoints;
// //   final List<String> selectedPoints;
// //   final Function(List<String>) onSelectedBriefingPointsChanged;
// //
// //   @override
// //   State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
// // }
// //
// // class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
// //   final TextEditingController _controller = TextEditingController();
// //   final FocusNode _focusNode = FocusNode();
// //   late List<String> _selectedPoints;
// //   List<String> _suggestions = [];
// //   bool _showSuggestions = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _selectedPoints = List.from(widget.selectedPoints);
// //     _controller.addListener(_onTextChanged);
// //     _focusNode.addListener(() {
// //       // Small delay so a tap on a suggestion registers before we hide the list.
// //       Future.delayed(const Duration(milliseconds: 150), () {
// //         if (!_focusNode.hasFocus && mounted) {
// //           setState(() => _showSuggestions = false);
// //         }
// //       });
// //     });
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller.removeListener(_onTextChanged);
// //     _controller.dispose();
// //     _focusNode.dispose();
// //     super.dispose();
// //   }
// //
// //   void _onTextChanged() {
// //     final query = _controller.text.trim().toLowerCase();
// //     final matches = widget.briefingPoints
// //         .where((p) =>
// //     !_selectedPoints.contains(p) &&
// //         (query.isEmpty || p.toLowerCase().contains(query)))
// //         .toList();
// //     setState(() {
// //       _suggestions = matches;
// //       _showSuggestions = matches.isNotEmpty;
// //     });
// //   }
// //
// //   void _removePoint(String point) {
// //     setState(() => _selectedPoints.remove(point));
// //     widget.onSelectedBriefingPointsChanged(_selectedPoints);
// //   }
// //
// //   void _addPoint(String point) {
// //     final trimmed = point.trim();
// //     if (trimmed.isEmpty || _selectedPoints.contains(trimmed)) return;
// //     setState(() {
// //       _selectedPoints.add(trimmed);
// //       _controller.clear();
// //       _suggestions = [];
// //       _showSuggestions = false;
// //     });
// //     widget.onSelectedBriefingPointsChanged(_selectedPoints);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
// //           decoration: BoxDecoration(
// //             border: Border.all(color: AppColors.white, width: 1.2),
// //             borderRadius: BorderRadius.circular(10.0),
// //           ),
// //           child: Wrap(
// //             spacing: 20.0,
// //             runSpacing: 30.0,
// //             crossAxisAlignment: WrapCrossAlignment.center,
// //             children: [
// //               ..._selectedPoints.map(
// //                     (point) => Chip(
// //                   backgroundColor: Colors.transparent, // swap for your blue accent
// //                   label: Text(
// //                     point,
// //                     style: const TextStyle(color: Colors.black),
// //                   ),
// //                   deleteIcon: const Icon(
// //                     Icons.close,
// //                     size: 16,
// //                     color: Colors.black,
// //                   ),
// //                   onDeleted: () => _removePoint(point),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                   visualDensity: VisualDensity.compact,
// //                 ),
// //               ),
// //               ConstrainedBox(
// //                 constraints: const BoxConstraints(minWidth: 200),
// //                 child: IntrinsicWidth(
// //                   child: TextField(
// //                     controller: _controller,
// //                     focusNode: _focusNode,
// //                     style: Styles.textStyleWhite16,
// //                     decoration: const InputDecoration(
// //                       isDense: true,
// //                       border: InputBorder.none,
// //                       hintText: 'Type or select...',
// //                       hintStyle: TextStyle(color: Colors.white70),
// //                     ),
// //                     onSubmitted: _addPoint,
// //                     onTap: () {
// //                       if (!_showSuggestions) _onTextChanged();
// //                     },
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         if (_showSuggestions)
// //           Container(
// //             margin: const EdgeInsets.only(top: 4),
// //             constraints: const BoxConstraints(maxHeight: 200),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               border: Border.all(color: Colors.grey.shade300),
// //               borderRadius: BorderRadius.circular(8),
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.black.withOpacity(0.10),
// //                   blurRadius: 8,
// //                   offset: const Offset(0, 3),
// //                 ),
// //               ],
// //             ),
// //             child: ListView.builder(
// //               shrinkWrap: true,
// //               padding: EdgeInsets.zero,
// //               itemCount: _suggestions.length,
// //               itemBuilder: (context, index) {
// //                 final item = _suggestions[index];
// //                 return ListTile(
// //                   dense: true,
// //                   title: Text(item, style: const TextStyle(color: AppColors.black)),
// //                   onTap: () => _addPoint(item),
// //                 );
// //               },
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }
//
// import 'package:db_atom/index.dart';
//
// /// A combined "type or pick" multi-select widget.
// ///
// /// - Selected values render as pill-shaped chips *inside* the same bordered
// ///   box as the text field (matches the reference screenshot).
// /// - Typing filters `briefingPoints` into a dropdown suggestion list shown
// ///   just below the box; tapping a suggestion adds it as a chip.
// /// - Pressing enter / submitting with custom text adds it as a chip too,
// ///   even if it isn't in `briefingPoints`.
// /// - Tapping the (empty) field shows the full list of remaining options,
// ///   so it still behaves like a dropdown when the user wants to browse.
// class MultiSelectDropdown extends StatefulWidget {
//   const MultiSelectDropdown({
//     super.key,
//     required this.briefingPoints,
//     required this.selectedPoints,
//     required this.onSelectedBriefingPointsChanged,
//   });
//
//   final List<String> briefingPoints;
//   final List<String> selectedPoints;
//   final Function(List<String>) onSelectedBriefingPointsChanged;
//
//   @override
//   State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
// }
//
// class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   late List<String> _selectedPoints;
//   List<String> _suggestions = [];
//   bool _showSuggestions = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedPoints = _cleaned(widget.selectedPoints);
//     _controller.addListener(_onTextChanged);
//     _focusNode.addListener(() {
//       // Small delay so a tap on a suggestion registers before we hide the list.
//       Future.delayed(const Duration(milliseconds: 150), () {
//         if (!_focusNode.hasFocus && mounted) {
//           setState(() => _showSuggestions = false);
//         }
//       });
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant MultiSelectDropdown oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // If the parent passes in a fresh selectedPoints list (e.g. after a
//     // reload), re-sync but still strip blanks so empty chips can't reappear.
//     if (oldWidget.selectedPoints != widget.selectedPoints) {
//       _selectedPoints = _cleaned(widget.selectedPoints);
//     }
//   }
//
//   // Drops null/empty/whitespace-only entries so an empty "" in the source
//   // list never renders as a blank chip with just a delete "X".
//   List<String> _cleaned(List<String> points) =>
//       points.map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
//
//   @override
//   void dispose() {
//     _controller.removeListener(_onTextChanged);
//     _controller.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   void _onTextChanged() {
//     final query = _controller.text.trim().toLowerCase();
//     final matches = widget.briefingPoints
//         .where((p) =>
//     !_selectedPoints.contains(p) &&
//         (query.isEmpty || p.toLowerCase().contains(query)))
//         .toList();
//     setState(() {
//       _suggestions = matches;
//       _showSuggestions = matches.isNotEmpty;
//     });
//   }
//
//   void _removePoint(String point) {
//     setState(() => _selectedPoints.remove(point));
//     widget.onSelectedBriefingPointsChanged(_selectedPoints);
//   }
//
//   void _addPoint(String point) {
//     final trimmed = point.trim();
//     if (trimmed.isEmpty || _selectedPoints.contains(trimmed)) return;
//     setState(() {
//       _selectedPoints.add(trimmed);
//       _controller.clear();
//       _suggestions = [];
//       _showSuggestions = false;
//     });
//     widget.onSelectedBriefingPointsChanged(_selectedPoints);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // stretch (not .start) is what makes every instance of this widget
//       // the same width, since it forces the box below to fill whatever
//       // width its parent gives it rather than shrink-wrapping to content.
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.white, width: 1.2),
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: Wrap(
//             spacing: 8.0,
//             runSpacing: 8.0,
//             crossAxisAlignment: WrapCrossAlignment.center,
//             children: [
//               ..._selectedPoints.map(
//                     (point) => Chip(
//                   backgroundColor: Colors.transparent, // swap for your blue accent
//                   label: ConstrainedBox(
//                     // Caps how wide a single long chip can get, so it wraps
//                     // its own text instead of stretching the whole box.
//                     constraints: BoxConstraints(
//                       maxWidth: MediaQuery.of(context).size.width * 0.6,
//                     ),
//                     child: Text(
//                       point,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   deleteIcon: const Icon(
//                     Icons.close,
//                     size: 16,
//                     color: Colors.black,
//                   ),
//                   onDeleted: () => _removePoint(point),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   visualDensity: VisualDensity.compact,
//                 ),
//               ),
//               // A plain SizedBox (no IntrinsicWidth) so the field takes a
//               // fixed, predictable width instead of sizing to its text —
//               // that was the other source of the boxes looking mismatched.
//               SizedBox(
//                 width: 160,
//                 child: TextField(
//                   controller: _controller,
//                   focusNode: _focusNode,
//                   style: Styles.textStyleWhite16,
//                   decoration: const InputDecoration(
//                     isDense: true,
//                     border: InputBorder.none,
//                     hintText: 'Type or select...',
//                     hintStyle: TextStyle(color: Colors.white70),
//                   ),
//                   onSubmitted: _addPoint,
//                   onTap: () {
//                     if (!_showSuggestions) _onTextChanged();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (_showSuggestions)
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.only(top: 4),
//             constraints: const BoxConstraints(maxHeight: 200),
//             decoration: BoxDecoration(
//               color: AppColors.newColor,
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.10),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.zero,
//               itemCount: _suggestions.length,
//               itemBuilder: (context, index) {
//                 final item = _suggestions[index];
//                 return ListTile(
//                   dense: true,
//                   title: Text(item, style: const TextStyle(color: AppColors.black)),
//                   onTap: () => _addPoint(item),
//                 );
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }
import 'dart:ui';

import 'package:db_atom/index.dart';
class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({
    super.key,
    required this.briefingPoints,
    required this.selectedPoints,
    required this.onSelectedBriefingPointsChanged,
  });

  final List<String> briefingPoints;
  final List<String> selectedPoints;
  final Function(List<String>) onSelectedBriefingPointsChanged;

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late List<String> _selectedPoints;
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _selectedPoints = _cleaned(widget.selectedPoints);
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      // Small delay so a tap on a suggestion registers before we hide the list.
      Future.delayed(const Duration(milliseconds: 150), () {
        if (!_focusNode.hasFocus && mounted) {
          setState(() => _showSuggestions = false);
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the parent passes in a fresh selectedPoints list (e.g. after a
    // reload), re-sync but still strip blanks so empty chips can't reappear.
    if (oldWidget.selectedPoints != widget.selectedPoints) {
      _selectedPoints = _cleaned(widget.selectedPoints);
    }
  }

  // Drops null/empty/whitespace-only entries so an empty "" in the source
  // list never renders as a blank chip with just a delete "X".
  List<String> _cleaned(List<String> points) =>
      points.map((p) => p.trim()).where((p) => p.isNotEmpty).toList();

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text.trim().toLowerCase();
    final matches = widget.briefingPoints
        .where((p) =>
    !_selectedPoints.contains(p) &&
        (query.isEmpty || p.toLowerCase().contains(query)))
        .toList();
    setState(() {
      _suggestions = matches;
      _showSuggestions = matches.isNotEmpty;
    });
  }

  void _removePoint(String point) {
    setState(() => _selectedPoints.remove(point));
    widget.onSelectedBriefingPointsChanged(_selectedPoints);
  }

  void _addPoint(String point) {
    final trimmed = point.trim();
    if (trimmed.isEmpty || _selectedPoints.contains(trimmed)) return;
    setState(() {
      _selectedPoints.add(trimmed);
      _controller.clear();
      _suggestions = [];
      _showSuggestions = false;
    });
    widget.onSelectedBriefingPointsChanged(_selectedPoints);
  }

  void _toggleFullList() {
    if (_showSuggestions) {
      setState(() => _showSuggestions = false);
      _focusNode.unfocus();
      return;
    }
    _focusNode.requestFocus();
    setState(() {
      _suggestions = widget.briefingPoints
          .where((p) => !_selectedPoints.contains(p))
          .toList();
      _showSuggestions = _suggestions.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // stretch (not .start) is what makes every instance of this widget
      // the same width, since it forces the box below to fill whatever
      // width its parent gives it rather than shrink-wrapping to content.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              // Extra right padding so chip/text content never sits under
              // the dropdown arrow button positioned on top of it.
              padding: const EdgeInsets.fromLTRB(10, 8, 40, 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.white, width: 1.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ..._selectedPoints.map(
                        (point) => Chip(
                      backgroundColor: Colors.transparent, // swap for your blue accent
                      label: ConstrainedBox(
                        // Caps how wide a single long chip can get, so it wraps
                        // its own text instead of stretching the whole box.
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Text(
                          point,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      deleteIcon: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.black,
                      ),
                      onDeleted: () => _removePoint(point),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  // A plain SizedBox (no IntrinsicWidth) so the field takes a
                  // fixed, predictable width instead of sizing to its text —
                  // that was the other source of the boxes looking mismatched.
                  SizedBox(
                    width: 160,
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: Styles.textStyleWhite16,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Type or select...',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                      onSubmitted: _addPoint,
                      onTap: () {
                        if (!_showSuggestions) _onTextChanged();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // The dropdown affordance: tap to browse the full list without
            // typing, same as the old DropdownButtonFormField's arrow.
            Positioned(
              right: 6,
              top: 0,
              bottom: 0,
              child: Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: _toggleFullList,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.6),
                        width: 1.2,
                      ),
                    ),
                    child: Icon(
                      _showSuggestions
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_showSuggestions)
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              // The actual "glass" blur — frosts whatever is behind the panel.
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 6),
                constraints: const BoxConstraints(maxHeight: 260),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withValues(alpha: 3.0)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withValues(alpha: 0.25),
                  //     blurRadius: 20,
                  //     offset: const Offset(0, 8),
                  //   ),
                  // ],
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _suggestions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 6),
                  itemBuilder: (context, index) {
                    final item = _suggestions[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => _addPoint(item),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.54),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.white54,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}