import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:db_atom/index.dart';

class BaseBarChart extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BaseBarChart({
    Key? key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  }) : super(key: key);

  @override
  BaseBarChartState createState() => BaseBarChartState();
}

class BaseBarChartState extends State<BaseBarChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 280,
          width: double.infinity,
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
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.navigationSkybluecolor,
                  border:  Border(
                    top: BorderSide(color: AppColors.boldgreyBackground,),
                    //bottom: BorderSide(color: AppColors.boldgreyBackground),
                    right: BorderSide(color: AppColors.boldgreyBackground),
                    left: BorderSide(color: AppColors.boldgreyBackground),
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(0.0),
                    bottom: Radius.circular(0.0),
                  ),
                ),
                child: Row(
                  // textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.chartTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        // Handle close button pressed, e.g., Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SfCartesianChart(
                  primaryYAxis: NumericAxis(
                    labelFormat: '',
                    // axisLineStyle: AxisLineStyle(
                    //   thickness: 1.0,
                    //   color: AppColors.boldgreyBackground,
                    // ),
                  ),
                  series: <ChartSeries>[
                    BarSeries<PieChartData, num>(
                      dataSource: widget.chartData,
                      enableTooltip: true,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      width: 0.3,
                      xValueMapper: (PieChartData data, _) =>
                          widget.chartData.indexOf(data),
                      yValueMapper: (PieChartData data, _) => data.y,
                      pointColorMapper: (PieChartData data, _) => data.color,
                      emptyPointSettings: EmptyPointSettings(
                        mode: EmptyPointMode.average,
                      ),
                      selectionBehavior: SelectionBehavior(enable: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
