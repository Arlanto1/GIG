import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PieChartApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PieChartApp({Key? key}) : super(key: key);

  @override
  PieChartAppState createState() => PieChartAppState();
}

class PieChartAppState extends State<PieChartApp> {
  final List<PieChartData> chartData = [
    PieChartData('Mumbai', 50, AppColors.lightgreenBackground,),
    PieChartData('North', 25,AppColors.lightblueBackground,),
    PieChartData('South', 25,AppColors.ligtblackBackground),
    // ChartData('Others', 52)
  ];
  @override
  Widget build(BuildContext context) {
    return 
    //Padding(
       // padding: const EdgeInsets.all(20.0),
       // child: 
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
                            'Law Enforcement Visits by Region',
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
                      // color: AppColors.backgroundWhitecolor,
                      child: SfCircularChart(
                          // Enables the tooltip for all the series in chart
                          // Enables the legend
                          legend: Legend(isVisible: true),
                          // palette:const [
                          //   AppColors.lightgreenBackground,
                          //   AppColors.lightblueBackground,
                          //   AppColors.ligtblackBackground
                          // ],
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CircularSeries>[
                            // Initialize line series
                            PieSeries<PieChartData, String>(
                              enableTooltip: true,
                              dataSource: chartData,
                              xValueMapper: (PieChartData data, _) => data.x,
                              yValueMapper: (PieChartData data, _) => data.y,
                              pointColorMapper: (PieChartData data, _) => data.color,
                              // Render the data label
                              // dataLabelSettings:DataLabelSettings(isVisible : true)
                            )
                          ])),
                ],
             // ),
            )));
  }
}

class PieChartData {
  PieChartData(this.x, this.y,this.color);
  final String x;
  final double y;
  final Color color;
}
