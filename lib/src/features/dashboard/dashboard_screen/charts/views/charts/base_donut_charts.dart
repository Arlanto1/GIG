// import 'dart:async';
// import 'package:db_atom/index.dart';
// class BaseDonutChart extends StatefulWidget {
//   final String chartTitle;
//   final List<PieChartData> chartData;
//   final Widget? moreIcon;
//
//   const BaseDonutChart({
//     super.key,
//     required this.chartTitle,
//     required this.chartData,
//     this.moreIcon,
//   });
//
//   @override
//   State<BaseDonutChart> createState() => _BaseDonutChartState();
// }
//
// class _BaseDonutChartState extends State<BaseDonutChart>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   bool isChartVisible = true;
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context);
//     final isTablet = media.size.shortestSide >= 600;
//
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         width: double.infinity,
//         height: isTablet
//             ? media.size.height / 2.2
//             : media.size.height / 2.2,
//         margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(27),
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.8),
//             width: 0.8,
//           ),
//           gradient: const LinearGradient(
//             colors: [
//               Colors.transparent,
//               Colors.transparent,
//               Colors.transparent,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// ------------------ TITLE ------------------
//             Row(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       widget.chartTitle,
//                       style: const TextStyle(
//                         fontSize: 19,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 12),
//
//             /// ------------------ EMPTY STATE ------------------
//             if (widget.chartData.isEmpty)
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     'No Data Found',
//                     style: TextStyle(
//                       color: Colors.white.withValues(alpha: 0.9),
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               )
//
//             /// ------------------ CHART ------------------
//             else
//               Expanded(
//                 child: LayoutBuilder(
//                   builder: (context, constraints) {
//                     final chartSize = constraints.maxHeight * 0.88;
//                     return Center(
//                       child: SizedBox(
//                         width: chartSize,
//                         height: chartSize,
//                         child: SfCircularChart(
//                           backgroundColor: Colors.transparent,
//                           palette: customGlassColors,
//                           tooltipBehavior:
//                           TooltipBehavior(enable: true),
//                           series: <CircularSeries>[
//                             DoughnutSeries<PieChartData, String>(
//                               radius: '100%',
//                               innerRadius: '55%',
//                               dataSource: widget.chartData,
//                               xValueMapper: (d, _) => d.x,
//                               yValueMapper: (d, _) => d.y,
//                               strokeColor:
//                               Colors.white.withValues(alpha: 0.8),
//                               strokeWidth: 1.2,
//                               explode: true,
//                               explodeOffset:
//                               isTablet ? '6%' : '10%',
//                               pointRenderMode:
//                               PointRenderMode.gradient,
//                               dataLabelSettings:
//                               DataLabelSettings(
//                                 isVisible: true,
//                                 textStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize:
//                                   isTablet ? 11 : 13,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//             /// ------------------ LEGEND ------------------
//             if (widget.chartData.isNotEmpty)
//               const SizedBox(height: 10),
//
//             if (widget.chartData.isNotEmpty)
//               SizedBox(
//                 height: 50,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: widget.chartData.map((data) {
//                       final index =
//                       widget.chartData.indexOf(data);
//                       final color = customColors[
//                       index % customColors.length];
//
//                       return Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 6),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 6),
//                         decoration: BoxDecoration(
//                           borderRadius:
//                           BorderRadius.circular(27),
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.newColor
//                                   .withValues(alpha: 0.9),
//                               AppColors.newColor
//                                   .withValues(alpha: 0.9),
//                             ],
//                           ),
//                           border: Border.all(
//                             color: Colors.black
//                                 .withValues(alpha: 0.8),
//                             width: 1,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.newColor
//                                   .withValues(alpha: 0.09),
//                               blurRadius: 12,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               '${data.x} (${data.y}%)',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math' as math;
import 'package:db_atom/index.dart';

const String kGigFont = 'Poppins';

/// Half-circle "tick" gauge card. Drop-in replacement for BaseDonutChart.
/// - 1 data item  -> ticks fade indigo -> copper
/// - 2+ data items -> ticks are split by share, one palette colour per item
class BaseGaugeChart extends StatelessWidget {
  final String chartTitle;
  final List<PieChartData> chartData;
  final Widget? moreIcon; // kept so existing call sites compile

  const BaseGaugeChart({
    super.key,
    required this.chartTitle,
    required this.chartData,
    this.moreIcon,
  });

  static const int _tickCount = 46;

  double _value(PieChartData d) => double.tryParse(d.y.toString()) ?? 0;

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);

  List<Color> _tickColors(double total) {
    if (chartData.length == 1) {
      return List.generate(
        _tickCount,
            (i) => Color.lerp(
            GigColors.indigo, GigColors.copper, i / (_tickCount - 1))!,
      );
    }
    final colors = <Color>[];
    double acc = 0;
    for (int s = 0; s < chartData.length; s++) {
      acc += _value(chartData[s]);
      final end = total == 0 ? 0 : (acc / total * _tickCount).round();
      final c = GigColors.segmentPalette[s % GigColors.segmentPalette.length];
      while (colors.length < end) {
        colors.add(c);
      }
    }
    final fill = colors.isEmpty ? GigColors.border : colors.last;
    while (colors.length < _tickCount) {
      colors.add(fill);
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    final total = chartData.fold<double>(0, (s, d) => s + _value(d));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: GigColors.indigo.withValues(alpha: 0.10),
            blurRadius: 34,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ---------------- TITLE + LIVE BADGE ----------------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  chartTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: kGigFont,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                    color: GigColors.indigo,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const _LiveBadge(),
            ],
          ),

          /// ---------------- EMPTY STATE ----------------
          if (chartData.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 56),
              child: Text(
                'No Data Found',
                style: TextStyle(
                  fontFamily: kGigFont,
                  fontSize: 14,
                  color: GigColors.muted,
                ),
              ),
            )
          else ...[
            /// ---------------- GAUGE ----------------
            const SizedBox(height: 10),
            SizedBox(
              width: 260,
              height: 140,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, t, _) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GaugePainter(_tickColors(total), t),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _fmt(total),
                              style: const TextStyle(
                                fontFamily: kGigFont,
                                fontSize: 64,
                                fontWeight: FontWeight.w700,
                                height: 0.9,
                                color: GigColors.indigo,
                              ),
                            ),
                            const Text(
                              'TOTAL VISITS',
                              style: TextStyle(
                                fontFamily: kGigFont,
                                fontSize: 11,
                                letterSpacing: 1.5,
                                color: GigColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// ---------------- LEGEND ----------------
            const SizedBox(height: 14),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (int i = 0; i < chartData.length; i++)
                  _LegendPill(
                    label: chartData[i].x.toString(),
                    percent: '${_fmt(_value(chartData[i]))}%',
                    color: chartData.length == 1
                        ? GigColors.copper
                        : GigColors.segmentPalette[
                    i % GigColors.segmentPalette.length],
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final List<Color> colors;
  final double progress;

  _GaugePainter(this.colors, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 260;
    final center = Offset(size.width / 2, size.height - 10 * s);
    final outer = 118 * s;
    final inner = 94 * s;
    final n = colors.length;
    final visible = (n * progress).ceil();

    final paint = Paint()
      ..strokeWidth = 4 * s
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < visible; i++) {
      final a = math.pi + math.pi * i / (n - 1); // left -> top -> right
      final dir = Offset(math.cos(a), math.sin(a));
      paint.color = colors[i];
      canvas.drawLine(center + dir * inner, center + dir * outer, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) =>
      old.progress != progress || old.colors != colors;
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: GigColors.liveBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Text(
        '• Live',
        style: TextStyle(
          fontFamily: kGigFont,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: GigColors.liveText,
        ),
      ),
    );
  }
}

class _LegendPill extends StatelessWidget {
  final String label;
  final String percent;
  final Color color;

  const _LegendPill({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: GigColors.lavender,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: kGigFont,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: GigColors.indigo,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            percent,
            style: TextStyle(
              fontFamily: kGigFont,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}