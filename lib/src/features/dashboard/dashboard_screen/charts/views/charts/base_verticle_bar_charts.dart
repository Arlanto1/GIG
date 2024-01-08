import 'package:db_atom/index.dart';

class BaseVerticleBarCharts extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BaseVerticleBarCharts({
    super.key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  });

  @override
  BaseVerticleBarChartsState createState() => BaseVerticleBarChartsState();
}

class BaseVerticleBarChartsState extends State<BaseVerticleBarCharts> {
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
                      icon: const Icon(Icons.cancel_rounded),
                      onPressed: () {
                        setState(() {
                          isChartVisible = false;
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: SfCartesianChart(
                    primaryXAxis: const NumericAxis(),
                    primaryYAxis: const NumericAxis(),
                    series: <CartesianSeries>[
                      StackedColumnSeries<PieChartData, num>(
                        enableTooltip: true,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelPosition: ChartDataLabelPosition.outside,
                          labelAlignment: ChartDataLabelAlignment.outer,
                        ),
                        dataSource: widget.chartData,
                        xValueMapper: (PieChartData data, _) =>
                            widget.chartData.indexOf(data),
                        yValueMapper: (PieChartData data, _) => data.y,
                        pointColorMapper: (PieChartData data, _) => data.color,
                        emptyPointSettings: const EmptyPointSettings(
                          mode: EmptyPointMode.average,
                        ),
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
