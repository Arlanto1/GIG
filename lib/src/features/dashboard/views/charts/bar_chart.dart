import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarChartApp({Key? key}) : super(key: key);

  @override
  BarChartAppState createState() => BarChartAppState();
}

class BarChartAppState extends State<BarChartApp> {
  final List<BarChartData> chartData = [
    BarChartData(1, 2, AppColors.lightgreenBackground),
    BarChartData(2, 2, AppColors.lightblueBackground),
    BarChartData(3, 4, AppColors.ligtblackBackground),
  ];

  @override
  Widget build(BuildContext context) {
    return
        Container(
            //height: 260,
            decoration: const ShapeDecoration(
                color: AppColors.navigationSkybluecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8.0), bottom: Radius.circular(8.0)),
                )),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Law Enforcement Visits by Entities',
                              style: Styles.textStyleSemiBold16White,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    //do action on view
                                  },
                                  icon: SvgPicture.asset(AppIcon.moreicon),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    Container(
                        decoration: const ShapeDecoration(
                            color: AppColors.backgroundWhitecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.0),
                                  bottom: Radius.circular(8.0)),
                            )),
                        child:
                            // Initialize the chart widget
                            // SfCartesianChart(
                            //     primaryXAxis: CategoryAxis(),
                            //     // Chart title
                            //     title:
                            //         ChartTitle(text: 'Half yearly sales analysis'),
                            //     // Enable legend
                            //     legend: Legend(isVisible: true),
                            //     // Enable tooltip
                            //     tooltipBehavior: TooltipBehavior(enable: true),
                            //     series: <ChartSeries<_SalesData, String>>[
                            //   LineSeries<_SalesData, String>(
                            //       dataSource: data,
                            //       xValueMapper: (_SalesData sales, _) => sales.year,
                            //       yValueMapper: (_SalesData sales, _) =>
                            //           sales.sales,
                            //       name: 'Sales',
                            //       // Enable data label
                            //       dataLabelSettings:
                            //           DataLabelSettings(isVisible: true))
                            // ]),
                            SfCartesianChart(series: <ChartSeries>[
                          BarSeries<BarChartData, double>(
                              dataSource: chartData,

                              // Renders the track
                              enableTooltip: true,
                              // isTrackVisible: true,
                              // Width of the bars
                              width: 0.3,
                              xValueMapper: (BarChartData data, _) => data.x,
                              yValueMapper: (BarChartData data, _) => data.y,
                              pointColorMapper: (BarChartData data, _) =>
                                  data.color,
                              emptyPointSettings: EmptyPointSettings(
                                  // Mode of empty point
                                  mode: EmptyPointMode.average))
                        ])),
                  ],
                  // ),
                )));
  }
}
class BarChartData {
  BarChartData(this.x, this.y, this.color);

  final double x;
  final double y;
  final Color color;
}
