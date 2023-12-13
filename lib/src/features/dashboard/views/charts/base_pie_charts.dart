import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:db_atom/index.dart';

class BasePieChart extends StatefulWidget {
  final String chartTitle;
  final Widget moreIcon;

  const BasePieChart({
    Key? key,
    required this.chartTitle,
    required this.moreIcon,
  }) : super(key: key);

  @override
  _BasePieChartState createState() => _BasePieChartState();
}

class _BasePieChartState extends State<BasePieChart> {
  List<PieChartData> chartData1 = [
    PieChartData('DWS', 30, AppColors.lightgreenBackground),
    PieChartData('DBC', 40, AppColors.lightblueBackground),
    PieChartData('DIPL', 20, AppColors.ligtblackBackground),
    PieChartData('DISPL', 10, AppColors.lightOrangeColor),
    PieChartData('DB CIB', 35, AppColors.lightPinkColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: AppColors.navigationSkybluecolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(1.0),
            bottom: Radius.circular(1.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.chartTitle,
                  style: Styles.textStyleSemiBold16White,
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
                    top: Radius.circular(5.0),
                    bottom: Radius.circular(5.0),
                  ),
                ),
              ),
              child: SfCircularChart(
                margin: EdgeInsets.zero, // Set margin to zero to remove extra space
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CircularSeries>[
                  PieSeries<PieChartData, String>(
                    dataSource: chartData1,
                    xValueMapper: (PieChartData data, _) => data.category,
                    yValueMapper: (PieChartData data, _) => data.value,
                    pointColorMapper: (PieChartData data, _) => data.color,
                    selectionBehavior: SelectionBehavior(enable: true),
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    enableTooltip: true,
                    explode: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartData {
  PieChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}
