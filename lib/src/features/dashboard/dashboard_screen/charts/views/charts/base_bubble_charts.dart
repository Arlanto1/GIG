import 'package:db_atom/index.dart';

class BaseBubbleChart extends StatefulWidget {
  final List<PieChartData> chartData;
  final String chartTitle;
  final Widget moreIcon;

  const BaseBubbleChart({
    Key? key,
    required this.chartTitle,
    required this.moreIcon,
    required this.chartData,
  }) : super(key: key);

  @override
  BaseBubbleChartState createState() => BaseBubbleChartState();
}

class BaseBubbleChartState extends State<BaseBubbleChart> {
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
                child: SfCartesianChart(
                  // Adjust the chart type to BubbleSeries
                  series: <CartesianSeries>[
                    BubbleSeries<PieChartData, num>(
                      dataSource: widget.chartData,
                      xValueMapper: (PieChartData data, _) =>
                          widget.chartData.indexOf(data),
                      yValueMapper: (PieChartData data, _) => data.y,
                      // sizeValueMapper: (PieChartData data, _) => data.size,
                      pointColorMapper: (PieChartData data, _) => data.color,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                  // Other chart properties like axis, legend, etc., can be added here
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
