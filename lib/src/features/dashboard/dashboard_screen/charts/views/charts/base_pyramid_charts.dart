import 'package:db_atom/index.dart';

class BasePyramidCharts extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BasePyramidCharts({
    super.key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  });

  @override
  BasePyramidChartsState createState() => BasePyramidChartsState();
}

class BasePyramidChartsState extends State<BasePyramidCharts> {
  bool isChartVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // setState(() {
//         //   isChartVisible = !isChartVisible;
//         // });
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: isChartVisible,
//             child: Container(
//               height: 300,
//               width: 450,
//               decoration: const ShapeDecoration(
//                 color: AppColors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(0.0),
//                     bottom: Radius.circular(0.0),
//                   ),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           widget.chartTitle,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.navigationSkyBlueColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       // IconButton(
//                       //   icon: const Icon(Icons.cancel),
//                       //   onPressed: () {
//                       //     setState(() {
//                       //       isChartVisible = false;
//                       //     });
//                       //   },
//                       // ),
//                     ],
//                   ),
//                   widget.chartData.isEmptyOrNull
//                       ? const Padding(
//                           padding: EdgeInsets.only(top: 100.0),
//                           child: Center(
//                             child: Text('No Data Found.'),
//                           ),
//                         )
//                       : Expanded(
//                           child: SfPyramidChart(
//                             legend: const Legend(isVisible: true),
//                             series: PyramidSeries<PieChartData, String>(
//                               legendIconType: LegendIconType.seriesType,
//                               dataSource: widget.chartData,
//                               xValueMapper: (PieChartData data, _) => data.x,
//                               yValueMapper: (PieChartData data, _) => data.y,
//                               pointColorMapper: (PieChartData data, _) =>
//                                   data.color,
//                               dataLabelSettings: const DataLabelSettings(
//                                 isVisible: true,
//                                 // You can further customize the data labels here
//                               ),
//                               explode: true,
//                             ),
//                             tooltipBehavior: TooltipBehavior(
//                               enable: true,
//                               builder: (dynamic data,
//                                   dynamic point,
//                                   dynamic series,
//                                   int pointIndex,
//                                   int seriesIndex) {
//                                 return Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(5),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           spreadRadius: 2,
//                                           blurRadius: 0),
//                                     ],
//                                   ),
//                                   child: Text(
//                                     '${data.x} : ${data.y}',
//                                     style: const TextStyle(color: Colors.black),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


  Widget build(BuildContext context) {
    return Visibility(
      visible: isChartVisible,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
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
                    widget.moreIcon,
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Chart or No Data
            widget.chartData.isEmpty
                ? Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
            )
            //     : SizedBox(
            //   height: 250,
            //   // width: 900,
            //   child: SfPyramidChart(
            //     legend: const Legend(isVisible: true),
            //     tooltipBehavior: TooltipBehavior(enable: true),
            //     series: PyramidSeries<PieChartData, String>(
            //       legendIconType: LegendIconType.seriesType,
            //       dataSource: widget.chartData,
            //       xValueMapper: (PieChartData data, _) => data.x,
            //       yValueMapper: (PieChartData data, _) => data.y,
            //       pointColorMapper: (PieChartData data, _) =>
            //       data.color,
            //       dataLabelSettings: const DataLabelSettings(
            //         isVisible: true,
            //         // You can further customize the data labels here
            //       ),
            //       explode: true,
            //     ),
            //   ),
            // ),
            // :SizedBox(
            //   height: 250,
            //   child: SfCartesianChart(
            //     tooltipBehavior: TooltipBehavior(enable: true),
            //     primaryXAxis: CategoryAxis(),
            //     series: <CartesianSeries>[
            //       SplineAreaSeries<PieChartData, String>(
            //         dataSource: widget.chartData,
            //         xValueMapper: (PieChartData data, _) => data.x,
            //         yValueMapper: (PieChartData data, _) => data.y,
            //         color: Colors.blueAccent.withOpacity(0.4),
            //         borderColor: Colors.blueAccent,
            //         borderWidth: 2,
            //       ),
            //     ],
            //   )
            // ),

            // //radial circle chart
            // :SfCircularChart(
            //   series: <CircularSeries>[
            //     RadialBarSeries<PieChartData, String>(
            //       dataSource: widget.chartData,
            //       xValueMapper: (PieChartData data, _) => data.x,
            //       yValueMapper: (PieChartData data, _) => data.y,
            //       pointColorMapper: (PieChartData data, _) => data.color,
            //       cornerStyle: CornerStyle.bothCurve,
            //       trackColor: Colors.white10,
            //       maximumValue: 100,
            //       dataLabelSettings: const DataLabelSettings(isVisible: true),
            //     ),
            //   ],
            // ),
            //
            : SizedBox(
                height: 300,
            child :SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: const CategoryAxis(),
              series: <CartesianSeries>[
                SplineSeries<PieChartData, String>(
                  dataSource: widget.chartData,
                  xValueMapper: (PieChartData data, _) => data.x,
                  yValueMapper: (PieChartData data, _) => data.y,
                  pointColorMapper: (PieChartData data, index) =>
                  presetColors[index % presetColors.length],
                  width: 3,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    borderColor: Colors.white,
                    borderWidth: 2,
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 10),

            // Custom Scrollable Legend
            if (widget.chartData.isNotEmpty)
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.chartData.map((data) {
                      final color = customColors[
                      widget.chartData.indexOf(data) % customColors.length];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: color, width: 1.5),
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
                                color: Color(0xFF333333),
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
