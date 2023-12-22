import 'package:db_atom/index.dart';

class BaseBarChart extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BaseBarChart({
    super.key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  });

  @override
  BaseBarChartState createState() => BaseBarChartState();
}

class BaseBarChartState extends State<BaseBarChart> {
  bool isChartVisible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Visibility(
      visible: isChartVisible,
       child: Container(
          height: 300,
          width: 350,
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
                        color: AppColors.navigationSkybluecolor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        isChartVisible = false;
                      });
                    },
                  ),
                ],
              ),
              CommonWidgets.verticalSpacerWidget(0.1),
              Expanded(
                child: SfCartesianChart(
                  // tooltipBehavior: TooltipBehavior(
                  //   enable: true,
                  //   format: 'point.y',
                  // ),
                  series: <ChartSeries>[
                    BarSeries<PieChartData, num>(
                      dataSource: widget.chartData,
                      legendIconType: LegendIconType.seriesType,
                      width: 0.3,
                      xValueMapper: (PieChartData data, _) =>
                          widget.chartData.indexOf(data),
                      yValueMapper: (PieChartData data, _) => data.y,
                      pointColorMapper: (PieChartData data, _) => data.color,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode.average,
                      ),
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      enableTooltip: true,
                      //selectionBehavior: SelectionBehavior(enable: true),
                    ),
                  ],
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      return Container(
                        padding: const EdgeInsets.all(8),
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
    );
  }
}
