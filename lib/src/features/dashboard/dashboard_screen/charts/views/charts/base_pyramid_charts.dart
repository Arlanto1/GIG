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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   isChartVisible = !isChartVisible;
        // });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: isChartVisible,
            child: Container(
              height: 300,
              width: 450,
              decoration: const ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(0.0),
                    bottom: Radius.circular(0.0),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.chartTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.navigationSkyBlueColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.cancel),
                      //   onPressed: () {
                      //     setState(() {
                      //       isChartVisible = false;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                  widget.chartData.isEmptyOrNull
                      ? const Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: Center(
                            child: Text('No Data Found.'),
                          ),
                        )
                      : Expanded(
                          child: SfPyramidChart(
                            legend: const Legend(isVisible: true),
                            series: PyramidSeries<PieChartData, String>(
                              legendIconType: LegendIconType.seriesType,
                              dataSource: widget.chartData,
                              xValueMapper: (PieChartData data, _) => data.x,
                              yValueMapper: (PieChartData data, _) => data.y,
                              pointColorMapper: (PieChartData data, _) =>
                                  data.color,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                // You can further customize the data labels here
                              ),
                              explode: true,
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              builder: (dynamic data,
                                  dynamic point,
                                  dynamic series,
                                  int pointIndex,
                                  int seriesIndex) {
                                return Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 0),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.x} : ${data.y}',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
