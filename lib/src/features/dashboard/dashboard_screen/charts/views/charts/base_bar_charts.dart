import 'package:db_atom/index.dart';

class BaseBarChart extends StatefulWidget {
  final String chartTitle;
  final Widget moreIcon;

  const BaseBarChart({
    Key? key,
    required this.chartTitle,
    required this.moreIcon,
    required List chartData,
  }) : super(key: key);

  @override
  BaseBarChartState createState() => BaseBarChartState();
}

class BaseBarChartState extends State<BaseBarChart> {
  List<BarChartData> chartData = [];
  List<BarChartData> chartData1 = [
    BarChartData(1, 1, AppColors.lightblueBackground),
  ];

  List<BarChartData> chartData2 = [
    BarChartData(1, 1, AppColors.lightblueBackground),
  ];

  List<BarChartData> chartData3 = [
    BarChartData(1, 1, AppColors.lightblueBackground),
    BarChartData(2, 1, AppColors.ligtblackBackground),
    BarChartData(3, 1, AppColors.lightgreenBackground),
    BarChartData(4, 1, AppColors.lightPinkColor),
    BarChartData(5, 1, AppColors.lightOrangeColor),
  ];
  List<BarChartData> chartData4 = [
    BarChartData(1, 500, AppColors.lightblueBackground),
  ];
  List<BarChartData> chartData5 = [
    BarChartData(1, 1, AppColors.ligtblackBackground),
  ];

  @override
  void initState() {
    super.initState();
  }

  List<BarChartData> get chartsData {
    if (widget.chartTitle == Constants.eventProtectionByRegion) {
      return chartData1;
    } else if (widget.chartTitle == Constants.eventProtectionByEntity) {
      return chartData2;
    } else if (widget.chartTitle == Constants.lawEnforcementVisitsByEntity) {
      return chartData3;
    } else if (widget.chartTitle == Constants.eventProtectionAttendees) {
      return chartData4;
    } else if (widget.chartTitle == Constants.eventProtectionBySupport) {
      return chartData5;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: AppColors.navigationSkybluecolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
            bottom: Radius.circular(8.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.chartTitle,
                    style: Styles.textStyleSemiBold16White,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Do action on view
                        },
                        icon: widget.moreIcon,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.0),
                    bottom: Radius.circular(8.0),
                  ),
                ),
              ),
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  isVisible:
                      false, // Set isVisible to false to hide the y-axis labels
                ),
                series: <ChartSeries>[
                  BarSeries<BarChartData, double>(
                    dataSource: chartsData,
                    enableTooltip: true,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    width: 0.3,
                    xValueMapper: (BarChartData data, _) => data.x,
                    yValueMapper: (BarChartData data, _) => data.y,
                    pointColorMapper: (BarChartData data, _) => data.color,
                    emptyPointSettings: EmptyPointSettings(
                      mode: EmptyPointMode.average,
                    ),
                    selectionBehavior: SelectionBehavior(enable: true),
                  ),
                ],
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (dynamic data, dynamic point, dynamic series,
                      int pointIndex, int seriesIndex) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5),
                        ],
                      ),
                      child: Text(
                        '${data.y}',
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
    );
  }
}

class Styles {
  static const TextStyle textStyleSemiBold16White =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white);
}

class BarChartData {
  BarChartData(this.x, this.y, this.color);

  final double x;
  final double y;
  final Color color;
}
