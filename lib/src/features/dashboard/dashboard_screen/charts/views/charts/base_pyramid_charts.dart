// // // import 'package:db_atom/index.dart';
// // //
// // // class BasePyramidCharts extends StatefulWidget {
// // //   final List<PieChartData> chartData;
// // //   final String chartTitle;
// // //   final Widget moreIcon;
// // //
// // //   const BasePyramidCharts({
// // //     super.key,
// // //     required this.chartTitle,
// // //     required this.moreIcon,
// // //     required this.chartData,
// // //   });
// // //
// // //   @override
// // //   BasePyramidChartsState createState() => BasePyramidChartsState();
// // // }
// // //
// // // class BasePyramidChartsState extends State<BasePyramidCharts> {
// // //   bool isChartVisible = true;
// // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return GestureDetector(
// // // //       onTap: () {
// // // //         // setState(() {
// // // //         //   isChartVisible = !isChartVisible;
// // // //         // });
// // // //       },
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.start,
// // // //         children: [
// // // //           Visibility(
// // // //             visible: isChartVisible,
// // // //             child: Container(
// // // //               height: 300,
// // // //               width: 450,
// // // //               decoration: const ShapeDecoration(
// // // //                 color: AppColors.white,
// // // //                 shape: RoundedRectangleBorder(
// // // //                   borderRadius: BorderRadius.vertical(
// // // //                     top: Radius.circular(0.0),
// // // //                     bottom: Radius.circular(0.0),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               child: Column(
// // // //                 children: [
// // // //                   Row(
// // // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                     children: [
// // // //                       Padding(
// // // //                         padding: const EdgeInsets.all(8.0),
// // // //                         child: Text(
// // // //                           widget.chartTitle,
// // // //                           style: const TextStyle(
// // // //                             fontWeight: FontWeight.bold,
// // // //                             color: AppColors.navigationSkyBlueColor,
// // // //                             fontSize: 16,
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                       // IconButton(
// // // //                       //   icon: const Icon(Icons.cancel),
// // // //                       //   onPressed: () {
// // // //                       //     setState(() {
// // // //                       //       isChartVisible = false;
// // // //                       //     });
// // // //                       //   },
// // // //                       // ),
// // // //                     ],
// // // //                   ),
// // // //                   widget.chartData.isEmptyOrNull
// // // //                       ? const Padding(
// // // //                           padding: EdgeInsets.only(top: 100.0),
// // // //                           child: Center(
// // // //                             child: Text('No Data Found.'),
// // // //                           ),
// // // //                         )
// // // //                       : Expanded(
// // // //                           child: SfPyramidChart(
// // // //                             legend: const Legend(isVisible: true),
// // // //                             series: PyramidSeries<PieChartData, String>(
// // // //                               legendIconType: LegendIconType.seriesType,
// // // //                               dataSource: widget.chartData,
// // // //                               xValueMapper: (PieChartData data, _) => data.x,
// // // //                               yValueMapper: (PieChartData data, _) => data.y,
// // // //                               pointColorMapper: (PieChartData data, _) =>
// // // //                                   data.color,
// // // //                               dataLabelSettings: const DataLabelSettings(
// // // //                                 isVisible: true,
// // // //                                 // You can further customize the data labels here
// // // //                               ),
// // // //                               explode: true,
// // // //                             ),
// // // //                             tooltipBehavior: TooltipBehavior(
// // // //                               enable: true,
// // // //                               builder: (dynamic data,
// // // //                                   dynamic point,
// // // //                                   dynamic series,
// // // //                                   int pointIndex,
// // // //                                   int seriesIndex) {
// // // //                                 return Container(
// // // //                                   padding: const EdgeInsets.all(8),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(5),
// // // //                                     boxShadow: [
// // // //                                       BoxShadow(
// // // //                                           color: Colors.black.withOpacity(0.2),
// // // //                                           spreadRadius: 2,
// // // //                                           blurRadius: 0),
// // // //                                     ],
// // // //                                   ),
// // // //                                   child: Text(
// // // //                                     '${data.x} : ${data.y}',
// // // //                                     style: const TextStyle(color: Colors.black),
// // // //                                   ),
// // // //                                 );
// // // //                               },
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // //   Widget build(BuildContext context) {
// // //     return Visibility(
// // //       visible: isChartVisible,
// // //       child: Container(
// // //         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
// // //         padding: const EdgeInsets.all(10),
// // //         decoration: BoxDecoration(
// // //           color: Colors.white10,
// // //           borderRadius: BorderRadius.circular(10),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.white.withValues(alpha: 0.02),
// // //               blurRadius: 10,
// // //               offset: const Offset(0, 4),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Header Row
// // //             Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 // Header Row
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Expanded(
// // //                       child: SingleChildScrollView(
// // //                         scrollDirection: Axis.horizontal,
// // //                         child: Text(
// // //                           widget.chartTitle,
// // //                           style: const TextStyle(
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.white,
// // //                             fontSize: 19,
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                     widget.moreIcon,
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //
// // //             const SizedBox(height: 12),
// // //
// // //             // Chart or No Data
// // //             widget.chartData.isEmpty
// // //                 ? Container(
// // //               height: 50,
// // //               decoration: BoxDecoration(
// // //                 color: Colors.transparent,
// // //                 borderRadius: BorderRadius.circular(16),
// // //               ),
// // //               child: const Center(
// // //                 child: Text(
// // //                   'No Data Found',
// // //                   style: TextStyle(color: Colors.black54, fontSize: 14),
// // //                 ),
// // //               ),
// // //             )
// // //             //     : SizedBox(
// // //             //   height: 250,
// // //             //   // width: 900,
// // //             //   child: SfPyramidChart(
// // //             //     legend: const Legend(isVisible: true),
// // //             //     tooltipBehavior: TooltipBehavior(enable: true),
// // //             //     series: PyramidSeries<PieChartData, String>(
// // //             //       legendIconType: LegendIconType.seriesType,
// // //             //       dataSource: widget.chartData,
// // //             //       xValueMapper: (PieChartData data, _) => data.x,
// // //             //       yValueMapper: (PieChartData data, _) => data.y,
// // //             //       pointColorMapper: (PieChartData data, _) =>
// // //             //       data.color,
// // //             //       dataLabelSettings: const DataLabelSettings(
// // //             //         isVisible: true,
// // //             //         // You can further customize the data labels here
// // //             //       ),
// // //             //       explode: true,
// // //             //     ),
// // //             //   ),
// // //             // ),
// // //             // :SizedBox(
// // //             //   height: 250,
// // //             //   child: SfCartesianChart(
// // //             //     tooltipBehavior: TooltipBehavior(enable: true),
// // //             //     primaryXAxis: CategoryAxis(),
// // //             //     series: <CartesianSeries>[
// // //             //       SplineAreaSeries<PieChartData, String>(
// // //             //         dataSource: widget.chartData,
// // //             //         xValueMapper: (PieChartData data, _) => data.x,
// // //             //         yValueMapper: (PieChartData data, _) => data.y,
// // //             //         color: Colors.blueAccent.withOpacity(0.4),
// // //             //         borderColor: Colors.blueAccent,
// // //             //         borderWidth: 2,
// // //             //       ),
// // //             //     ],
// // //             //   )
// // //             // ),
// // //
// // //             // //radial circle chart
// // //             // :SfCircularChart(
// // //             //   series: <CircularSeries>[
// // //             //     RadialBarSeries<PieChartData, String>(
// // //             //       dataSource: widget.chartData,
// // //             //       xValueMapper: (PieChartData data, _) => data.x,
// // //             //       yValueMapper: (PieChartData data, _) => data.y,
// // //             //       pointColorMapper: (PieChartData data, _) => data.color,
// // //             //       cornerStyle: CornerStyle.bothCurve,
// // //             //       trackColor: Colors.white10,
// // //             //       maximumValue: 100,
// // //             //       dataLabelSettings: const DataLabelSettings(isVisible: true),
// // //             //     ),
// // //             //   ],
// // //             // ),
// // //             //
// // //             : SizedBox(
// // //                 height: 300,
// // //             child :SfCartesianChart(
// // //               tooltipBehavior: TooltipBehavior(enable: true),
// // //               primaryXAxis: const CategoryAxis(),
// // //               series: <CartesianSeries>[
// // //                 SplineSeries<PieChartData, String>(
// // //                   dataSource: widget.chartData,
// // //                   xValueMapper: (PieChartData data, _) => data.x,
// // //                   yValueMapper: (PieChartData data, _) => data.y,
// // //                   pointColorMapper: (PieChartData data, index) =>
// // //                   presetColors[index % presetColors.length],
// // //                   width: 3,
// // //                   markerSettings: const MarkerSettings(
// // //                     isVisible: true,
// // //                     shape: DataMarkerType.circle,
// // //                     // borderColor: Colors.white,
// // //                     borderWidth: 2,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //             ),
// // //             const SizedBox(height: 10),
// // //
// // //             // Custom Scrollable Legend
// // //             if (widget.chartData.isNotEmpty)
// // //               SizedBox(
// // //                 height: 50,
// // //                 child: SingleChildScrollView(
// // //                   scrollDirection: Axis.horizontal,
// // //                   child: Row(
// // //                     children: widget.chartData.map((data) {
// // //                       final color = customColors[
// // //                       widget.chartData.indexOf(data) % customColors.length];
// // //                       return Container(
// // //                         margin: const EdgeInsets.symmetric(horizontal: 6),
// // //                         padding: const EdgeInsets.symmetric(
// // //                             horizontal: 12, vertical: 6),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.white30,
// // //                           borderRadius: BorderRadius.circular(30),
// // //                           border: Border.all(color: color, width: 1.5),
// // //                         ),
// // //                         child: Row(
// // //                           children: [
// // //                             Container(
// // //                               width: 10,
// // //                               height: 10,
// // //                               decoration: BoxDecoration(
// // //                                 color: color,
// // //                                 shape: BoxShape.circle,
// // //                               ),
// // //                             ),
// // //                             const SizedBox(width: 6),
// // //                             Text(
// // //                               '${data.x} (${data.y}%)',
// // //                               style: const TextStyle(
// // //                                 fontSize: 13,
// // //                                 fontWeight: FontWeight.w500,
// // //                                 color: Color(0xFF333333),
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                 ),
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'dart:math' as math;
// // import 'package:flutter/material.dart';
// //
// // class BasePyramidCharts extends StatefulWidget {
// //   const BasePyramidCharts() : super();
// //
// //   @override
// //   State<BasePyramidCharts> createState() => _BasePyramidChartsState();
// // }
// //
// // class _BasePyramidChartsState extends State<BasePyramidCharts> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: '3D Donut Chart',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //       ),
// //       home: Scaffold(
// //         backgroundColor: const Color(0xFFFDD0D5), // Light pink background color
// //         body: Center(
// //           child: SizedBox(
// //             width: 350, // Canvas width for the chart
// //             height: 350, // Canvas height for the chart
// //             child: CustomPaint(painter: ThreeDDonutChartPainter()),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ThreeDDonutChartPainter extends CustomPainter {
// //   // Define colors for the segments
// //   final List<Color> segmentColors = [
// //     const Color(0xFFA0C0E0), // Soft blue
// //     const Color(0xFFF0B0C0), // Soft pink
// //     const Color(0xFFA0E0D0), // Soft teal/mint
// //   ];
// //
// //   // Values for segments (equal distribution for 3 segments, so 1/3 each)
// //   final List<double> segmentValues = [1, 1, 1];
// //
// //   // Dimensions of the donut chart
// //   final double outerRadius = 100;
// //   final double innerRadius = 60;
// //   final double thickness = 30; // Perceived height/depth of the 3D donut
// //
// //   // Transformation parameters for tilt and rotation to achieve the 3D perspective
// //   // These values are visually tuned to match the reference image.
// //   final double rotationZ =
// //       -math.pi *
// //           0.15; // Overall rotation around Z-axis (e.g., -27 degrees counter-clockwise)
// //   final double tiltX =
// //   0.5; // Tilt around X-axis (e.g., ~28.6 degrees), viewing from slightly above
// //   final double perspectiveFactor =
// //   0.0008; // Small perspective factor for depth illusion
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     // Calculate the center of the drawing area
// //     final center = Offset(size.width / 2, size.height / 2);
// //
// //     canvas.save(); // Save the current state of the canvas
// //
// //     // Apply 3D transformations to the canvas
// //     final Matrix4 matrix = Matrix4.identity()
// //       ..setEntry(3, 2, perspectiveFactor) // Add perspective
// //       ..rotateX(tiltX) // Tilt around the X-axis
// //       ..rotateZ(rotationZ); // Rotate around the Z-axis
// //
// //     // Translate to the center, apply the transformation, then translate back.
// //     // This ensures transformations are applied relative to the chart's center.
// //     canvas.translate(center.dx, center.dy);
// //     canvas.transform(matrix.storage);
// //     // After this, (0,0) in the canvas is the transformed center, and Y-axis is effectively Z-depth.
// //
// //     // --- Draw the main shadow cast by the entire donut ---
// //     final shadowPaint = Paint()
// //       ..color = Colors.black
// //           .withOpacity(0.15) // Soft black shadow
// //       ..maskFilter = const MaskFilter.blur(
// //         BlurStyle.normal,
// //         10.0,
// //       ); // Apply blur
// //
// //     // Create a path for the outer contour of the donut's base
// //     // This path is defined relative to (0,0) in the transformed space,
// //     // at a Y-offset equal to the donut's thickness.
// //     final Path fullDonutBottomOuterPath = Path();
// //     fullDonutBottomOuterPath.addArc(
// //       Rect.fromCircle(center: Offset(0, thickness), radius: outerRadius),
// //       0,
// //       2 * math.pi,
// //     );
// //
// //     // Apply an additional small translation to position the shadow correctly relative to the donut's base
// //     canvas.translate(8, 12); // Offset values for visual adjustment
// //     canvas.drawPath(fullDonutBottomOuterPath, shadowPaint);
// //     canvas.translate(-8, -12); // Translate back after drawing the shadow
// //
// //     // --- Prepare segment data and drawing order ---
// //     double totalValue = segmentValues.reduce((a, b) => a + b);
// //     double currentStartAngle =
// //     0; // Flutter's drawArc starts at 3 o'clock (right)
// //
// //     final List<Map<String, dynamic>> segments = [];
// //     for (int i = 0; i < segmentValues.length; i++) {
// //       double sweepAngle = (segmentValues[i] / totalValue) * 2 * math.pi;
// //       segments.add({
// //         'color': segmentColors[i],
// //         'startAngle': currentStartAngle,
// //         'sweepAngle': sweepAngle,
// //       });
// //       currentStartAngle += sweepAngle;
// //     }
// //
// //     // Determine drawing order of segments from back to front for correct layering
// //     // Based on `rotateX` and `rotateZ` values, the pink segment (bottom) is furthest back,
// //     // then teal (right), then blue (top-left).
// //     final List<Map<String, dynamic>> drawingOrderSegments = [
// //       segments[1], // Pink segment
// //       segments[2], // Teal segment
// //       segments[0], // Blue segment
// //     ];
// //
// //     // --- Draw each 3D segment ---
// //     for (var segmentData in drawingOrderSegments) {
// //       _drawSegment(
// //         canvas,
// //         Offset
// //             .zero, // Drawing relative to (0,0) as canvas is already translated and transformed
// //         outerRadius,
// //         innerRadius,
// //         thickness,
// //         segmentData['startAngle'],
// //         segmentData['sweepAngle'],
// //         segmentData['color'],
// //       );
// //     }
// //
// //     canvas.translate(
// //       -center.dx,
// //       -center.dy,
// //     ); // Translate back the canvas origin
// //     canvas.restore(); // Restore the canvas to its state before `save()`
// //   }
// //
// //   // Helper method to draw a single 3D segment of the donut
// //   void _drawSegment(
// //       Canvas canvas,
// //       Offset center, // This is (0,0) in the currently transformed canvas space
// //       double outerR,
// //       double innerR,
// //       double
// //       thick, // This 'thick' is the perceived height along the transformed Y-axis
// //       double startAngle,
// //       double sweepAngle,
// //       Color color,
// //       ) {
// //     // Define rectangles for the top and bottom surfaces of the arcs
// //     // 'center' is (0,0) here due to the parent transform.
// //     final Rect outerRectTop = Rect.fromCircle(center: center, radius: outerR);
// //     final Rect innerRectTop = Rect.fromCircle(center: center, radius: innerR);
// //
// //     // The bottom surfaces are offset by 'thick' along the transformed Y-axis (simulating Z-depth)
// //     final Rect outerRectBottom = Rect.fromCircle(
// //       center: center.translate(0, thick),
// //       radius: outerR,
// //     );
// //     final Rect innerRectBottom = Rect.fromCircle(
// //       center: center.translate(0, thick),
// //       radius: innerR,
// //     );
// //
// //     // Calculate different shades of the base color to simulate lighting on different surfaces
// //     final Color topColor = color;
// //     final Color sideColor = _darkenColor(
// //       color,
// //       0.15,
// //     ); // For outer and radial walls
// //     final Color innerWallColor = _darkenColor(
// //       color,
// //       0.25,
// //     ); // For inner wall (more shadowed)
// //     final Color bottomColor = _darkenColor(
// //       color,
// //       0.3,
// //     ); // For bottom surface (most shadowed)
// //
// //     // Helper function to get a point on an arc, including the Y-offset for depth
// //     Offset _getPointOnArcWithDepth(
// //         Offset c,
// //         double r,
// //         double angle,
// //         double yOffset,
// //         ) {
// //       return Offset(
// //         c.dx + r * math.cos(angle),
// //         c.dy + r * math.sin(angle) + yOffset,
// //       );
// //     }
// //
// //     // --- Create Paths for each face of the segment ---
// //
// //     // Top Surface Path
// //     final Path topSurfacePath = Path()
// //       ..addArc(outerRectTop, startAngle, sweepAngle)
// //       ..arcTo(innerRectTop, startAngle + sweepAngle, -sweepAngle, false)
// //       ..close();
// //
// //     // Bottom Surface Path
// //     final Path bottomSurfacePath = Path()
// //       ..addArc(outerRectBottom, startAngle, sweepAngle)
// //       ..arcTo(innerRectBottom, startAngle + sweepAngle, -sweepAngle, false)
// //       ..close();
// //
// //     // Inner Wall Path (connects top inner arc to bottom inner arc)
// //     final Path innerWallPath = Path()
// //       ..arcTo(innerRectTop, startAngle, sweepAngle, false)
// //       ..lineTo(
// //         _getPointOnArcWithDepth(
// //           center,
// //           innerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dx,
// //         _getPointOnArcWithDepth(
// //           center,
// //           innerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dy,
// //       )
// //       ..arcTo(innerRectBottom, startAngle + sweepAngle, -sweepAngle, false)
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, innerR, startAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, innerR, startAngle, 0).dy,
// //       )
// //       ..close();
// //
// //     // Outer Wall Path (connects top outer arc to bottom outer arc)
// //     final Path outerWallPath = Path()
// //       ..arcTo(outerRectTop, startAngle, sweepAngle, false)
// //       ..lineTo(
// //         _getPointOnArcWithDepth(
// //           center,
// //           outerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dx,
// //         _getPointOnArcWithDepth(
// //           center,
// //           outerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dy,
// //       )
// //       ..arcTo(outerRectBottom, startAngle + sweepAngle, -sweepAngle, false)
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, outerR, startAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, outerR, startAngle, 0).dy,
// //       )
// //       ..close();
// //
// //     // Radial Start Side Path (flat surface at the beginning of the arc)
// //     final Path startSidePath = Path()
// //       ..moveTo(
// //         _getPointOnArcWithDepth(center, innerR, startAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, innerR, startAngle, 0).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, outerR, startAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, outerR, startAngle, 0).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, outerR, startAngle, thick).dx,
// //         _getPointOnArcWithDepth(center, outerR, startAngle, thick).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, innerR, startAngle, thick).dx,
// //         _getPointOnArcWithDepth(center, innerR, startAngle, thick).dy,
// //       )
// //       ..close();
// //
// //     // Radial End Side Path (flat surface at the end of the arc)
// //     final Path endSidePath = Path()
// //       ..moveTo(
// //         _getPointOnArcWithDepth(center, innerR, startAngle + sweepAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, innerR, startAngle + sweepAngle, 0).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(center, outerR, startAngle + sweepAngle, 0).dx,
// //         _getPointOnArcWithDepth(center, outerR, startAngle + sweepAngle, 0).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(
// //           center,
// //           outerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dx,
// //         _getPointOnArcWithDepth(
// //           center,
// //           outerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dy,
// //       )
// //       ..lineTo(
// //         _getPointOnArcWithDepth(
// //           center,
// //           innerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dx,
// //         _getPointOnArcWithDepth(
// //           center,
// //           innerR,
// //           startAngle + sweepAngle,
// //           thick,
// //         ).dy,
// //       )
// //       ..close();
// //
// //     // --- Draw the paths in order from back to front for proper layering ---
// //     canvas.drawPath(bottomSurfacePath, Paint()..color = bottomColor);
// //     canvas.drawPath(innerWallPath, Paint()..color = innerWallColor);
// //     canvas.drawPath(outerWallPath, Paint()..color = sideColor);
// //     canvas.drawPath(startSidePath, Paint()..color = sideColor);
// //     canvas.drawPath(endSidePath, Paint()..color = sideColor);
// //     canvas.drawPath(topSurfacePath, Paint()..color = topColor);
// //   }
// //
// //   // Helper function to darken a given color
// //   Color _darkenColor(Color color, [double amount = .1]) {
// //     assert(amount >= 0 && amount <= 1);
// //     final hsl = HSLColor.fromColor(color);
// //     final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
// //     return hslDark.toColor();
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant ThreeDDonutChartPainter oldDelegate) {
// //     return false; // The chart is static, no need to repaint
// //   }
// // }
//
//
// import 'dart:math' as math;
// import 'package:db_atom/index.dart';
//
//
//
// class BasePyramidCharts extends StatefulWidget {
//   final List<PieChartData> chartData;
//   final String chartTitle;
//   final Widget? moreIcon;
//
//   const BasePyramidCharts({
//     super.key,
//     required this.chartTitle,
//     required this.chartData,
//     this.moreIcon,
//   });
//
//   @override
//   State<BasePyramidCharts> createState() => _BasePyramidChartsState();
// }
//
// class _BasePyramidChartsState extends State<BasePyramidCharts> {
//   bool isChartVisible = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white10,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.chartTitle,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 if (widget.moreIcon != null) widget.moreIcon!,
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             // Chart or No Data
//             widget.chartData.isEmpty
//                 ? Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Data Found',
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//               ),
//             )
//                 : Center(
//               child: SizedBox(
//                 width: 350,
//                 height: 350,
//                 child: CustomPaint(
//                   painter: ThreeDDonutChartPainter(widget.chartData),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             // Custom Legend (scrollable row)
//             if (widget.chartData.isNotEmpty)
//               SizedBox(
//                 height: 50,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: widget.chartData.map((data) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 6),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: data.color, width: 1.5),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: data.color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${data.x} (${data.y.toStringAsFixed(1)}%)',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ------------------------ 3D Donut Painter ------------------------
//
// class ThreeDDonutChartPainter extends CustomPainter {
//   final List<PieChartData> chartData;
//
//   ThreeDDonutChartPainter(this.chartData);
//
//   final double outerRadius = 100;
//   final double innerRadius = 60;
//   final double thickness = 30;
//   final double rotationZ = -math.pi * 0.15;
//   final double tiltX = 0.5;
//   final double perspectiveFactor = 0.0008;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (chartData.isEmpty) return;
//
//     final center = Offset(size.width / 2, size.height / 2);
//     canvas.save();
//
//     final Matrix4 matrix = Matrix4.identity()
//       ..setEntry(3, 2, perspectiveFactor)
//       ..rotateX(tiltX)
//       ..rotateZ(rotationZ);
//
//     canvas.translate(center.dx, center.dy);
//     canvas.transform(matrix.storage);
//
//     // Compute total
//     double total = chartData.fold(0, (sum, item) => sum + item.y);
//     double startAngle = 0;
//
//     for (var data in chartData) {
//       final sweep = (data.y / total) * 2 * math.pi;
//       _drawSegment(canvas, Offset.zero, outerRadius, innerRadius, thickness,
//           startAngle, sweep, data.color);
//       startAngle += sweep;
//     }
//
//     canvas.restore();
//   }
//
//   void _drawSegment(Canvas canvas, Offset center, double outerR, double innerR,
//       double thick, double startAngle, double sweepAngle, Color color) {
//     final Rect outerTop = Rect.fromCircle(center: center, radius: outerR);
//     final Rect innerTop = Rect.fromCircle(center: center, radius: innerR);
//     final Rect outerBottom =
//     Rect.fromCircle(center: center.translate(0, thick), radius: outerR);
//     final Rect innerBottom =
//     Rect.fromCircle(center: center.translate(0, thick), radius: innerR);
//
//     final topColor = color;
//     final sideColor = _darken(color, 0.15);
//     final innerWallColor = _darken(color, 0.25);
//     final bottomColor = _darken(color, 0.3);
//
//     Path top = Path()
//       ..addArc(outerTop, startAngle, sweepAngle)
//       ..arcTo(innerTop, startAngle + sweepAngle, -sweepAngle, false)
//       ..close();
//
//     Path bottom = Path()
//       ..addArc(outerBottom, startAngle, sweepAngle)
//       ..arcTo(innerBottom, startAngle + sweepAngle, -sweepAngle, false)
//       ..close();
//
//     canvas.drawPath(bottom, Paint()..color = bottomColor);
//     canvas.drawPath(top, Paint()..color = topColor);
//
//     // Outer side
//     final Path outerSide = Path()
//       ..moveTo(
//           center.dx + outerR * math.cos(startAngle),
//           center.dy + outerR * math.sin(startAngle))
//       ..arcTo(outerTop, startAngle, sweepAngle, false)
//       ..lineTo(center.dx + outerR * math.cos(startAngle + sweepAngle),
//           center.dy + outerR * math.sin(startAngle + sweepAngle) + thick)
//       ..arcTo(outerBottom, startAngle + sweepAngle, -sweepAngle, false)
//       ..close();
//
//     canvas.drawPath(outerSide, Paint()..color = sideColor);
//   }
//
//   Color _darken(Color color, [double amount = .1]) {
//     final hsl = HSLColor.fromColor(color);
//     final hslDark =
//     hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
//     return hslDark.toColor();
//   }
//
//   @override
//   bool shouldRepaint(covariant ThreeDDonutChartPainter oldDelegate) => false;
// }
