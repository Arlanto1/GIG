import 'package:db_atom/index.dart';

class BasePieChart extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BasePieChart({
    super.key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  });

  @override
  BasePieChartState createState() => BasePieChartState();
}

class BasePieChartState extends State<BasePieChart> {
  bool isChartVisible = true;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Visibility(
  //         visible: isChartVisible,
  //         child: Container(
  //           height: 400,
  //           width: 380,
  //           decoration: const ShapeDecoration(
  //             color: Colors.white54,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.vertical(
  //                 top: Radius.circular(2.0),
  //                 bottom: Radius.circular(2.0),
  //               ),
  //             ),
  //           ),
  //           child: Column(
  //             children: [
  //               Row(
  //                 // textDirection: TextDirection.rtl,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       widget.chartTitle,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.navigationSkyBlueColor,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                   // IconButton(
  //                   //   icon: const Icon(Icons.cancel),
  //                   //   onPressed: () {
  //                   //     setState(() {
  //                   //       isChartVisible = false;
  //                   //     });
  //                   //   },
  //                   // ),
  //                 ],
  //               ),
  //               widget.chartData.isEmptyOrNull
  //                   ? const Padding(
  //                       padding: EdgeInsets.only(top: 100.0),
  //                       child: Center(
  //                         child: Text('No Data Found.'),
  //                       ),
  //                     )
  //                   : Expanded(
  //                       child: SfCircularChart(
  //                         legend: const Legend(isVisible: true),
  //                         tooltipBehavior: TooltipBehavior(enable: true),
  //                         series: <CircularSeries>[
  //                           PieSeries<PieChartData, String>(
  //                             // name: 'DWS',
  //                             //innerRadius: '40',
  //                             radius: '85',
  //                             //cornerStyle: CornerStyle.bothCurve,
  //                             legendIconType: LegendIconType.seriesType,
  //                             dataSource: widget.chartData,
  //                             xValueMapper: (PieChartData data, _) => data.x,
  //                             yValueMapper: (PieChartData data, _) => data.y,
  //                             pointColorMapper: (PieChartData data, _) =>
  //                                 data.color,
  //                             dataLabelSettings: const DataLabelSettings(
  //                               isVisible: true,
  //                             ),
  //                             enableTooltip: true,
  //                             explode: true,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }

  Widget build(BuildContext context) {
    return Visibility(
      visible: isChartVisible,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
        padding: const EdgeInsets.all(10),
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
              color:
              const Color(0xFF6474C6).withValues(alpha: 0.09),
              blurRadius: 12,
              offset: const Offset(0, 2),
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
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                    // if (widget.moreIcon != null) widget.moreIcon!,
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Chart or No Data
            widget.chartData.isEmpty
                ? Container(
              height: 200,
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
                    color:
                    const Color(0xFF6474C6).withValues(alpha: 0.09),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'No Data Found',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ),
            )
                : SizedBox(
                height: 300,
                child: SfCircularChart(
                  // legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<PieChartData, String>(
                      radius: '110',
                      legendIconType: LegendIconType.seriesType,
                      dataSource: widget.chartData,
                      xValueMapper: (PieChartData data, _) => data.x,
                      yValueMapper: (PieChartData data, _) => data.y,
                      pointColorMapper: (PieChartData data, index) =>
                      customColors[index % customColors.length],
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      enableTooltip: true,
                      explode: true,
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
                              color:
                              const Color(0xFF6474C6).withValues(alpha: 0.09),
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
