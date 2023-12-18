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
  // List<PieChartData> chartData1 = [
  //   PieChartData('DWS', 30, Colors.green),
  //   PieChartData('DBC', 40, AppColors.lightblueBackground),
  //   PieChartData('DIPL', 20, AppColors.ligtblackBackground),
  //   PieChartData('DISPL', 10, AppColors.lightOrangeColor),
  //   PieChartData('DB CIB', 35, AppColors.lightPinkColor),
  // ];

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
          width: 400,
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
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SfCircularChart(
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<PieChartData, String>(
                      // name: 'DWS',
                      //innerRadius: '40',
                      radius: '70',
                      //cornerStyle: CornerStyle.bothCurve,
                      legendIconType: LegendIconType.seriesType,
                      dataSource: widget.chartData,
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
}
