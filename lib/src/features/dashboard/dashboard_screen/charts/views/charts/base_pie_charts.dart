import 'dart:ui' as ui show Shader, Gradient, ImageFilter;
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

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       Visibility(
  //         visible: isChartVisible,
  //         child: Container(
  //           height: 400,
  //           width: 380,
  //           decoration: const ShapeDecoration(
  //             color: Colors.white54,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.vertical(
  //                 top: Radius.circular(2.0),
  //                 bottom: Radius.circular(2.0),
  //               ),
  //             ),
  //           ),
  //           child: Column(
  //             children: [
  //               Row(
  //                 // textDirection: TextDirection.rtl,
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text(
  //                       widget.chartTitle,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: AppColors.navigationSkyBlueColor,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                   // IconButton(
  //                   //   icon: const Icon(Icons.cancel),
  //                   //   onPressed: () {
  //                   //     setState(() {
  //                   //       isChartVisible = false;
  //                   //     });
  //                   //   },
  //                   // ),
  //                 ],
  //               ),
  //               widget.chartData.isEmptyOrNull
  //                   ? const Padding(
  //                       padding: EdgeInsets.only(top: 100.0),
  //                       child: Center(
  //                         child: Text('No Data Found.'),
  //                       ),
  //                     )
  //                   : Expanded(
  //                       child: SfCircularChart(
  //                         legend: const Legend(isVisible: true),
  //                         tooltipBehavior: TooltipBehavior(enable: true),
  //                         series: <CircularSeries>[
  //                           PieSeries<PieChartData, String>(
  //                             // name: 'DWS',
  //                             //innerRadius: '40',
  //                             radius: '85',
  //                             //cornerStyle: CornerStyle.bothCurve,
  //                             legendIconType: LegendIconType.seriesType,
  //                             dataSource: widget.chartData,
  //                             xValueMapper: (PieChartData data, _) => data.x,
  //                             yValueMapper: (PieChartData data, _) => data.y,
  //                             pointColorMapper: (PieChartData data, _) =>
  //                                 data.color,
  //                             dataLabelSettings: const DataLabelSettings(
  //                               isVisible: true,
  //                             ),
  //                             enableTooltip: true,
  //                             explode: true,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
// }

  // Widget build(BuildContext context) {
  //   return Visibility(
  //     visible: isChartVisible,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width -100,
  //       height: MediaQuery.of(context).size.height/2.17,
  //       // margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
  //       // padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             Colors.white.withValues(alpha: 0.2),
  //             Colors.transparent,
  //             Colors.white.withValues(alpha: 0.2),
  //           ],
  //           stops: [0.02, 0.35, 1],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //         ),
  //         borderRadius: BorderRadius.circular(27),
  //         border: Border.all(
  //           color: Colors.white.withValues(alpha: 0.80),
  //           width: 0.8,
  //         ),
  //         boxShadow: [
  //           BoxShadow(
  //             color: const Color(0xFF6474C6).withValues(alpha: 0.09),
  //             blurRadius: 12,
  //             offset: const Offset(0, 2),
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Header Row
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Expanded(
  //                 child: SingleChildScrollView(
  //                   scrollDirection: Axis.horizontal,
  //                   child: Text(
  //                     widget.chartTitle,
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                       fontSize: 19,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               // if (widget.moreIcon != null) widget.moreIcon!,
  //             ],
  //           ),
  //
  //           const SizedBox(height: 12),
  //
  //           // Chart or No Data
  //           widget.chartData.isEmpty
  //               ? Container(
  //                   height: 200,
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [
  //                         Colors.white.withValues(alpha: 0.2),
  //                         Colors.transparent,
  //                         Colors.white.withValues(alpha: 0.2),
  //                       ],
  //                       stops: [0.02, 0.35, 1],
  //                       begin: Alignment.topCenter,
  //                       end: Alignment.bottomCenter,
  //                     ),
  //                     borderRadius: BorderRadius.circular(27),
  //                     border: Border.all(
  //                       color: Colors.white.withValues(alpha: 0.80),
  //                       width: 0.8,
  //                     ),
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color:
  //                             const Color(0xFF6474C6).withValues(alpha: 0.09),
  //                         blurRadius: 12,
  //                         offset: const Offset(0, 2),
  //                       ),
  //                     ],
  //                   ),
  //                   child: const Center(
  //                     child: Text(
  //                       'No Data Found',
  //                       style: TextStyle(color: Colors.black54, fontSize: 14),
  //                     ),
  //                   ),
  //                 )
  //               :
  //               // SizedBox(
  //               //     height: 300,
  //               //     child: SfCircularChart(
  //               //       // legend: const Legend(isVisible: true),
  //               //       tooltipBehavior: TooltipBehavior(enable: true),
  //               //       series: <CircularSeries>[
  //               //         // PieSeries<PieChartData, String>(
  //               //         //   radius: '110',
  //               //         //   legendIconType: LegendIconType.seriesType,
  //               //         //   dataSource: widget.chartData,
  //               //         //   xValueMapper: (PieChartData data, _) => data.x,
  //               //         //   yValueMapper: (PieChartData data, _) => data.y,
  //               //         //   pointColorMapper: (PieChartData data, index) =>
  //               //         //   customColors[index % customColors.length],
  //               //         //   dataLabelSettings: const DataLabelSettings(
  //               //         //     isVisible: true,
  //               //         //   ),
  //               //         //   enableTooltip: true,
  //               //         //   explode: true,
  //               //         // ),
  //               //         PieSeries<PieChartData, String>(
  //               //           radius: '110',
  //               //           legendIconType: LegendIconType.seriesType,
  //               //           dataSource: widget.chartData,
  //               //           xValueMapper: (PieChartData data, _) => data.x,
  //               //           yValueMapper: (PieChartData data, _) => data.y,
  //               //           pointColorMapper: (PieChartData data, index) =>
  //               //           customGlassColors[index % customGlassColors.length], // translucent colors
  //               //           dataLabelSettings: const DataLabelSettings(
  //               //             isVisible: true,
  //               //             textStyle: TextStyle(
  //               //               color: Colors.white, // for contrast on glass
  //               //               shadows: [
  //               //                 Shadow(
  //               //                   color: Colors.black26,
  //               //                   blurRadius: 6,
  //               //                   offset: Offset(1, 1),
  //               //                 ),
  //               //               ],
  //               //             ),
  //               //           ),
  //               //           enableTooltip: true,
  //               //           explode: true,
  //               //         )
  //
  //               //       ],
  //               //     ),
  //               //   ),
  //
  //               Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     // 1. Your original, textured or gradient background
  //                     // Positioned.fill(
  //                     // child: Image.asset('assets/your_blurred_background.jpg', fit: BoxFit.cover),
  //                     // ),
  //                     // 2. Circular blur overlay, matching the pie's size and position
  //                     Center(
  //                       child: ClipOval(
  //                         child: BackdropFilter(
  //                           filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
  //                           child: Container(
  //                             width: 300,
  //                             height: 300,
  //                             // width: MediaQuery.of(context).size.width,
  //                             // height: MediaQuery.of(context).size.height / 20,
  //                             color:
  //                                 Colors.white.withOpacity(0.30), // Slight tint
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     // 3. The actual PieChart, with translucent colors
  //                     SfCircularChart(
  //                       backgroundColor: Colors.transparent,
  //                       // palette: <Color>[Colors.amber.withValues(alpha: 0.5), Colors.brown.withValues(alpha: 0.5), Colors.green.withValues(alpha: 0.5), Colors.purple.withValues(alpha: 0.5), Colors.teal.withValues(alpha: 0.5),const Color(0xFFFF4500).withValues(alpha: 0.5), const Color(0xFFdc3545).withValues(alpha: 0.5),   const Color(0xFF003f5c).withValues(alpha: 0.4)],
  //                       palette: customGlassColors,
  //                       // legend: const Legend(isVisible: true),
  //                       tooltipBehavior: TooltipBehavior(enable: true),
  //                       series: <CircularSeries>[
  //                         PieSeries<PieChartData, String>(
  //                           radius: '140',
  //                           // legendIconType: LegendIconType.seriesType,
  //
  //                           dataSource: widget.chartData,
  //                           xValueMapper: (d, _) => d.x,
  //                           yValueMapper: (d, _) => d.y,
  //                           strokeColor: Colors.white.withOpacity(0.8),
  //                           pointRenderMode: PointRenderMode.gradient,
  //
  //                           strokeWidth: 1.2,
  //                           explode: true,
  //                           explodeOffset: '10%',
  //                           pointColorMapper: (PieChartData d, int? i) {
  //                             final index = i ?? 0;
  //                             // Return gradient start color
  //                             return gradientColors[
  //                                     index % gradientColors.length]
  //                                 .first;
  //                           },
  //
  //                           dataLabelSettings: const DataLabelSettings(
  //                             isVisible: true,
  //                             textStyle: TextStyle(color: Colors.white),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //
  //           const SizedBox(height: 10),
  //
  //           // Custom Scrollable Legend
  //           if (widget.chartData.isNotEmpty)
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width,
  //               height: MediaQuery.of(context).size.height / 20,
  //               child: SingleChildScrollView(
  //                 scrollDirection: Axis.horizontal,
  //                 child: Row(
  //                   children: widget.chartData.map((data) {
  //                     final color = customColors[
  //                         widget.chartData.indexOf(data) % customColors.length];
  //                     return Container(
  //                       margin: const EdgeInsets.symmetric(horizontal: 6),
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 12, vertical: 6),
  //                       decoration: BoxDecoration(
  //                         gradient: LinearGradient(
  //                           colors: [
  //                             Colors.white.withValues(alpha: 0.2),
  //                             Colors.transparent,
  //                             Colors.white.withValues(alpha: 0.2),
  //                           ],
  //                           stops: [0.02, 0.35, 1],
  //                           begin: Alignment.topCenter,
  //                           end: Alignment.bottomCenter,
  //                         ),
  //                         borderRadius: BorderRadius.circular(27),
  //                         border: Border.all(
  //                           color: Colors.white.withValues(alpha: 0.80),
  //                           width: 0.8,
  //                         ),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: const Color(0xFF6474C6)
  //                                 .withValues(alpha: 0.09),
  //                             blurRadius: 12,
  //                             offset: const Offset(0, 2),
  //                           ),
  //                         ],
  //                       ),
  //                       child: Row(
  //                         children: [
  //                           Container(
  //                             width: 10,
  //                             height: 10,
  //                             decoration: BoxDecoration(
  //                               color: color,
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 6),
  //                           Text(
  //                             '${data.x} (${data.y}%)',
  //                             style: const TextStyle(
  //                               fontSize: 13,
  //                               fontWeight: FontWeight.w500,
  //                               color: Color(0xFF333333),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Visibility(
      visible: isChartVisible,
      child: Container(
        // width: 200,
        // width: screenWidth - 20,
        height: screenHeight / 2.16,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.2),
              Colors.transparent,
              Colors.white.withValues(alpha: 0.2),
            ],
            stops: [0.02, 0.35, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(27),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.80),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6474C6).withValues(alpha: 0.09),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ---------- TITLE ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.chartTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 19,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ---------- NO DATA ----------
            if (widget.chartData.isEmpty)
              Container(
                height: screenHeight * 0.25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.2),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.2),
                    ],
                    stops: [0.02, 0.35, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.80),
                    width: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6474C6).withValues(alpha: 0.09),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'No Data Found',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ),
              )
            else
            // ---------- RESPONSIVE PIE CHART ----------
              SizedBox(
                height: screenHeight * 0.29,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ---------- BLUR GLASS CIRCLE ----------
                    ClipOval(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                        child: Container(
                          width: screenWidth * 0.60,
                          height: screenWidth * 0.60,
                          color: Colors.white.withOpacity(0.30),
                        ),
                      ),
                    ),

                    // ---------- PIE CHART ----------
                    SfCircularChart(
                      backgroundColor: Colors.transparent,
                      palette: customGlassColors,
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CircularSeries>[
                        PieSeries<PieChartData, String>(
                          radius: '${screenWidth * 0.28}',
                          dataSource: widget.chartData,
                          xValueMapper: (d, _) => d.x,
                          yValueMapper: (d, _) => d.y,
                          strokeColor: Colors.white.withOpacity(0.8),
                          strokeWidth: 1.2,
                          explode: true,
                          explodeOffset: '10%',
                          pointRenderMode: PointRenderMode.gradient,
                          pointColorMapper: (PieChartData d, int? index) {
                            return gradientColors[
                            (index ?? 0) % gradientColors.length]
                                .first;
                          },
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            // ---------- CUSTOM LEGEND ----------
            if (widget.chartData.isNotEmpty)
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.06,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.chartData.map((data) {
                      final color = customColors[
                      widget.chartData.indexOf(data) % customColors.length];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0.2),
                              Colors.transparent,
                              Colors.white.withValues(alpha: 0.2),
                            ],
                            stops: [0.02, 0.35, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(27),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.80),
                            width: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6474C6)
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
                                color: Color(0xFF333333),
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

// import 'dart:ui';
// import 'package:db_atom/index.dart';
//
// class BasePieChart extends StatefulWidget {
//   final List<PieChartData> chartData;
//   final String chartTitle;
//   final Widget moreIcon;
//
//   const BasePieChart({
//     super.key,
//     required this.chartTitle,
//     required this.moreIcon,
//     required this.chartData,
//   });
//
//   @override
//   BasePieChartState createState() => BasePieChartState();
// }
//
// class BasePieChartState extends State<BasePieChart> {
//   bool isChartVisible = true;
//
//   // Glass morphism colors
//   final List<Color> customGlassColors = [
//     const Color(0xFF8B5CF6).withValues(alpha: 0.7), // Purple
//     const Color(0xFFC084FC).withValues(alpha: 0.7), // Light Purple
//     const Color(0xFFA78BFA).withValues(alpha: 0.7), // Lavender
//     const Color(0xFF7C3AED).withValues(alpha: 0.7), // Deep Purple
//     const Color(0xFF6D28D9).withValues(alpha: 0.7), // Darker Purple
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           // Gradient background
//           gradient: LinearGradient(
//             colors: [
//               Colors.white.withValues(alpha: 0.25),
//               Colors.white.withValues(alpha: 0.1),
//               Colors.white.withValues(alpha: 0.25),
//             ],
//             stops: const [0.0, 0.5, 1.0],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(32),
//           border: Border.all(
//             color: Colors.white.withValues(alpha: 0.85),
//             width: 1.2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF6474C6).withValues(alpha: 0.12),
//               blurRadius: 20,
//               offset: const Offset(0, 4),
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         // Glassmorphic effect with backdrop filter
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(32),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Header Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Text(
//                           widget.chartTitle,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                             fontSize: 22,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 12),
//                       child: widget.moreIcon,
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Chart Content
//                 if (widget.chartData.isEmpty)
//                 // No Data State
//                   Container(
//                     height: 250,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.white.withValues(alpha: 0.15),
//                           Colors.white.withValues(alpha: 0.05),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(
//                         color: Colors.white.withValues(alpha: 0.6),
//                         width: 1,
//                       ),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'No Data Found',
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   )
//                 else
//                 // Pie Chart with Glass Morphism
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Blurred background circle
//                       Container(
//                         width: 280,
//                         height: 280,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: RadialGradient(
//                             colors: [
//                               Colors.white.withValues(alpha: 0.2),
//                               Colors.white.withValues(alpha: 0.05),
//                             ],
//                             stops: const [0.0, 1.0],
//                           ),
//                         ),
//                         child: ClipOval(
//                           child: BackdropFilter(
//                             filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//                             child: Container(
//                               color: Colors.transparent,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // Actual Pie Chart
//                       SizedBox(
//                         height: 320,
//                         width: 320,
//                         child: SfCircularChart(
//                           backgroundColor: Colors.transparent,
//                           tooltipBehavior: TooltipBehavior(
//                             enable: true,
//                             color: Colors.black87,
//                             textStyle: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                             ),
//                             borderColor: Colors.white.withValues(alpha: 0.5),
//                             borderWidth: 1,
//                           ),
//                           series: <CircularSeries>[
//                             PieSeries<PieChartData, String>(
//                               radius: '110',
//                               // innerRadius: '35',
//                               dataSource: widget.chartData,
//                               xValueMapper: (PieChartData data, _) => data.x,
//                               yValueMapper: (PieChartData data, _) => data.y,
//                               pointColorMapper: (PieChartData data, index) =>
//                               customGlassColors[
//                               index % customGlassColors.length],
//                               dataLabelSettings: const DataLabelSettings(
//                                 isVisible: true,
//                                 textStyle: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   shadows: [
//                                     Shadow(
//                                       color: Colors.black26,
//                                       blurRadius: 4,
//                                       offset: Offset(1, 1),
//                                     ),
//                                   ],
//                                 ),
//                                 // labelFormat: '{value}%',
//                               ),
//                               enableTooltip: true,
//                               explode: true,
//                               explodeOffset: '8%',
//                               emptyPointSettings: EmptyPointSettings(
//                                 color: Colors.grey.withValues(alpha: 0.3),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//
//                 const SizedBox(height: 20),
//
//                 // Custom Scrollable Legend
//                 if (widget.chartData.isNotEmpty)
//                   SizedBox(
//                     height: 60,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: widget.chartData.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final data = entry.value;
//                           final color = customGlassColors[
//                           index % customGlassColors.length];
//
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 14,
//                                 vertical: 8,
//                               ),
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.white.withValues(alpha: 0.2),
//                                     Colors.white.withValues(alpha: 0.08),
//                                   ],
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                 ),
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: Colors.white.withValues(alpha: 0.85),
//                                   width: 0.8,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: const Color(0xFF6474C6)
//                                         .withValues(alpha: 0.1),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: BackdropFilter(
//                                   filter: ImageFilter.blur(
//                                       sigmaX: 10, sigmaY: 10),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Container(
//                                         width: 12,
//                                         height: 12,
//                                         decoration: BoxDecoration(
//                                           color: color,
//                                           shape: BoxShape.circle,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: color
//                                                   .withValues(alpha: 0.4),
//                                               blurRadius: 4,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         '${data.x} (${data.y.toStringAsFixed(0)}%)',
//                                         style: const TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black87,
//                                           letterSpacing: 0.3,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

// class BasePieChart extends StatefulWidget {
//   final List<PieChartData> chartData;
//   final String chartTitle;
//   final Widget moreIcon;
//
//   const BasePieChart({
//     super.key,
//     required this.chartTitle,
//     required this.moreIcon,
//     required this.chartData,
//   });
//
//   @override
//   BasePieChartState createState() => BasePieChartState();
// }
//
// class BasePieChartState extends State<BasePieChart> {
//   bool isChartVisible = true;
//
//   /// PURE glass colors (light white translucent)
//   final List<Color> glassColors = [
//     Colors.white70,
//     Colors.white60,
//     Colors.white54,
//     Colors.white38,
//     Colors.white30,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isChartVisible,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.white.withOpacity(0.128),
//               Colors.white.withOpacity(0.12),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(32),
//           border: Border.all(
//             color: Colors.white.withOpacity(0.8),
//             width: 1.2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.deepPurple.shade900.withOpacity(0.20),
//               blurRadius: 25,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(32),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // HEADER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.chartTitle,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 22,
//                       ),
//                     ),
//                     widget.moreIcon
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // ⭐ PIE CHART (exact frosted look)
//                 Center(
//                   child: SizedBox(
//                     height: 280,
//                     width: 280,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // Outer frosted radial glow (same as sample)
//                         Container(
//                           width: 260,
//                           height: 260,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: RadialGradient(
//                               colors: [
//                                 Colors.red.withOpacity(0.35),
//                                 Colors.pink.withOpacity(0.05),
//                               ],
//                               stops: const [0.0, 1.0],
//                             ),
//                           ),
//                         ),
//
//                         // ❤️ Actual PIE chart
//                         SfCircularChart(
//                           backgroundColor: Colors.transparent,
//                           margin: EdgeInsets.zero,
//                           series: <CircularSeries>[
//                             PieSeries<PieChartData, String>(
//                               dataSource: widget.chartData,
//                               xValueMapper: (PieChartData data, _) => data.x,
//                               yValueMapper: (PieChartData data, _) => data.y,
//
//                               /// ⭐ EXACT GLASS LOOK LIKE IMAGE
//                               pointColorMapper: (_, i) =>
//                                   customColors[i % customColors.length]
//                                       .withOpacity(0.15),
//
//                               /// ⭐ Creates slice GAPS like the image
//                               strokeColor: Colors.purple.withOpacity(0.8),
//                               strokeWidth: 0.5,
//
//                               /// ⭐ Strong explode gap matching your image
//                               explode: true,
//                               explodeOffset: '10%',
//
//                               dataLabelSettings: const DataLabelSettings(
//                                 isVisible: false,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
