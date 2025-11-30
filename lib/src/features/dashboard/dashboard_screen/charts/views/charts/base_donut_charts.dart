// import 'package:db_atom/index.dart';
//
// class BaseBarChart extends StatefulWidget {
//   final List<PieChartData> chartData;
//   final String chartTitle;
//   final Widget moreIcon;
//
//   const BaseBarChart({
//     super.key,
//     required this.chartTitle,
//     required this.moreIcon,
//     required this.chartData,
//   });
//
//   @override
//   BaseBarChartState createState() => BaseBarChartState();
// }
//
// class BaseBarChartState extends State<BaseBarChart> {
//   bool isChartVisible = true;
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       children: [
// //         Visibility(
// //           visible: isChartVisible,
// //           child: Container(
// //             height: 300,
// //             width: 350,
// //             decoration: const ShapeDecoration(
// //               color: AppColors.white,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.vertical(
// //                   top: Radius.circular(0.0),
// //                   bottom: Radius.circular(0.0),
// //                 ),
// //               ),
// //             ),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Text(
// //                         widget.chartTitle,
// //                         style: const TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           color: AppColors.navigationSkyBlueColor,
// //                           fontSize: 16,
// //                         ),
// //                       ),
// //                     ),
// //                     // IconButton(
// //                     //   icon: const Icon(Icons.cancel),
// //                     //   onPressed: () {
// //                     //     setState(() {
// //                     //       isChartVisible = false;
// //                     //     });
// //                     //   },
// //                     // ),
// //                   ],
// //                 ),
// //                 CommonWidgets.verticalSpacerWidget(0.1),
// //                 Expanded(
// //                   child: SfCartesianChart(
// //                     // tooltipBehavior: TooltipBehavior(
// //                     //   enable: true,
// //                     //   format: 'point.y',
// //                     // ),
// //                     series: <CartesianSeries>[
// //                       BarSeries<PieChartData, num>(
// //                         dataSource: widget.chartData,
// //                         legendIconType: LegendIconType.seriesType,
// //                         width: 0.3,
// //                         xValueMapper: (PieChartData data, _) =>
// //                             widget.chartData.indexOf(data),
// //                         yValueMapper: (PieChartData data, _) => data.y,
// //                         pointColorMapper: (PieChartData data, _) => data.color,
// //                         emptyPointSettings: const EmptyPointSettings(
// //                           mode: EmptyPointMode.average,
// //                         ),
// //                         dataLabelSettings: const DataLabelSettings(
// //                           isVisible: true,
// //                         ),
// //                         enableTooltip: true,
// //                         //selectionBehavior: SelectionBehavior(enable: true),
// //                       ),
// //                     ],
// //                     tooltipBehavior: TooltipBehavior(
// //                       enable: true,
// //                       builder: (dynamic data, dynamic point, dynamic series,
// //                           int pointIndex, int seriesIndex) {
// //                         return Container(
// //                           padding: const EdgeInsets.all(8),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(5),
// //                             boxShadow: [
// //                               BoxShadow(
// //                                   color: Colors.black.withOpacity(0.2),
// //                                   spreadRadius: 2,
// //                                   blurRadius: 5),
// //                             ],
// //                           ),
// //                           child: Text(
// //                             '${data.x} : ${data.y}',
// //                             style: const TextStyle(color: Colors.black),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.white.withOpacity(0.02),
//               blurRadius: 10,
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
//                             color: Colors.white,
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
//               child: SfCartesianChart(
//                 backgroundColor: Colors.white10,
//                 tooltipBehavior: TooltipBehavior(enable: true),
//                 primaryXAxis: const CategoryAxis(
//                   labelStyle: TextStyle(color: Colors.white),
//                   majorGridLines: MajorGridLines(width: 0), // ❌ Removes vertical grid lines
//
//                 ),
//                 primaryYAxis: const NumericAxis(
//                   labelStyle: TextStyle(color: Colors.white),
//                   majorGridLines: MajorGridLines(width: 0), // ❌ Removes vertical grid lines
//
//                 ),
//                 series: <CartesianSeries>[
//                   BarSeries<PieChartData, num>(
//                     dataSource: widget.chartData,
//                     legendIconType: LegendIconType.seriesType,
//                     width: 0.3,
//                     xValueMapper: (PieChartData data, _) =>
//                         widget.chartData.indexOf(data),
//                     yValueMapper: (PieChartData data, _) => data.y,
//                     pointColorMapper: (PieChartData data, _) => data.color,
//                     emptyPointSettings: const EmptyPointSettings(
//                       mode: EmptyPointMode.average,
//                     ),
//                     dataLabelSettings: const DataLabelSettings(
//                       isVisible: true,
//                     ),
//                     enableTooltip: true,
//                     //selectionBehavior: SelectionBehavior(enable: true),
//                   ),
//                 ],
//               ),
//             ),
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
//
//
// //   Widget build(BuildContext context) {
// //     return Visibility(
// //       visible: isChartVisible,
// //       child: Container(
// //         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
// //         padding: const EdgeInsets.all(6),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(10),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.06),
// //               blurRadius: 10,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Header Row
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Header Row
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Expanded(
// //                       child: SingleChildScrollView(
// //                         scrollDirection: Axis.horizontal,
// //                         child: Text(
// //                           widget.chartTitle,
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.black87,
// //                             fontSize: 16,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     if (widget.moreIcon != null) widget.moreIcon!,
// //                   ],
// //                 ),
// //               ],),
// //
// //             const SizedBox(height: 12),
// //
// //             // Chart or No Data
// //             widget.chartData.isEmpty
// //                 ? Container(
// //               height: 300,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //               child: const Center(
// //                 child: Text(
// //                   'No Data Found',
// //                   style: TextStyle(color: Colors.black54, fontSize: 14),
// //                 ),
// //               ),
// //             )
// //                 : SizedBox(
// //               height: 250,
// //               // width: 900,
// //               child: SfCartesianChart(
// //                 backgroundColor: AppColors.white,
// //                 tooltipBehavior: TooltipBehavior(enable: true),
// //                 primaryXAxis: const CategoryAxis(
// //                   labelStyle: TextStyle(color: Colors.black),
// //                 ),
// //                 primaryYAxis: const NumericAxis(
// //                   labelStyle: TextStyle(color: Colors.black),
// //                 ),
// //                 series: <CartesianSeries>[
// //                   ColumnSeries<PieChartData, String>(
// //                     dataSource: widget.chartData,
// //                     xValueMapper: (PieChartData data, _) => data.x,
// //                     yValueMapper: (PieChartData data, _) => data.y,
// //                     // pointColorMapper: (PieChartData data, _) =>
// //                     // data.color,
// //                     pointColorMapper: (PieChartData data, index) =>
// //                     customColors[index % customColors.length],
// //                     dataLabelSettings: const DataLabelSettings(
// //                       isVisible: true,
// //                       textStyle: TextStyle(color: Colors.white),
// //                     ),
// //                     enableTooltip: true,
// //                     width: 0.3,
// //                     borderRadius: const BorderRadius.only(
// //                       topLeft: Radius.circular(6),
// //                       topRight: Radius.circular(6),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //
// //             const SizedBox(height: 10),
// //
// //             // Custom Scrollable Legend
// //             if (widget.chartData.isNotEmpty)
// //               SizedBox(
// //                 height: 30,
// //                 child: SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //                   child: Row(
// //                     children: widget.chartData.map((data) {
// //                       final color = customColors[
// //                       widget.chartData.indexOf(data) %
// //                           customColors.length];
// //                       return Container(
// //                         margin: const EdgeInsets.symmetric(horizontal: 6),
// //                         padding: const EdgeInsets.symmetric(
// //                             horizontal: 12, vertical: 6),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(30),
// //                           border: Border.all(color: color, width: 1.5),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             Container(
// //                               width: 10,
// //                               height: 10,
// //                               decoration: BoxDecoration(
// //                                 color: color,
// //                                 shape: BoxShape.circle,
// //                               ),
// //                             ),
// //                             const SizedBox(width: 6),
// //                             Text(
// //                               '${data.x} (${data.y}%)',
// //                               style: const TextStyle(
// //                                 fontSize: 13,
// //                                 fontWeight: FontWeight.w500,
// //                                 color: Color(0xFF333333),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }}
// //
// //
// //
// // final List<Color> presetColors = [
// //   const Color(0xFF0093F9),
// //   const Color(0xFF15CAB4),
// //   const Color(0xFFFFA516),
// //   const Color(0xFFFF4051),
// //   const Color(0xFF9665ED),
// //   const Color(0xFFB2DEFD),
// //   const Color(0xFF007bff),
// //   const Color(0xFF6610f2),
// //   const Color(0xFF6f42c1),
// //   const Color(0xFFe83e8c),
// //   const Color(0xFFdc3545),
// //   const Color(0xFFfd7e14),
// //   const Color(0xFFffc107),
// //   const Color(0xFF28a745),
// //   const Color(0xFF20c997),
// //   const Color(0xFF17a2b8),
// // ];
// //
// // final List<Color> customColors = [ // const Color(0xFFffc107),
// //   const Color(0xFF1E40AF),
// //   const Color(0xFF2563EB),
// //   const Color(0xFF6366F1),
// //   const Color(0xFF4B67F2),
// //   const Color(0xFF3B82F6),
// //   const Color(0xFF0EA5E9),
// //   const Color(0xFF29C3D1),
// //   const Color(0xFF22A9F3),
// //   const Color(0xFFEC4899),
// //   const Color(0xFFDB2777),
// //   const Color(0xFFdc3545),
// //   const Color(0xFFfd7e14),
// //   const Color(0xFF14B8A6),
// //   const Color(0xFF10B981),
// //   const Color(0xFF84CC16),
// //   const Color(0xFF28a745),
// //   const Color(0xFF15803D),
// // ];

import 'dart:async';
import 'dart:ui' as ui;
import 'package:db_atom/index.dart';
class BaseDonutChart extends StatefulWidget {
  final String chartTitle;
  final List<PieChartData> chartData;
  final Widget? moreIcon;

  const BaseDonutChart({
    Key? key,
    required this.chartTitle,
    required this.chartData,
    this.moreIcon,
  }) : super(key: key);

  @override
  State<BaseDonutChart> createState() => _BaseDonutChartState();
}

class _BaseDonutChartState extends State<BaseDonutChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isChartVisible = true;
  Timer? _timer;

  // Custom color palette
  // final List<Color> customColors = const [
  //   Color(0xFF78350F),
  //   Color(0xFFFFA516),
  //   Color(0xFFFF4051),
  //   Color(0xFF9665ED),
  //   Color(0xFF081D22),
  // ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
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
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2.2,
        // height: ,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.newColor1.withValues(alpha: 0.07),
              Colors.transparent,
              AppColors.newColor1.withValues(alpha: 0.07),
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
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

            // const SizedBox(height: 12),

            // Chart or No Data
            widget.chartData.isEmpty
                ? Container(
              height: MediaQuery.of(context).size.height/2.5,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       Colors.white.withValues(alpha: 0.2),
              //       Colors.transparent,
              //       Colors.white.withValues(alpha: 0.2),
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
              //       color:
              //       const Color(0xFF6474C6).withValues(alpha: 0.09),
              //       blurRadius: 12,
              //       offset: const Offset(0, 2),
              //     ),
              //   ],
              // ),
              child: const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            )
                :
            // SizedBox(
            //   height: 300,
            //   child: SfCircularChart(
            //     backgroundColor: Colors.transparent,
            //     tooltipBehavior: TooltipBehavior(enable: true),
            //     legend: const Legend(isVisible: false),
            //     series: <CircularSeries>[
            //       DoughnutSeries<PieChartData, String>(
            //         dataSource: widget.chartData,
            //         xValueMapper: (PieChartData data, _) => data.x,
            //         yValueMapper: (PieChartData data, _) => data.y,
            //         pointColorMapper: (PieChartData data, index) =>
            //         customColors[index % customColors.length],
            //         dataLabelSettings: const DataLabelSettings(
            //           isVisible: true,
            //           textStyle: TextStyle(
            //             color: Colors.white,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         radius: '80%',
            //         innerRadius: '40%', // makes it donut-shaped
            //         explode: true,
            //         explodeIndex: 0,
            //         explodeOffset: '8%',
            //         animationDuration: 1200,
            //       ),
            //     ],
            //   ),
            // ),

            Stack(
              alignment: Alignment.center,
              children: [
                // 1. Your original, textured or gradient background
                // Positioned.fill(
                // child: Image.asset('assets/your_blurred_background.jpg', fit: BoxFit.cover),
                // ),
                // 2. Circular blur overlay, matching the pie's size and position
                Center(
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.278,
                        color:
                        Colors.white.withOpacity(0.30), // Slight tint
                      ),
                    ),
                  ),
                ),
                // 3. The actual PieChart, with translucent colors
                SfCircularChart(
                  backgroundColor: Colors.transparent,
                  // palette: <Color>[Colors.amber.withValues(alpha: 0.5), Colors.brown.withValues(alpha: 0.5), Colors.green.withValues(alpha: 0.5), Colors.purple.withValues(alpha: 0.5), Colors.teal.withValues(alpha: 0.5),const Color(0xFFFF4500).withValues(alpha: 0.5), const Color(0xFFdc3545).withValues(alpha: 0.5),   const Color(0xFF003f5c).withValues(alpha: 0.4)],
                  palette: customGlassColors,
                  // legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    DoughnutSeries<PieChartData, String>(
                      radius: '${MediaQuery.of(context).size.width * 0.28}',
                      // legendIconType: LegendIconType.seriesType,
                      dataSource: widget.chartData,
                      xValueMapper: (d, _) => d.x,
                      yValueMapper: (d, _) => d.y,
                      strokeColor: Colors.white.withOpacity(0.8),
                      pointRenderMode: PointRenderMode.gradient,

                      strokeWidth: 1.2,
                      explode: true,
                      explodeOffset: '10%',
                      // pointColorMapper: (PieChartData d, int? i) {
                      //   final index = i ?? 0;
                      //   // Return gradient start color
                      //   return gradientColors[
                      //   index % gradientColors.length]
                      //       .first;
                      // },

                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),

            // Scrollable Legend
            if (widget.chartData.isNotEmpty)
              SizedBox(
                height: 50,
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
                              color: const Color(0xFF6474C6)
                                  .withValues(alpha: 0.09),
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
                                color:Colors.white,
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
  }
}
