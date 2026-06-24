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
  bool isChartVisible = true;

  @override
  void initState() {
    super.initState();
  }

  final List<List<Color>> gradientColors = [
    [const Color(0xFF8E2DE2), Colors.transparent],
    [const Color(0xFFF7971E), const Color(0xFFFFD200)],
    [const Color(0xFF00BFFF), const Color(0xFF8A2BE2)],
    [const Color(0xFFFF4500), const Color(0xFFFFA500)],
    [const Color(0xFF146CF6), const Color(0xFF00F800)],
    [const Color(0xFF00C6FF), const Color(0xFF0072FF)],
    [const Color(0xFF7CFB8C), const Color(0xFFCAFF56)], // Green → Lime
    [const Color(0xFFFFA36C), const Color(0xFFC75B39)], // Orange → Brown
    [const Color(0xFF42E9E0), const Color(0xFF3DBADF)], // Cyan → Blue
    [const Color(0xFFAF7CFF), const Color(0xFF7B39FF)], // Purple gradient
  ];


  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isTablet = media.size.shortestSide >= 600;

    return Visibility(
      visible: isChartVisible,
      child: Container(
        width: double.infinity,
        height: isTablet
            ? media.size.height / 2.2
            : media.size.height / 2.2,
        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.8),
            width: 0.8,
          ),
          gradient: const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ------------------ TITLE ------------------
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.chartTitle,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ------------------ EMPTY STATE ------------------
            if (widget.chartData.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ),
              )

            /// ------------------ CHART ------------------
            else
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final chartSize = constraints.maxHeight * 0.88;
                    return Center(
                      child: SizedBox(
                        width: chartSize,
                        height: chartSize,
                        child: SfCircularChart(
                          key: UniqueKey(),
                          backgroundColor: Colors.transparent,
                          palette: customGlassColors,
                          tooltipBehavior:
                          TooltipBehavior(enable: true),
                          series: <CircularSeries>[
                            PieSeries<PieChartData, String>(
                              radius: '100%',
                              dataSource: widget.chartData,
                              xValueMapper: (d, _) => d.x,
                              yValueMapper: (d, _) => d.y,
                              strokeColor:
                              Colors.white.withValues(alpha: 0.8),
                              strokeWidth: 1.2,
                              explode: true,
                              explodeOffset:
                              isTablet ? '6%' : '10%',
                              pointRenderMode:
                              PointRenderMode.gradient,
                              dataLabelSettings:
                              DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                  isTablet ? 11 : 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            /// ------------------ LEGEND ------------------
            // if (widget.chartData.isNotEmpty)
            //   const SizedBox(height: 10),

            if (widget.chartData.isNotEmpty)
              SizedBox(
                height: 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.chartData.map((data) {
                      final index =
                      widget.chartData.indexOf(data);
                      final color = customColors[
                      index % customColors.length];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(27),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.newColor
                                  .withValues(alpha: 0.9),
                              AppColors.newColor
                                  .withValues(alpha: 0.9),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.black
                                .withValues(alpha: 0.8),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.newColor
                                  .withValues(alpha: 0.09),
                              blurRadius: 12,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${data.x} (${data.y}%)',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
