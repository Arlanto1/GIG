import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';

class EventProtectionDetails extends StatelessWidget {
  final String id;
  final String title;
  final int eventStatus;
  final bool isEventProtection;
  final ShowEPGridsModel showEPGridsModel;

  EventProtectionDetails({
    super.key,
    required this.id,
    required this.title,
    required this.eventStatus,
    required this.showEPGridsModel,
    required this.isEventProtection,
  });

  final EventProtectionServices services = EventProtectionServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.newColor3,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: title ?? Constants.eventProtectionTitle,
        showPopUp: false,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
      ),
      body: SingleChildScrollView(
        child: Align(
            // alignment: Alignment.center,
            child: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Wrap(
              //     children: [
              //       // InkWell(
              //         onTap: () async {
              //           NavigatorState nav = Navigator.of(context);
              //           bool? showGuardInfo = false;
              //           if (id.isNotEmpty) {
              //             ShowGuardInfoResponse showGuardInfoResponse =
              //                 await services.showGuardInfo(id);
              //             showGuardInfo = showGuardInfoResponse.showGuardInfo;
              //           }
              //           nav.pushNamed(
              //             title == Constants.annualPowerShutdownListDetails
              //                 ? annualPowerShutdownListDetailsRoute
              //                 : eventProtectionGeneralInfoGIRoute, // change it
              //             arguments: {
              //               'id': id,
              //               'showGuardInfo': showGuardInfo,
              //             },
              //           );
              //         },
              //       //   child: _rowCard(
              //       //   // Tile(
              //       //     label: 'General\nInformation',
              //       //     // height: height,
              //       //   ),
              //       // ),
              //       _rowCard(
              //         icon: 'assets/images/gunMan1.png',
              //         label: "Gun Man",
              //         onTap: () async {
              //           NavigatorState nav = Navigator.of(context);
              //           bool? showGuardInfo = false;
              //           if (id.isNotEmpty) {
              //             ShowGuardInfoResponse showGuardInfoResponse =
              //                 await services.showGuardInfo(id);
              //             showGuardInfo = showGuardInfoResponse.showGuardInfo;
              //           }
              //           nav.pushNamed(
              //             title == Constants.annualPowerShutdownListDetails
              //                 ? annualPowerShutdownListDetailsRoute
              //                 : eventProtectionGeneralInfoGIRoute, // change it
              //             arguments: {
              //               'id': id,
              //               'showGuardInfo': showGuardInfo,
              //             },
              //           );
              //         },
              //       ),
              //
              //       _rowCard(
              //         icon: 'assets/images/gunMan1.png',
              //         label: "Gun Man",
              //         onTap: () async {
              //           NavigatorState nav = Navigator.of(context);
              //           bool? showGuardInfo = false;
              //           if (id.isNotEmpty) {
              //             ShowGuardInfoResponse showGuardInfoResponse =
              //             await services.showGuardInfo(id);
              //             showGuardInfo = showGuardInfoResponse.showGuardInfo;
              //           }
              //           nav.pushNamed(
              //             title == Constants.annualPowerShutdownListDetails
              //                 ? annualPowerShutdownListDetailsRoute
              //                 : eventProtectionGeneralInfoGIRoute, // change it
              //             arguments: {
              //               'id': id,
              //               'showGuardInfo': showGuardInfo,
              //             },
              //           );
              //         },
              //       ),
              //
              //       /// Before Tile
              //       if (showEPGridsModel.before ?? false) ...[
              //         InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               eventInfoRoute,
              //               arguments: {
              //                 'title': Constants.beforeEventInformation,
              //                 'id': id,
              //                 'eventDuration': 0,
              //                 ConstantsArgument.isEventProtection:
              //                     isEventProtection,
              //                 ConstantsArgument.editForm:
              //                     showEPGridsModel.editBefore,
              //               },
              //             );
              //           },
              //           child: Tile(
              //             label: 'Before the Event\nInformation',
              //             height: height,
              //             icon: Icons.event,
              //           ),
              //         ),
              //       ],
              //
              //       /// During Tile
              //       if (showEPGridsModel.during ?? false) ...[
              //         InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               eventInfoRoute,
              //               arguments: {
              //                 'title': Constants.duringEventInformation,
              //                 'id': id,
              //                 'eventDuration': 1,
              //                 ConstantsArgument.editForm:
              //                     showEPGridsModel.editDuring,
              //                 ConstantsArgument.isEventProtection:
              //                     isEventProtection,
              //               },
              //             );
              //           },
              //           child: Tile(
              //             label: 'During the Event\nInformation',
              //             height: height,
              //             icon: Icons.event,
              //           ),
              //         ),
              //       ],
              //
              //       /// After Tile
              //       if (showEPGridsModel.after ?? false) ...[
              //         InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //               context,
              //               eventInfoRoute,
              //               arguments: {
              //                 'title': Constants.afterEventInformation,
              //                 'id': id,
              //                 'eventDuration': 2,
              //                 ConstantsArgument.editForm:
              //                     showEPGridsModel.editAfter,
              //                 ConstantsArgument.isEventProtection:
              //                     isEventProtection,
              //               },
              //             );
              //           },
              //           child: Tile(
              //             label: 'After the Event\nInformation',
              //             height: height,
              //             icon: Icons.event_available,
              //           ),
              //         ),
              //       ],
              //     ],
              //   ),
              // ),
              // return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   ListView(
                     shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _rowCard(
                          iconData: Icons.error_outline,
                          label: "General Information",
                          onTap: () async {
                            NavigatorState nav = Navigator.of(context);
                            bool? showGuardInfo = false;
                            if (id.isNotEmpty) {
                              ShowGuardInfoResponse showGuardInfoResponse =
                                  await services.showGuardInfo(id);
                              showGuardInfo =
                                  showGuardInfoResponse.showGuardInfo;
                            }
                            nav.pushNamed(
                              title == Constants.annualPowerShutdownListDetails
                                  ? annualPowerShutdownListDetailsRoute
                                  : eventProtectionGeneralInfoGIRoute,
                              // change it
                              arguments: {
                                'id': id,
                                'showGuardInfo': showGuardInfo,
                              },
                            );
                          },
                        ),
                        if (showEPGridsModel.before ?? false) ...[
                          _rowCard(
                            iconData: Icons.event,
                            label: 'Before the Event Information',
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                eventInfoRoute,
                                arguments: {
                                  'title': Constants.beforeEventInformation,
                                  'id': id,
                                  'eventDuration': 0,
                                  ConstantsArgument.isEventProtection:
                                      isEventProtection,
                                  ConstantsArgument.editForm:
                                      showEPGridsModel.editBefore,
                                },
                              );
                            },
                          ),
                        ],
                        if (showEPGridsModel.during ?? false) ...[
                          _rowCard(
                            iconData: Icons.event,
                            label: Constants.duringEventInformation,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                eventInfoRoute,
                                arguments: {
                                  'title': Constants.duringEventInformation,
                                  'id': id,
                                  'eventDuration': 1,
                                  ConstantsArgument.editForm:
                                      showEPGridsModel.editDuring,
                                  ConstantsArgument.isEventProtection:
                                      isEventProtection,
                                },
                              );
                            },
                          )
                        ],
                        if (showEPGridsModel.after ?? false) ...[
                          _rowCard(
                            iconData: Icons.event,
                            label: Constants.afterEventInformation,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                eventInfoRoute,
                                arguments: {
                                  'title': Constants.afterEventInformation,
                                  'id': id,
                                  'eventDuration': 2,
                                  ConstantsArgument.editForm:
                                      showEPGridsModel.editAfter,
                                  ConstantsArgument.isEventProtection:
                                      isEventProtection,
                                },
                              );
                            },
                          ),
                        ],
                      ],
                    // ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

Widget _rowCard({
  String? icon,                // Asset icon
  IconData? iconData,          // Flutter Icon
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
      child: Row(
        children: [
            Icon(
              iconData,
              size: 35,
              color: Colors.white,
            ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              label,
              style: Styles.textStyleWhite16,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white),
        ],
      ),
    ),
  );
}

