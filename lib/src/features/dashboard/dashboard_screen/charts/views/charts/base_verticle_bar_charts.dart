// // // // import 'package:db_atom/app.dart';
// // // // import 'package:db_atom/index.dart';
// // // //
// // // // class BaseVerticleBarCharts extends StatefulWidget {
// // // //   final List<PieChartData> chartData;
// // // //   final String chartTitle;
// // // //   final Widget moreIcon;
// // // //   final List<List<Color>> gradientColors; // Each bar has its own gradient
// // // //
// // // //   const BaseVerticleBarCharts({
// // // //     super.key,
// // // //     required this.chartTitle,
// // // //     required this.moreIcon,
// // // //     required this.chartData,
// // // //     required this.gradientColors,
// // // //
// // // //   });
// // // //
// // // //   @override
// // // //   BaseVerticleBarChartsState createState() => BaseVerticleBarChartsState();
// // // // }
// // // //
// // // // class BaseVerticleBarChartsState extends State<BaseVerticleBarCharts> {
// // // //   bool isChartVisible = true;
// // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Column(
// // // // //       mainAxisAlignment: MainAxisAlignment.start,
// // // // //       children: [
// // // // //         Visibility(
// // // // //           visible: isChartVisible,
// // // // //           child: Container(
// // // // //             height: 300,
// // // // //             width: 350,
// // // // //             decoration: const ShapeDecoration(
// // // // //               color: AppColors.white,
// // // // //               shape: RoundedRectangleBorder(
// // // // //                 borderRadius: BorderRadius.vertical(
// // // // //                   top: Radius.circular(0.0),
// // // // //                   bottom: Radius.circular(0.0),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 Row(
// // // // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                   children: [
// // // // //                     Padding(
// // // // //                       padding: const EdgeInsets.all(8.0),
// // // // //                       child: Text(
// // // // //                         widget.chartTitle,
// // // // //       style: const TextStyle(
// // // // //                           fontWeight: FontWeight.bold,
// // // // //                           color: AppColors.navigationSkyBlueColor,
// // // // //                           fontSize: 16,
// // // // //                   ),
// // // //                    ),
// // // // //                     ),
// // // // //                     // IconButton(
// // // // //                     //   icon: const Icon(Icons.cancel_rounded),
// // // // //                     //   onPressed: () {
// // // // //                     //     setState(() {
// // // // //                     //       isChartVisible = false;
// // // // //                     //     });
// // // // //                     //   },
// // // // //                     // ),
// // // // //                   ],
// // // // //                 ),
// // // // //                 widget.chartData.isEmptyOrNull
// // // // //                     ? const Padding(
// // // // //                         padding: EdgeInsets.only(top: 100.0),
// // // // //                         child: Center(
// // // // //                           child: Text('No Data Found.'),
// // // // //                         ),
// // // // //                       )
// // // // //                     : Expanded(
// // // // //                         child: SfCartesianChart(
// // // // //                           primaryXAxis: const NumericAxis(),
// // // // //                           primaryYAxis: const NumericAxis(),
// // // // //                           series: <CartesianSeries>[
// // // // //                             StackedColumnSeries<PieChartData, num>(
// // // // //                               enableTooltip: true,
// // // // //                               dataLabelSettings: const DataLabelSettings(
// // // // //                                 isVisible: true,
// // // // //                                 labelPosition: ChartDataLabelPosition.outside,
// // // // //                                 labelAlignment: ChartDataLabelAlignment.outer,
// // // // //                               ),
// // // // //                               dataSource: widget.chartData,
// // // // //                               xValueMapper: (PieChartData data, _) =>
// // // // //                                   widget.chartData.indexOf(data),
// // // // //                               yValueMapper: (PieChartData data, _) => data.y,
// // // // //                               pointColorMapper: (PieChartData data, _) =>
// // // // //                                   data.color,
// // // // //                               emptyPointSettings: const EmptyPointSettings(
// // // // //                                 mode: EmptyPointMode.average,
// // // // //                               ),
// // // // //                             ),
// // // // //                           ],
// // // // //                           tooltipBehavior: TooltipBehavior(
// // // // //                             enable: true,
// // // // //                             builder: (dynamic data,
// // // // //                                 dynamic point,
// // // // //                                 dynamic series,
// // // // //                                 int pointIndex,
// // // // //                                 int seriesIndex) {
// // // // //                               return Container(
// // // // //                                 padding: const EdgeInsets.all(8),
// // // // //                                 decoration: BoxDecoration(
// // // // //                                   color: Colors.white,
// // // // //                                   borderRadius: BorderRadius.circular(5),
// // // // //                                   boxShadow: [
// // // // //                                     BoxShadow(
// // // // //                                         color: Colors.black.withOpacity(0.2),
// // // // //                                         spreadRadius: 2,
// // // // //                                         blurRadius: 5),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                                 child: Text(
// // // // //                                   '${data.x} : ${data.y}',
// // // // //                                   style: const TextStyle(color: Colors.black),
// // // // //                                 ),
// // // // //                               );
// // // // //                             },
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // //
// // // //   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.4),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blueAccent.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           widget.chartTitle,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                             fontSize: 19,
//                           ),
//                         ),
//                       ),
//                     ),
//                     if (widget.moreIcon != null) widget.moreIcon!,
//                   ],
//                 ),
//               ],),
//
//             const SizedBox(height: 12),
//
//             // Chart or No Data
//             widget.chartData.isEmpty
//                 ? Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Data Found',
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//               ),
//             )
//                 : SizedBox(
//               height: 300,
//               // width: 900,
//               // child: SfCartesianChart(
//               //   backgroundColor: Colors.white.withValues(alpha: 0.5),
//               //   tooltipBehavior: TooltipBehavior(enable: true),
//               //   // primaryXAxis: const CategoryAxis(
//               //   //   labelStyle: TextStyle(color: Colors.black),
//               //   // ),
//               //   // primaryYAxis: const NumericAxis(
//               //   //   labelStyle: TextStyle(color: Colors.black),
//               //   // ),
//               //   primaryXAxis: const CategoryAxis(
//               //     labelStyle: TextStyle(color: Colors.black),
//               //     axisLine: AxisLine(color: Colors.black, width: 0.8),
//               //
//               //   ),
//               //   primaryYAxis: const NumericAxis(
//               //     labelStyle: TextStyle(color: Colors.black),
//               //     axisLine: AxisLine(color: Colors.black, width: 0.8),
//               //   ),
//               //   series: <CartesianSeries>[
//               //     ColumnSeries<PieChartData, String>(
//               //       dataSource: widget.chartData,
//               //       xValueMapper: (PieChartData data, _) => data.x,
//               //       yValueMapper: (PieChartData data, _) => data.y,
//               //       // pointColorMapper: (PieChartData data, _) =>
//               //       // data.color,
//               //       pointColorMapper: (PieChartData data, index) =>
//               //       customColors[index % presetColors.length],
//               //       dataLabelSettings: const DataLabelSettings(
//               //         isVisible: true,
//               //         textStyle: TextStyle(color: Colors.black),
//               //       ),
//               //       enableTooltip: true,
//               //       width: 0.3,
//               //       borderRadius: const BorderRadius.only(
//               //         topLeft: Radius.circular(6),
//               //         topRight: Radius.circular(6),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//
//       //       child: SfCartesianChart(
//       //           backgroundColor: Colors.white.withOpacity(0.5),
//       //   tooltipBehavior: TooltipBehavior(enable: true),
//       //   primaryXAxis: const CategoryAxis(
//       //     labelStyle: TextStyle(color: Colors.black),
//       //     axisLine: AxisLine(color: Colors.black, width: 0.8),
//       //   ),
//       //   primaryYAxis: const NumericAxis(
//       //     labelStyle: TextStyle(color: Colors.black),
//       //     axisLine: AxisLine(color: Colors.black, width: 0.8),
//       //   ),
//       //   series: <CartesianSeries>[
//       //     ColumnSeries<PieChartData, String>(
//       //       dataSource: widget.chartData,
//       //       xValueMapper: (PieChartData data, _) => data.x,
//       //       yValueMapper: (PieChartData data, _) => data.y,
//       //       pointColorMapper: (PieChartData data, index) => customColors[index % presetColors.length],
//       //       width: 0.35, // make bars thicker for better 3D look
//       //       borderRadius: const BorderRadius.only(
//       //         topLeft: Radius.circular(6),
//       //         topRight: Radius.circular(6),
//       //       ),
//       //       dataLabelSettings: const DataLabelSettings(
//       //         isVisible: true,
//       //         textStyle: TextStyle(color: Colors.black),
//       //       ),
//       //       enableTooltip: true,
//       //       // Simulate 3D with gradient fill
//       //       gradient: LinearGradient(
//       //         begin: Alignment.topCenter,
//       //         end: Alignment.bottomCenter,
//       //         colors: [
//       //           Colors.white.withOpacity(0.3),
//       //           customColors[0 % customColors.length], // top lighter
//       //           customColors[0 % customColors.length].withOpacity(0.8), // bottom darker
//       //         ],
//       //       ),
//       //       // Shadow effect
//       //       borderWidth: 0,
//       //       spacing: 0.2,
//       //     ),
//       //   ],
//       // )
//                 child:  SfCartesianChart(
//             backgroundColor: Colors.white.withOpacity(0.5),
//         tooltipBehavior: TooltipBehavior(enable: true),
//         primaryXAxis: CategoryAxis(
//           labelStyle: const TextStyle(color: Colors.black),
//           axisLine: const AxisLine(color: Colors.black, width: 0.8),
//         ),
//         primaryYAxis: NumericAxis(
//           labelStyle: const TextStyle(color: Colors.black),
//           axisLine: const AxisLine(color: Colors.black, width: 0.8),
//         ),
//         series: <CartesianSeries>[
//           ColumnSeries<PieChartData, String>(
//             dataSource:  widget.chartData,
//             xValueMapper: (PieChartData data, _) => data.x,
//             yValueMapper: (PieChartData data, _) => data.y,
//             width: 0.7, // Thicker bars for better 3D illusion
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(8),
//               topRight: Radius.circular(8),
//             ),
//             // pointColorMapper: (PieChartData data, index) => customColors[index % customColors.length],
//             dataLabelSettings: const DataLabelSettings(
//               isVisible: true,
//               textStyle: TextStyle(color: Colors.black),
//             ),
//             enableTooltip: true,
//
//             // Gradient for pseudo-light effect
//             pointColorMapper: (PieChartData data, index) {
//               // Create a gradient for each bar by using a custom Paint
//               return customColors[index % customColors.length];
//             },
//             // Shadow effect using decoration (inside chart, pseudo)
//             // Note: Flutter Charts doesn't directly support shadow, so we use gradient + thickness
//             spacing: 0.2, // Slight gap between bars to emphasize depth
//           ),
//         ],
//       )
//     ),
//
//             const SizedBox(height: 10),
//
//             // Custom Scrollable Legend
//             if (widget.chartData.isNotEmpty)
//               SizedBox(
//                 height: 50,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: widget.chartData.map((data) {
//                       final color = customColors[
//                       widget.chartData.indexOf(data) %
//                           customColors.length];
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 6),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: color, width: 1.5),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${data.x} (${data.y}%)',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF333333),
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
//   }}
// // //
// // // //
// // // //
// // // // // final List<Color> presetColors = [
// // // // //   const Color(0xFF0093F9),
// // // // //   const Color(0xFF15CAB4),
// // // // //   const Color(0xFFFFA516),
// // // // //   const Color(0xFFFF4051),
// // // // //   const Color(0xFF9665ED),
// // // // //   const Color(0xFFB2DEFD),
// // // // //   const Color(0xFF007bff),
// // // // //   const Color(0xFF6610f2),
// // // // //   const Color(0xFF6f42c1),
// // // // //   const Color(0xFFe83e8c),
// // // // //   const Color(0xFFdc3545),
// // // // //   const Color(0xFFfd7e14),
// // // // //   const Color(0xFFffc107),
// // // // //   const Color(0xFF28a745),
// // // // //   const Color(0xFF20c997),
// // // // //   const Color(0xFF17a2b8),
// // // // // ];
// // // // //
// // // // // final List<Color> customColors = [ // const Color(0xFFffc107),
// // // // //   const Color(0xFF1E40AF),
// // // // //   const Color(0xFF2563EB),
// // // // //   const Color(0xFF6366F1),
// // // // //   const Color(0xFF4B67F2),
// // // // //   const Color(0xFF3B82F6),
// // // // //   const Color(0xFF0EA5E9),
// // // // //   const Color(0xFF29C3D1),
// // // // //   const Color(0xFF22A9F3),
// // // // //   const Color(0xFFEC4899),
// // // // //   const Color(0xFFDB2777),
// // // // //   const Color(0xFFdc3545),
// // // // //   const Color(0xFFfd7e14),
// // // // //   const Color(0xFF14B8A6),
// // // // //   const Color(0xFF10B981),
// // // // //   const Color(0xFF84CC16),
// // // // //   const Color(0xFF28a745),
// // // // //   const Color(0xFF15803D),
// // // // // ];
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:syncfusion_flutter_charts/charts.dart';
// // // import 'package:db_atom/index.dart';
// // // //
// // // // class PieChartData {
// // // //   final String x;
// // // //   final double y;
// // // //   final Color? color;
// // // //
// // // //   PieChartData(String key, {
// // // //     required this.x,
// // // //     required this.y,
// // // //     this.color,
// // // //   });
// // // // }
// // //
// // // class BaseVerticleBarCharts extends StatefulWidget {
// // //   final String chartTitle;
// // //   final List<PieChartData> chartData;
// // //   final Widget? moreIcon;
// // //
// // //   const BaseVerticleBarCharts({
// // //     Key? key,
// // //     required this.chartTitle,
// // //     required this.chartData,
// // //     this.moreIcon,
// // //   }) : super(key: key);
// // //
// // //   @override
// // //   State<BaseVerticleBarCharts> createState() => _BaseVerticleBarChartsState();
// // // }
// // //
// // // class _BaseVerticleBarChartsState extends State<BaseVerticleBarCharts> with SingleTickerProviderStateMixin {
// // //   late AnimationController _animationController;
// // //   late Animation<double> _animation;
// // //   bool isChartVisible = true;
// // //
// // //   final List<Color> customColors = [
// // //     const Color(0xFFFFA500), // Orange
// // //     const Color(0xFFFF6B6B), // Red
// // //     const Color(0xFFFF1493), // Pink
// // //     const Color(0xFF9D4EDD), // Purple
// // //     const Color(0xFF5A189A), // Dark Purple
// // //     const Color(0xFF0096FF), // Blue
// // //     // const Color(0xFF00D4FF), // Cyan
// // //     // const Color(0xFF3A86FF), // Light Blue
// // //   ];
// // //
// // //   final List<Color> presetColors = [
// // //     const Color(0xFFFFA500),
// // //     const Color(0xFFFF6B6B),
// // //     const Color(0xFFFF1493),
// // //     const Color(0xFF9D4EDD),
// // //     const Color(0xFF5A189A),
// // //     // const Color(0xFF0096FF),
// // //   ];
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _animationController = AnimationController(
// // //       duration: const Duration(milliseconds: 1500),
// // //       vsync: this,
// // //     );
// // //
// // //     _animation = Tween<double>(begin: 0, end: 1).animate(
// // //       CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
// // //     );
// // //
// // //     _animationController.forward();
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _animationController.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.4),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blueAccent.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 4),
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
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       widget.chartTitle,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 19,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (widget.moreIcon != null) widget.moreIcon!,
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Chart or No Data
//             widget.chartData.isEmpty
//                 ? Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Data Found',
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//               ),
//             )
//                 : SizedBox(
//               height: 300,
//               child: AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   return SfCartesianChart(
//                     backgroundColor: Colors.white.withOpacity(0.5),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     primaryXAxis: const CategoryAxis(
//                       labelStyle: TextStyle(color: Colors.black),
//                       axisLine: AxisLine(
//                         color: Colors.black,
//                         width: 0.8,
//                       ),
//                     ),
//                     primaryYAxis: NumericAxis(
//                       labelStyle: const TextStyle(color: Colors.black),
//                       axisLine: const AxisLine(
//                         color: Colors.black,
//                         width: 0.8,
//                       ),
//                     ),
//                     series: <CartesianSeries>[
//                       // ColumnSeries<PieChartData, String>(
//                       //   dataSource: widget.chartData,
//                       //   xValueMapper: (PieChartData data, _) => data.x,
//                       //   yValueMapper: (PieChartData data, _) =>
//                       //   data.y * _animation.value,
//                       //   width: 0.5,
//                       //   borderRadius: const BorderRadius.only(
//                       //     topLeft: Radius.circular(8),
//                       //     topRight: Radius.circular(8),
//                       //   ),
//                       //   pointColorMapper: (PieChartData data, index) {
//                       //     return customColors[
//                       //     index % customColors.length];
//                       //   },
//                       //   dataLabelSettings:
//                       //   const DataLabelSettings(
//                       //     isVisible: true,
//                       //     textStyle:
//                       //     TextStyle(color: Colors.black),
//                       //   ),
//                       //   enableTooltip: true,
//                       //   spacing: 0,
//                       //   // 3D Gradient Effect
//                       //   gradient: LinearGradient(
//                       //     begin: Alignment.topCenter,
//                       //     end: Alignment.bottomCenter,
//                       //     colors: [
//                       //       // customColors[0].withOpacity(0.4),
//                       //       // customColors[0].withOpacity(0.9),
//                       //       // customColors[1].withO/pacity(0.4),
//                       //       customColors[1].withOpacity(0.9),
//                       //       customColors[2].withOpacity(0.4),
//                       //       customColors[2].withOpacity(0.9),
//                       //       // customColors[3].withOpacity(0.4),
//                       //       // customColors[3].withOpacity(0.9),
//                       //       // customColors[4].withOpacity(0.4),
//                       //       customColors[4].withOpacity(0.9),
//                       //       customColors[5].withOpacity(0.4),
//                       //       customColors[5].withOpacity(0.9),
//                       //     ],
//                       //   ),
//                       //
//                       // ),
//                       ColumnSeries<PieChartData, String>(
//                         dataSource: widget.chartData,
//                         xValueMapper: (PieChartData data, _) => data.x,
//                         yValueMapper: (PieChartData data, _) => data.y,
//                         width: 0.7,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(8),
//                           topRight: Radius.circular(8),
//                         ),
//                         // New: Use onCreateShader for 3D gradient
//                         onCreateShader: (details) {
//                           return LinearGradient(
//                             colors: [
//                               Colors.blue.shade800,   // Shadow
//                               Colors.blue.shade400,   // Main
//                               Colors.white.withOpacity(0.7), // Highlight
//                             ],
//                             stops: [0.0, 0.7, 1.0],
//                             begin: Alignment.bottomCenter,
//                             end: Alignment.topCenter,
//                           ).createShader(details.rect);
//                         },
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: true,
//                           textStyle: TextStyle(color: Colors.black),
//                         ),
//                         enableTooltip: true,
//                         spacing: 0.2,
//                       ),
//
//
//                     ],
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 10),
//
//             // Custom Scrollable Legend
//             if (widget.chartData.isNotEmpty)
//               SizedBox(
//                 height: 50,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: widget.chartData.map((data) {
//                       final color = customColors[
//                       widget.chartData.indexOf(data) %
//                           customColors.length];
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 6),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: color, width: 1.5),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${data.x} (${data.y}%)',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF333333),
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
// // import 'package:db_atom/index.dart' show color;
// // import 'package:flutter/material.dart';
// // import 'package:syncfusion_flutter_charts/charts.dart';
// //
// // import '../../../../../../../index.dart';
// //
// // // class PieChartData {
// // //   final String x;
// // //   final double y;
// // //   final Color? color;
// // //
// // //   PieChartData({required this.x, required this.y, this.color});
// // // }
// //
// // class BaseVerticleBarCharts extends StatefulWidget {
// //   final String chartTitle;
// //   final List<PieChartData> chartData;
// //   final Widget? moreIcon;
// //
// //   const BaseVerticleBarCharts({
// //     Key? key,
// //     required this.chartTitle,
// //     required this.chartData,
// //     this.moreIcon,
// //   }) : super(key: key);
// //
// //   @override
// //   State<BaseVerticleBarCharts> createState() => _BaseVerticleBarChartsState();
// // }
// //
// // class _BaseVerticleBarChartsState extends State<BaseVerticleBarCharts>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _animationController;
// //   late Animation<double> _animation;
// //   bool isChartVisible = true;
// //
// //   final List<Color> customColors = [
// //     const Color(0xFFFFA500), // Orange
// //     const Color(0xFFFF6B6B), // Red
// //     const Color(0xFFFF1493), // Pink
// //     const Color(0xFF9D4EDD), // Purple
// //     const Color(0xFF5A189A), // Dark Purple
// //     const Color(0xFF0096FF), // Blue
// //   ];
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _animationController = AnimationController(
// //       duration: const Duration(milliseconds: 1500),
// //       vsync: this,
// //     );
// //     _animation = Tween<double>(begin: 0, end: 1).animate(
// //       CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
// //     );
// //     _animationController.forward();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _animationController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.4),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blueAccent.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       widget.chartTitle,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 19,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (widget.moreIcon != null) widget.moreIcon!,
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Chart
//             widget.chartData.isEmpty
//                 ? Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Data Found',
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//               ),
//             )
//                 : SizedBox(
//               height: 300,
//               child: AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   return SfCartesianChart(
//                     backgroundColor: Colors.white.withOpacity(0.5),
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     primaryXAxis: const CategoryAxis(
//                       labelStyle: TextStyle(color: Colors.black),
//                       axisLine: AxisLine(color: Colors.black, width: 0.8),
//                     ),
//                     primaryYAxis: NumericAxis(
//                       labelStyle: const TextStyle(color: Colors.black),
//                       axisLine: const AxisLine(color: Colors.black, width: 0.8),
//                     ),
//                     series: <CartesianSeries>[
//                       ColumnSeries<PieChartData, String>(
//                         dataSource: widget.chartData,
//                         xValueMapper: (PieChartData data, _) => data.x,
//                         yValueMapper: (PieChartData data, _) => data.y * _animation.value,
//                         width: 0.7,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(15),
//                           topRight: Radius.circular(15),
//                         ),
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: true,
//                           textStyle: TextStyle(color: Colors.black),
//                         ),
//                         enableTooltip: true,
//                         spacing: 0.2,
//                         // Assign a base color per bar
//                         pointColorMapper: (PieChartData data, index) => customColors[index % customColors.length],
//                         // Generic gradient for 3D cylinder look
//                         onCreateShader: (ShaderDetails details) {
//                           return LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.white.withOpacity(0.7), // top highlight
//                               Colors.blueAccent.shade400,    // middle
//                               Colors.blueAccent.shade200,    // bottom shadow
//                             ],
//                             stops: const [0.0, 0.5, 1.0],
//                           ).createShader(details.rect);
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//
//             ),
//             const SizedBox(height: 10),
//
//             // Legend
//             if (widget.chartData.isNotEmpty)
//               SizedBox(
//                 height: 50,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: widget.chartData.map((data) {
//                       final color = customColors[widget.chartData.indexOf(data) % customColors.length];
//                       return Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 6),
//                         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           color: Colors.white30,
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: color, width: 1.5),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${data.x} (${data.y}%)',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xFF333333),
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
// import 'dart:async';
//
// import 'package:db_atom/index.dart' show color;
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:math';
// import '../../../../../../../index.dart';
// class BaseVerticleBarCharts extends StatefulWidget {
//   final String chartTitle;
//   final List<PieChartData> chartData;
//   final Widget? moreIcon;
//
//   const BaseVerticleBarCharts({
//     Key? key,
//     required this.chartTitle,
//     required this.chartData,
//     this.moreIcon,
//   }) : super(key: key);
//
//   @override
//   State<BaseVerticleBarCharts> createState() => _BaseVerticleBarChartsState();
// }
//
// class _BaseVerticleBarChartsState extends State<BaseVerticleBarCharts>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool isChartVisible = true;
//   late ZoomPanBehavior _zoomPanBehavior;
//    CrosshairBehavior? _crosshairBehavior;
//    TrackballBehavior? _trackballBehavior;
//   bool _enableAxisAnimation = true;
//   late Timer _timer;
//
//
//   // Map to hold top oval colors for 3D effect
//   final Map<String, Color> topOvalColors = {};
//   //
//   // final List<Color> cylinderColors = [
//   //   const Color(0xFFFFA500),
//   //   const Color(0xFFFF6B6B),
//   //   const Color(0xFFFF1493),
//   //   const Color(0xFF9D4EDD),
//   //   const Color(0xFF5A189A),
//   //   const Color(0xFF0096FF),
//   // ];
//
//   @override
//   void initState() {
//     super.initState();
//     _crosshairBehavior = CrosshairBehavior(enable: true);
//
//     // Other initializations...
//     //
//     Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         // Recreate the behavior with toggled 'enable'
//         _crosshairBehavior = CrosshairBehavior(
//           enable: _crosshairBehavior!.enable,
//           lineType: CrosshairLineType.both,
//           lineColor: Colors.black54,
//           lineWidth: 1,
//         );
//       });
//     });
//     // Timer.periodic(Duration(seconds: 5), (timer) {
//     //   setState(() {
//     //     // Example zoom in by factor 0.5 (50%)
//     //     _zoomPanBehavior.zoomByFactor(0.5);
//     //
//     //     // Or reset zoom periodically
//     //     // _zoomPanBehavior.reset();
//     //   });
//     // });
//
//     // Timer for toggling behaviors
//     // Timer.periodic(Duration(seconds:5), (timer) {
//     //   setState(() {
//     //     // Example: toggle crosshair
//     //     _crosshairBehavior!.enable!= !_crosshairBehavior!.enable;
//     //
//     //     // Example: animate zoom to a different scale
//     //     // _zoomPanBehavior.zoomToScale(
//     //     //   2, // zoom to 200%
//     //     //   Duration(milliseconds: 500),
//     //     //   zoomPosition: Offset(0.5, 0.5),
//     //     // );
//     //
//     //     // Example: toggle trackball
//     //     // _trackballBehavior!.enable! = !_trackballBehavior!.enable;
//     //   });
//     // });
//     // Assign top oval colors (slightly brighter)
//     for (int i = 0; i < widget.chartData.length; i++) {
//       topOvalColors[widget.chartData[i].x] =
//           customColors[i % customColors.length].withOpacity(0.8);
//     }
//
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
//     );
//
//
//     _animationController.forward();
//     _zoomPanBehavior = ZoomPanBehavior(
//       enablePinching: true,
//       enablePanning: true,
//       enableDoubleTapZooming: true,
//       enableSelectionZooming: true,
//       // Callbacks for zoom start and end can be added in widget build using onZoomStart and onZoomEnd properties
//     );
//
//     _crosshairBehavior = CrosshairBehavior(
//       enable: true,
//       lineType: CrosshairLineType.both, // vertical and horizontal lines
//       lineColor: Colors.black54,
//       lineWidth: 1,
//     );
//
//     _trackballBehavior = TrackballBehavior(
//       enable: true,
//       tooltipSettings: InteractiveTooltip(
//         enable: true,
//       ),
//       activationMode: ActivationMode.singleTap,
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
//         padding: const EdgeInsets.all(10),
//         // decoration: BoxDecoration(
//         //   color: Colors.white.withOpacity(0.4),
//         //   borderRadius: BorderRadius.circular(10),
//         //   border: Border.all(
//         //     color: Colors.white.withValues(alpha: 1),
//         //     width: 1,
//         //   ),
//         //   boxShadow: [
//         //     BoxShadow(
//         //       color: Colors.black.withOpacity(0.1),
//         //       blurRadius: 20,
//         //       offset: const Offset(0, 4),
//         //     ),
//         //   ],
//         // ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white.withValues(alpha: 0.3),
//               Colors.transparent,
//               Colors.white.withValues(alpha: 0.3),
//               // Color(0xFF6474C6).withOpacity(0.14)
//             ],
//             stops: [0.02, 0.35, 1],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(27),
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.80),
//             width: 0.8,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF6474C6).withValues(alpha: 0.09),
//               blurRadius: 12,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       widget.chartTitle,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                         fontSize: 19,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (widget.moreIcon != null) widget.moreIcon!,
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Chart
//             widget.chartData.isEmpty
//                 ? Container(
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Text(
//                   'No Data Found',
//                   style: TextStyle(color: Colors.black54, fontSize: 14),
//                 ),
//               ),
//             )
//                 : SizedBox(
//               height: 300,
//               child: AnimatedBuilder(
//                 animation: _animation,
//                 builder: (context, child) {
//                   return SfCartesianChart(
//                     backgroundColor: Colors.white30,
//                       borderColor: Colors.white,
//                       borderWidth: 0.9,
//                     zoomPanBehavior: _zoomPanBehavior,
//                     crosshairBehavior: _crosshairBehavior,
//                     trackballBehavior: _trackballBehavior,
//                     enableAxisAnimation: _enableAxisAnimation,
//                     onZoomStart: (ZoomPanArgs args) {
//                       print('Zoom started: zoomFactor=${args.currentZoomFactor}, zoomPosition=${args.currentZoomPosition}');
//                     },
//                     onZoomEnd: (ZoomPanArgs args) {
//                       print('Zoom ended: zoomFactor=${args.currentZoomFactor}, zoomPosition=${args.currentZoomPosition}');
//                     },
//                     onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
//                       print('Touch interaction moved: position=${args.position}');
//                     },
//                     tooltipBehavior: TooltipBehavior(enable: true),
//                     primaryXAxis: const CategoryAxis(
//                       labelStyle: TextStyle(color: Colors.black),
//                       axisLine: AxisLine(color: Colors.black, width: 0.8),
//                     ),
//                     primaryYAxis: const NumericAxis(
//                       labelStyle: TextStyle(color: Colors.black),
//                       axisLine:
//                       AxisLine(color: Colors.black, width: 0.8),
//                     ),
//                     series: <CartesianSeries>[
//                       ColumnSeries<PieChartData, String>(
//                         dataSource: widget.chartData,
//                         xValueMapper: (data, _) => data.x,
//                         yValueMapper: (data, _) => data.y * _animation.value,
//                         width: 0.7,
//                         pointColorMapper: (data, index) =>
//                         customColors[index % customColors.length],
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: false,  // hide labels as per image style
//                         ),
//                         enableTooltip: true,
//                         spacing: 0.2,
//                         onCreateRenderer: (series) => _CustomColumn3DRenderer(topOvalColors),
//                       ),
//
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
            // Legend
            // if (widget.chartData.isNotEmpty)
            //   SizedBox(
            //     height: 50,
            //     child: SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: widget.chartData.map((data) {
            //           final color = customColors[
            //           widget.chartData.indexOf(data) % customColors.length];
            //           return Container(
            //             margin: const EdgeInsets.symmetric(horizontal: 6),
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 12, vertical: 6),
            //             decoration: BoxDecoration(
            //               color: Colors.white30,
            //               borderRadius: BorderRadius.circular(30),
            //               border: Border.all(color: color, width: 1.5),
            //             ),
            //             child: Row(
            //               children: [
            //                 Container(
            //                   width: 10,
            //                   height: 10,
            //                   decoration: BoxDecoration(
            //                     color: color,
            //                     shape: BoxShape.circle,
            //                   ),
            //                 ),
            //                 const SizedBox(width: 6),
            //                 Text(
            //                   '${data.x} (${data.y}%)',
            //                   style: const TextStyle(
            //                     fontSize: 13,
            //                     fontWeight: FontWeight.w500,
            //                     color: Color(0xFF333333),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           );
            //         }).toList(),
            //       ),
            //     ),
            //   ),
      //     ],
      //   ),
      // ),
//     );
//   }
// }
//
// /// Custom renderer for 3D effect
// /// Custom renderer for 3D effect — make sure generics match your series type
// class _CustomColumn3DRenderer extends ColumnSeriesRenderer<PieChartData, String> {
//   final Map<String, Color> topOvalColors;
//   _CustomColumn3DRenderer(this.topOvalColors);
//
//   @override
//   ColumnSegment<PieChartData, String> createSegment() {
//     return _Custom3DColumnSegment(topOvalColors);
//   }
// }
//
// class _Custom3DColumnSegment extends ColumnSegment<PieChartData, String> {
//   final Map<String, Color> topOvalColors;
//   _Custom3DColumnSegment(this.topOvalColors);
//
//
//
// // Draws a regular octagon in a given rect
//   Path _octagonPath(Rect rect) {
//     final double cx = rect.center.dx;
//     final double cy = rect.bottom - (rect.height / 2);
//     final double r = rect.width / 2;
//     final double angleStep = pi / 4;
//     Path path = Path();
//     for (int i = 0; i < 8; ++i) {
//       double angle = angleStep * i - pi / 8; // small rotation for visual match
//       double x = cx + r * cos(angle);
//       double y = cy + r * sin(angle);
//       if (i == 0) path.moveTo(x, y);
//       else path.lineTo(x, y);
//     }
//     path.close();
//     return path;
//   }
//
//   @override
//   void onPaint(Canvas canvas) {
//     final int sides = 8;
//     final Rect barRect;
//     if (segmentRect is RRect) {
//       barRect = (segmentRect as RRect).outerRect;
//     } else if (segmentRect is Rect) {
//       barRect = segmentRect as Rect;
//     } else {
//       throw Exception('segmentRect is not a Rect or RRect');
//     }
//     final String category = series.xRawValues[currentSegmentIndex]!;
//
//     // Animate growing from bottom to top
//     final double barHeight = barRect.height * animationFactor;
//     final Rect paintRect = Rect.fromLTRB(
//       barRect.left, barRect.bottom - barHeight,
//       barRect.right, barRect.bottom,
//     );
//
//     // Draw bar shadow (slightly offset and blurred)
//     final Path shadowPath = _octagonPath(paintRect.inflate(8).translate(6, 11));
//     canvas.drawPath(
//       shadowPath,
//       Paint()
//         ..color = Colors.black26
//         ..maskFilter = MaskFilter.blur(BlurStyle.normal, 12),
//     );
//
//     // Vertical/diagonal gradient for 3D body
//     final LinearGradient gradient = LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         topOvalColors[category] ?? Colors.white.withOpacity(0.9),
//         topOvalColors[category]?.withOpacity(0.92) ?? Colors.grey.withOpacity(0.92)
//       ],
//     );
//     final Paint barPaint = Paint()
//       ..shader = gradient.createShader(paintRect);
//
//     // Draw the main octagonal bar
//     final Path barPath = _octagonPath(paintRect);
//     canvas.drawPath(barPath, barPaint);
//
//     // Top cap highlight (octagon, slightly brighter)
//     final Rect topCap = Rect.fromCenter(
//       center: Offset(paintRect.center.dx, paintRect.top + (paintRect.width * 0.13)),
//       width: paintRect.width,
//       height: paintRect.width * 0.82,
//     );
//     final Path topPolygon = _octagonPath(topCap);
//     final Paint topPaint = Paint()
//       ..color = (topOvalColors[category] ?? Colors.red).withOpacity(0.97);
//     canvas.drawPath(topPolygon, topPaint);
//
//     // Bottom cap (octagon, pale for base shadow)
//     final Rect baseCap = Rect.fromCenter(
//       center: Offset(paintRect.center.dx, paintRect.bottom - (paintRect.width * 0.23)),
//       width: paintRect.width,
//       height: paintRect.width * 0.82,
//     );
//     // final Paint basePaint = Paint()
//     //   ..color = Colors.red.shade900;
//     // canvas.drawPath(_octagonPath(baseCap), basePaint);
//   }
//
//
//   // Rect _ovalRect(double yCenter) {
//   //   const double radius = 2; // adjust for oval size
//   //   return Rect.fromLTRB(segmentRect!.left,
//   //       segmentRect!.right, yCenter,yCenter , );
//   // }
// }

// base_verticle_bar_charts.dart
import 'dart:async';

import 'package:db_atom/index.dart';

// Simple model used in your earlier code. Replace with your real model import if needed.
class BaseVerticleBarCharts extends StatefulWidget {
  final String chartTitle;
  final List<PieChartData> chartData;
  final Widget? moreIcon;

  const BaseVerticleBarCharts({
    Key? key,
    required this.chartTitle,
    required this.chartData,
    this.moreIcon,
  }) : super(key: key);

  @override
  State<BaseVerticleBarCharts> createState() => _BaseVerticleBarChartsState();
}

class _BaseVerticleBarChartsState extends State<BaseVerticleBarCharts>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isChartVisible = true;
  late ZoomPanBehavior _zoomPanBehavior;
  CrosshairBehavior? _crosshairBehavior;
  TrackballBehavior? _trackballBehavior;
  bool _enableAxisAnimation = true;
  Timer? _timer;

  // // Colors used for bars (example palette)
  // final List<Color> customColors = const [
  //   Color(0xFFB94C3C), // reddish
  //   Color(0xFF7636A0), // purple
  //   Color(0xFF408080), // teal
  //   Color(0xFF3D68B1), // blue
  //   Color(0xFF5A4032), // brown
  //   Color(0xFF9E8B2D), // olive
  // ];

  final Map<String, Color> topOvalColors = {};

  @override
  void initState() {
    super.initState();

    // prepare top oval colors (slightly brighter)
    for (int i = 0; i < widget.chartData.length; i++) {
      topOvalColors[widget.chartData[i].x] =
          presetColors[i % presetColors.length].withOpacity(0.95);
    }


    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();

    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableDoubleTapZooming: true,
      enableSelectionZooming: true,
    );

    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineType: CrosshairLineType.both,
      lineColor: Colors.black54,
      lineWidth: 1,
    );

    _trackballBehavior = TrackballBehavior(
      enable: true,
      tooltipSettings: const InteractiveTooltip(enable: true),
      activationMode: ActivationMode.singleTap,
    );

    // Example periodic (if you used earlier) — here disabled by default.
    // _timer = Timer.periodic(const Duration(seconds: 1), (_) { setState(() {}); });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isChartVisible,
      child: Container(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height/2.2,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.07),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.07),
              // Color(0xFF6474C6).withOpacity(0.14)
            ],
            stops: [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.80),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6474C6).withValues(alpha: 0.09),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          widget.chartTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                    // if (widget.moreIcon != null) widget.moreIcon!,
                  ],
                ),
              // ],),

            const SizedBox(height: 10),

            // Chart or No Data
            widget.chartData.isEmpty
                ? SizedBox(
              // width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.height / 2.7,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       Colors.white.withValues(alpha: 0.2),
              //       Colors.transparent,
              //       Colors.white.withValues(alpha: 0.2),
              //       // Color(0xFF6474C6).withOpacity(0.14)
              //     ],
              //     stops: [0.02, 0.35, 1],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              //   borderRadius: BorderRadius.circular(27),
              //   border: Border.all(
              //     color: Colors.white.withValues(alpha: 0.80),
              //     width: 0.8,
              //   ),
              //   boxShadow: [
              //     BoxShadow(
              //       color: const Color(0xFF6474C6).withValues(alpha: 0.09),
              //       blurRadius: 12,
              //       offset: const Offset(0, 2),
              //     ),
              //   ],
              // ),
              child: const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            )
                : SizedBox(
                width: MediaQuery.of(context).size.width ,
                height: MediaQuery.of(context).size.height / 3.1,
                // height: 300,
                // width: 900,
                // child: SfCartesianChart(
                //   backgroundColor: Colors.white.withValues(alpha: 0.5),
                //   tooltipBehavior: TooltipBehavior(enable: true),
                //   // primaryXAxis: const CategoryAxis(
                //   //   labelStyle: TextStyle(color: Colors.black),
                //   // ),
                //   // primaryYAxis: const NumericAxis(
                //   //   labelStyle: TextStyle(color: Colors.black),
                //   // ),
                //   primaryXAxis: const CategoryAxis(
                //     labelStyle: TextStyle(color: Colors.black),
                //     axisLine: AxisLine(color: Colors.black, width: 0.8),
                //
                //   ),
                //   primaryYAxis: const NumericAxis(
                //     labelStyle: TextStyle(color: Colors.black),
                //     axisLine: AxisLine(color: Colors.black, width: 0.8),
                //   ),
                //   series: <CartesianSeries>[
                //     ColumnSeries<PieChartData, String>(
                //       dataSource: widget.chartData,
                //       xValueMapper: (PieChartData data, _) => data.x,
                //       yValueMapper: (PieChartData data, _) => data.y,
                //       // pointColorMapper: (PieChartData data, _) =>
                //       // data.color,
                //       pointColorMapper: (PieChartData data, index) =>
                //       customColors[index % presetColors.length],
                //       dataLabelSettings: const DataLabelSettings(
                //         isVisible: true,
                //         textStyle: TextStyle(color: Colors.black),
                //       ),
                //       enableTooltip: true,
                //       width: 0.3,
                //       borderRadius: const BorderRadius.only(
                //         topLeft: Radius.circular(6),
                //         topRight: Radius.circular(6),
                //       ),
                //     ),
                //   ],
                // ),

                //       child: SfCartesianChart(
                //           backgroundColor: Colors.white.withOpacity(0.5),
                //   tooltipBehavior: TooltipBehavior(enable: true),
                //   primaryXAxis: const CategoryAxis(
                //     labelStyle: TextStyle(color: Colors.black),
                //     axisLine: AxisLine(color: Colors.black, width: 0.8),
                //   ),
                //   primaryYAxis: const NumericAxis(
                //     labelStyle: TextStyle(color: Colors.black),
                //     axisLine: AxisLine(color: Colors.black, width: 0.8),
                //   ),
                //   series: <CartesianSeries>[
                //     ColumnSeries<PieChartData, String>(
                //       dataSource: widget.chartData,
                //       xValueMapper: (PieChartData data, _) => data.x,
                //       yValueMapper: (PieChartData data, _) => data.y,
                //       pointColorMapper: (PieChartData data, index) => customColors[index % presetColors.length],
                //       width: 0.35, // make bars thicker for better 3D look
                //       borderRadius: const BorderRadius.only(
                //         topLeft: Radius.circular(6),
                //         topRight: Radius.circular(6),
                //       ),
                //       dataLabelSettings: const DataLabelSettings(
                //         isVisible: true,
                //         textStyle: TextStyle(color: Colors.black),
                //       ),
                //       enableTooltip: true,
                //       // Simulate 3D with gradient fill
                //       gradient: LinearGradient(
                //         begin: Alignment.topCenter,
                //         end: Alignment.bottomCenter,
                //         colors: [
                //           Colors.white.withOpacity(0.3),
                //           customColors[0 % customColors.length], // top lighter
                //           customColors[0 % customColors.length].withOpacity(0.8), // bottom darker
                //         ],
                //       ),
                //       // Shadow effect
                //       borderWidth: 0,
                //       spacing: 0.2,
                //     ),
                //   ],
                // )
                child:
                SfCartesianChart(
                  backgroundColor: Colors.transparent,
                  tooltipBehavior: TooltipBehavior(enable: true),
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                    isVisible: true,
                    labelStyle: TextStyle(color: Colors.white),
                    axisLine: AxisLine(color: Colors.white, width: 0.8),
                    majorGridLines: MajorGridLines(width: 0), // remove vertical grid lines
                    // minorGridLines: MinorGridLines(width: 0),
                  ),
                  primaryYAxis: const NumericAxis(
                    isVisible: false,
                    labelStyle: TextStyle(color: Colors.white),
                    // axisLine: AxisLine(color: Colors.white, width: 0.8),
                    majorGridLines: MajorGridLines(width: 0), //  remove vertical grid lines
                    minorGridLines: MinorGridLines(width: 0),
                  ),
                  palette: customGlassColors,
                  // series: <CartesianSeries>[
                  //   ColumnSeries<PieChartData, String>(
                  //     dataSource:  widget.chartData,
                  //     xValueMapper: (PieChartData data, _) => data.x,
                  //     yValueMapper: (PieChartData data, _) => data.y,
                  //     width: 0.6, // Thicker bars for better 3D illusion
                  //     borderRadius: const BorderRadius.only(
                  //       topLeft: Radius.circular(8),
                  //       topRight: Radius.circular(8),
                  //     ),
                  //     borderColor: Colors.white,
                  //     borderWidth: 0.5,
                  //
                  //     // pointColorMapper: (PieChartData data, index) => customColors[index % customColors.length],
                  //     dataLabelSettings: const DataLabelSettings(
                  //       isVisible: true,
                  //       textStyle: TextStyle(color: Colors.white),
                  //     ),
                  //     enableTooltip: true,
                  //
                  //     // Gradient for pseudo-light effect
                  //     pointColorMapper: (PieChartData data, index) {
                  //       // Create a gradient for each bar by using a custom Paint
                  //       return customGlassColors[index % customGlassColors.length];
                  //     },
                  //     // Shadow effect using decoration (inside chart, pseudo)
                  //     // Note: Flutter Charts doesn't directly support shadow, so we use gradient + thickness
                  //     spacing: 0, // Slight gap between bars to emphasize depth
                  //   ),
                  // ],
                  //   series: <CartesianSeries>[
                  //     GradientColumnSeries<PieChartData, String>(
                  //       dataSource: widget.chartData,
                  //       xValueMapper: (data, _) => data.x,
                  //       yValueMapper: (data, _) => data.y,
                  //     ),
                  //   ]
                  series: <CartesianSeries>[
                    // ColumnSeries<PieChartData, String>(
                    //   dataSource: widget.chartData,
                    //   xValueMapper: (data, _) => data.x,
                    //   yValueMapper: (data, _) => data.y,
                    //   width: 0.7,
                    //   borderRadius: const BorderRadius.only(
                    //     topLeft: Radius.circular(8),
                    //     topRight: Radius.circular(8),
                    //   ),
                    // borderWidth: 1,
                    //   borderColor: Colors.white,
                    //   gradient:[ Colors.white, Colors.red],
                    //   // ⭐ EACH BAR GETS ITS OWN GRADIENT
                    //   onCreateShader: (ShaderDetails details) {
                    //     // final index = details.pointIndex!;
                    //     // final selected = barGradients[index % barGradients.length];
                    //
                    //     return const LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [AppColors.redColor, Colors.grey, Colors.purple, Colors.pink, Colors.green] ,
                    //     ).createShader(details.rect);
                    //   },
                    //
                    //   // remove pointColorMapper if exists (it overwrites gradients!)
                    //   // pointColorMapper: null,
                    //
                    //   dataLabelSettings: const DataLabelSettings(
                    //     isVisible: true,
                    //     textStyle: TextStyle(color: Colors.white),
                    //   ),
                    // )
                    ColumnSeries<PieChartData, String>(
                      dataSource: widget.chartData,
                      xValueMapper: (data, _) => data.x,
                      yValueMapper: (data, _) => data.y,
                      width: 1,

                      // borderRadius: const BorderRadius.only(
                      //   topLeft: Radius.circular(8),
                      //   topRight: Radius.circular(8),
                      // ),

                      // ⭐ BORDER
                      borderWidth: 0.7,
                      borderColor: Colors.white,

                      // ⭐ BORDER GRADIENT
                      borderGradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          // Colors.grey,
                          // Colors.purple,
                          // Colors.pink,
                          // Colors.green,
                        ],
                      ),

                      // ⭐ BASE GRADIENT (will be overridden if onCreateShader is used)
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.red,
                        ],
                      ),

                      // ⭐ CUSTOM PER-BAR GRADIENT (completely overrides `gradient`)
                      onCreateShader: (ShaderDetails details) {
                        return const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // Color(0xFFFFA500),
                            Colors.red,
                            Color(0xFFdc3545),
                            Colors.purple,
                            // Color(0xFF003f5c),
                            Color(0xFFFFA500),
                            // Colors.pink,
                            // Colors.green,
                            //  Color(0xFFFFA500),
                             Color(0xFFdc3545),

                            // const Color(0xFF006400),
                            // const Color(0xFFFF6B6B),
                            const Color(0xFFFF1493),
                            const Color(0xFF9D4EDD),
                            const Color(0xFF5A189A),// onst Color(0xFFffc107),
                            const Color(0xFF1E40AF),
                            // const Color.fromRGBO(136, 14, 79, 1),
                            // const Color(0xFF003f5c),
                          ],
                        ).createShader(details.rect);
                      },

                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    )

                  ],

                )
            ),

            const SizedBox(height: 10),

            // Custom Scrollable Legend
            if (widget.chartData.isNotEmpty)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 20,
                // height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.chartData.map((data) {
                      final color = customColors[
                      widget.chartData.indexOf(data) %
                          customColors.length];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.2),
                              // Color(0xFF6474C6).withOpacity(0.14)
                            ],
                            stops: [0.02, 0.35, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.80),
                            width: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6474C6).withValues(alpha: 0.09),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${data.x} (${data.y}%)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }}

// return Visibility(
    //   visible: isChartVisible,
    //   child: Container(
    //     margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
    //     padding: const EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [
    //           Colors.white.withValues(alpha: 0.3),
    //           Colors.transparent,
    //           Colors.white.withValues(alpha: 0.3),
    //           // Color(0xFF6474C6).withOpacity(0.14)
    //         ],
    //         stops: [0.02, 0.35, 1],
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //       ),
    //       borderRadius: BorderRadius.circular(27),
    //       border: Border.all(
    //         color: Colors.white.withValues(alpha: 0.80),
    //         width: 0.8,
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //           color: const Color(0xFF6474C6).withValues(alpha: 0.09),
    //           blurRadius: 12,
    //           offset: const Offset(0, 2),
    //         ),
    //       ],
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // Header
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: Text(
    //                   widget.chartTitle,
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black87,
    //                     fontSize: 18,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             // if (widget.moreIcon != null) widget.moreIcon!,
    //           ],
    //         ),
    //         const SizedBox(height: 12),
    //
    //         // Chart
    //         widget.chartData.isEmpty
    //             ? Container(
    //           height: 50,
    //           decoration: BoxDecoration(
    //             color: Colors.transparent,
    //             borderRadius: BorderRadius.circular(16),
    //           ),
    //           child: const Center(
    //             child: Text(
    //               'No Data Found',
    //               style: TextStyle(color: Colors.black54, fontSize: 14),
    //             ),
    //           ),
    //         )
    //             : SizedBox(
    //           height: 320,
    //           child: AnimatedBuilder(
    //             animation: _animation,
    //             builder: (context, child) {
    //               return SfCartesianChart(
    //                 backgroundColor: Colors.transparent,
    //                 borderColor: Colors.white,
    //                 borderWidth: 0.9,
    //                 zoomPanBehavior: _zoomPanBehavior,
    //                 crosshairBehavior: _crosshairBehavior,
    //                 trackballBehavior: _trackballBehavior,
    //                 enableAxisAnimation: _enableAxisAnimation,
    //                 onZoomStart: (ZoomPanArgs args) {
    //                   print('Zoom started: zoomFactor=${args.currentZoomFactor}, zoomPosition=${args.currentZoomPosition}');
    //                 },
    //                 onZoomEnd: (ZoomPanArgs args) {
    //                   print('Zoom ended: zoomFactor=${args.currentZoomFactor}, zoomPosition=${args.currentZoomPosition}');
    //                 },
    //                 onChartTouchInteractionMove: (ChartTouchInteractionArgs args) {
    //                   print('Touch interaction moved: position=${args.position}');
    //                 },
    //                 tooltipBehavior: TooltipBehavior(enable: true),
    //
    //                 primaryXAxis: const CategoryAxis(
    //                   labelStyle: TextStyle(
    //                     color: Colors.black87,
    //                     fontSize: 13,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                   majorGridLines: MajorGridLines(width: 0),
    //                   axisLine: AxisLine(width: 0),
    //                 ),
    //                 primaryYAxis: const NumericAxis(
    //                   isVisible: false,
    //                 ),
    //                 series: <CartesianSeries>[
    //                   ColumnSeries<PieChartData, String>(
    //                     dataSource: widget.chartData,
    //                     xValueMapper: (d, _) => d.x,
    //                     yValueMapper: (d, _) => d.y * _animation.value,
    //                     width: 0.7,
    //                     spacing: 0.2,
    //                     pointColorMapper: (d, i) =>
    //                     d.color ?? customColors[i % customColors.length],
    //                     dataLabelSettings: const DataLabelSettings(
    //                       isVisible: true,
    //                       labelAlignment: ChartDataLabelAlignment.middle,
    //                       textStyle: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.w600,
    //                         fontSize: 14,
    //                       ),
    //                     ),
    //                     enableTooltip: true,
    //                     // IMPORTANT: use a custom renderer with correct generics
    //                     onCreateRenderer: (ChartSeries<PieChartData, String> series) {
    //                       return _CustomCylinder3DRenderer(topOvalColors);
    //                     },
    //                   ),
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    //
    //         const SizedBox(height: 10),
    //
    //         if (widget.chartData.isNotEmpty)
    //           SizedBox(
    //             height: 50,
    //             child: SingleChildScrollView(
    //               scrollDirection: Axis.horizontal,
    //               child: Row(
    //                 children: widget.chartData.map((data) {
    //                   final color = customColors[
    //                   widget.chartData.indexOf(data) % customColors.length];
    //                   return Container(
    //                     margin: const EdgeInsets.symmetric(horizontal: 6),
    //                     padding: const EdgeInsets.symmetric(
    //                         horizontal: 12, vertical: 6),
    //                     decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                         colors: [
    //                           Colors.white.withValues(alpha: 0.3),
    //                           Colors.transparent,
    //                           Colors.white.withValues(alpha: 0.3),
    //                           // Color(0xFF6474C6).withOpacity(0.14)
    //                         ],
    //                         stops: [0.02, 0.35, 1],
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                       ),
    //                       borderRadius: BorderRadius.circular(27),
    //                       border: Border.all(
    //                         color: Colors.white.withValues(alpha: 0.80),
    //                         width: 0.8,
    //                       ),
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: const Color(0xFF6474C6).withValues(alpha: 0.09),
    //                           blurRadius: 12,
    //                           offset: const Offset(0, 2),
    //                         ),
    //                       ],
    //                     ),
    //                     child: Row(
    //                       children: [
    //                         Container(
    //                           width: 10,
    //                           height: 10,
    //                           decoration: BoxDecoration(
    //                             color: color,
    //                             shape: BoxShape.circle,
    //                           ),
    //                         ),
    //                         const SizedBox(width: 6),
    //                         Text(
    //                           '${data.x} (${data.y}%)',
    //                           style: const TextStyle(
    //                             fontSize: 13,
    //                             fontWeight: FontWeight.w500,
    //                             color: Color(0xFF333333),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   );
    //                 }).toList(),
    //               ),
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    // );

//
//   }
// }

// /// Custom renderer with correct generics: ColumnSeriesRenderer<PieChartData, String>
// class _CustomCylinder3DRenderer extends ColumnSeriesRenderer<PieChartData, String> {
//   final Map<String, Color> topOvalColors;
//   _CustomCylinder3DRenderer(this.topOvalColors);
//
//   @override
//   ColumnSegment<PieChartData, String> createSegment() {
//     return _CustomCylinder3DSegment(topOvalColors);
//   }
// }
//
// /// Custom ColumnSegment with matching generics: ColumnSegment<PieChartData, String>
// class _CustomCylinder3DSegment extends ColumnSegment<PieChartData, String> {
//   final Map<String, Color> topOvalColors;
//   _CustomCylinder3DSegment(this.topOvalColors);
//
//   // Create smooth cylinder path for a given rect
//   Path _cylinderBody(Rect rect) {
//     final Path path = Path()
//       ..moveTo(rect.left, rect.top)
//       ..lineTo(rect.left, rect.bottom)
//     // bottom ellipse curve
//       ..arcToPoint(
//         Offset(rect.right, rect.bottom),
//         radius: Radius.elliptical(rect.width / 2, rect.width / 8),
//         clockwise: false,
//       )
//       ..lineTo(rect.right, rect.top)
//     // top ellipse curve
//       ..arcToPoint(
//         Offset(rect.left, rect.top),
//         radius: Radius.elliptical(rect.width / 2, rect.width / 8),
//         clockwise: true,
//       )
//       ..close();
//     return path;
//   }
//
//   @override
//   void onPaint(Canvas canvas) {
//     if (segmentRect == null) return;
//
//     final Rect barRect;
//     if (segmentRect is RRect) {
//       barRect = (segmentRect as RRect).outerRect;
//     } else if (segmentRect is Rect) {
//       barRect = segmentRect as Rect;
//     } else {
//       return;
//     }
//
//     final String category = series.xRawValues[currentSegmentIndex]!;
//     // animate height via animationFactor (provided by base class)
//     final double barHeight = barRect.height * animationFactor;
//
//     final Rect paintRect = Rect.fromLTRB(
//       barRect.left,
//       barRect.bottom - barHeight,
//       barRect.right,
//       barRect.bottom,
//     );
//
//     // Shadow under the cylinder (soft)
//     final Path shadowPath = _cylinderBody(paintRect.inflate(6).translate(0, 6));
//     canvas.drawPath(
//       shadowPath,
//       Paint()
//         ..color = Colors.black.withOpacity(0.12)
//         ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
//     );
//
//     // Vertical gradient fill for cylinder body
//     final Color fillColor = topOvalColors[category] ??
//         (fillPaint.color == null ? Colors.red : fillPaint.color!);
//     final Paint bodyPaint = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           fillColor.withOpacity(0.99),
//           fillColor.withOpacity(0.99),
//           fillColor.withOpacity(0.9),
//         ],
//       ).createShader(paintRect);
//
//     // Draw cylinder body
//     final Path bodyPath = _cylinderBody(paintRect);
//     canvas.drawPath(bodyPath, bodyPaint);
//
//     // Top oval (translucent gray cap) to mimic the image style
//     final Rect topOval = Rect.fromCenter(
//       center: Offset(paintRect.center.dx, paintRect.top),
//       width: paintRect.width,
//       height: paintRect.width / 2.8,
//     );
//
//     // darker top ring (gives illusion of 3D lip)
//     canvas.drawOval(
//       topOval,
//       Paint()
//         ..shader = RadialGradient(
//           center: const Alignment(0, -0.4),
//           radius: 1,
//           colors: [
//             // Colors.black,
//             Colors.white,
//             // Colors.grey,
//             // fillColor.withOpacity(0.99),
//             // fillColor.withOpacity(0.1),
//             fillColor.withOpacity(0.1),
//
//           ],
//           stops: const [0.0, 1.0],
//         ).createShader(topOval),
//     );
//
//     // subtle highlight inside the top
//     final Rect innerHighlight = topOval.deflate(topOval.width * 0.12);
//     canvas.drawOval(
//       innerHighlight.translate(0, -topOval.height * 0.05),
//       Paint()
//         ..color = Colors.white.withOpacity(0)
//         ..style = PaintingStyle.fill,
//     );
//   }
// }

class GradientColumnSeries<T, D> extends ColumnSeries<T, D> {
  GradientColumnSeries({
    super.dataSource,
    super.xValueMapper,
    super.yValueMapper,
    super.dataLabelSettings,
    super.borderRadius,
    super.width,
  });

  @override
  ChartSegment createSegment() => GradientColumnSegment();
}
class GradientColumnSegment extends ColumnSegment {
  static List<List<Color>> gradients = [
    [Color(0xFF00C6FF), Color(0xFF0072FF)],
    [Color(0xFFFFB199), Color(0xFFFF0844)],
    [Color(0xFFA1FFCE), Color(0xFFFAFFD1)],
    [Color(0xFFFFD194), Color(0xFF70E1F5)],
  ];

  @override
  void onPaint(Canvas canvas) {
    final index = currentSegmentIndex;

    final colors = gradients[index % gradients.length];

    // FIX: Convert RRect → Rect
    final rect = segmentRect!.outerRect;

    final shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
    ).createShader(rect);

    final paint = Paint()..shader = shader;

    // Draw using rect or drawRRect
    canvas.drawRRect(segmentRect!, paint);
  }
}

