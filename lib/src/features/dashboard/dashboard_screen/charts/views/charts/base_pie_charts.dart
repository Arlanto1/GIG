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
  BasePieChartState createState() => BasePieChartState();
}

class BasePieChartState extends State<BasePieChart> {
  List<PieChartData> chartData1 = [
    PieChartData('DWS', 30, Colors.green),
    PieChartData('DBC', 40, AppColors.lightblueBackground),
    PieChartData('DIPL', 20, AppColors.ligtblackBackground),
    PieChartData('DISPL', 10, AppColors.lightOrangeColor),
    PieChartData('DB CIB', 35, AppColors.lightPinkColor),
  ];

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
                    border: Border(
                        bottom:
                            BorderSide(color: AppColors.boldgreyBackground))),
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
                          color: AppColors.navigationSkybluecolor,
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
                child: SfCircularChart(
                  // title: ChartTitle(
                  //   text: widget.chartTitle,
                  //   textStyle: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // borderColor: AppColors.navigationSkybluecolor,
                  // borderWidth: 1.1,
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<PieChartData, String>(
                      name: 'DWS',
                      //innerRadius: '40',
                      radius: '70',
                      //cornerStyle: CornerStyle.bothCurve,
                      legendIconType: LegendIconType.seriesType,
                      dataSource: chartData1,
                      xValueMapper: (PieChartData data, _) => data.x,
                      yValueMapper: (PieChartData data, _) => data.y,
                      pointColorMapper: (PieChartData data, _) => data.color,
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
      ],
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             widget.chartTitle,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.close),
//             onPressed: () {
//               // Add the logic to close the chart here
//             },
//           ),
//         ],
//       ),
//       Container(
//         height: 300,
//         width: double.infinity,
//         decoration: const ShapeDecoration(
//           color: AppColors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(0.0),
//               bottom: Radius.circular(0.0),
//             ),
//           ),
//         ),
//         child: SfCircularChart(
//           title: ChartTitle(
//             text: widget.chartTitle,
//             textStyle: const TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           borderColor: AppColors.navigationSkybluecolor,
//           borderWidth: 1.1,
//           legend: Legend(isVisible: true),
//           tooltipBehavior: TooltipBehavior(enable: true),
//           series: <CircularSeries>[
//             DoughnutSeries<PieChartData, String>(
//               innerRadius: '40',
//               radius: '70',
//               cornerStyle: CornerStyle.bothCurve,
//               legendIconType: LegendIconType.seriesType,
//               dataSource: chartData1,
//               xValueMapper: (PieChartData data, _) => data.category,
//               yValueMapper: (PieChartData data, _) => data.value,
//               pointColorMapper: (PieChartData data, _) => data.color,
//               dataLabelSettings: const DataLabelSettings(
//                 isVisible: true,
//               ),
//               enableTooltip: true,
//               explode: true,
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
}

