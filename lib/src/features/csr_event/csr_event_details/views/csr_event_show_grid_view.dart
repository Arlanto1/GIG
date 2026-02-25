import 'dart:ui';

import '../../../../../index.dart';
import '../../services/csr_event_services.dart';

class CsrEventShowGridView extends StatelessWidget {
  final int id;
  final String title;
  final int eventStatus;
  final bool isCSREvent;
  final ShowEPGridsModel showEPGridsModel;

  CsrEventShowGridView({
    super.key,
    required this.id,
    required this.title,
    required this.eventStatus,
    required this.showEPGridsModel,
    required this.isCSREvent,
  });

  final CSREventServices services = CSREventServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: title.isNotEmpty
            ? title
            : Constants.eventProtectionTitle,
        showPopUp: false,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
      ),
      body: Stack(
        children: [
          // 🔹 FULL SCREEN BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 GLASS BLUR OVERLAY
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
              ),
            ),
          ),

          // 🔹 CONTENT (FORCED TO FULL HEIGHT)
          LayoutBuilder(
            builder: (context, constraints) {
              return
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        18,
                        MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            -30,
                        18,
                        18,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          _rowCard(
                            iconData: Icons.error_outline,
                            label: "General Information",
                            onTap: () async {
                              NavigatorState nav =
                              Navigator.of(context);
                              bool? showGuardInfo = false;

                              final res =
                              await services.showGuardInfo(id);
                              showGuardInfo =
                                  res.showGuardInfo;

                              nav.pushNamed(
                                title ==
                                    Constants
                                        .annualPowerShutdownListDetails
                                    ? annualPowerShutdownListDetailsRoute
                                    : csrEventGeneralInfoRoute,
                                arguments: {
                                  'id': id,
                                  'showGuardInfo':
                                  showGuardInfo,
                                },
                              );
                            },
                          ),

                          if (showEPGridsModel.before ?? false)
                            _rowCard(
                              iconData: Icons.event,
                              label:
                              'Before the Event Information',
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  eventInfoRoute,
                                  arguments: {
                                    'title': Constants
                                        .beforeEventInformation,
                                    'id': id,
                                    'eventDuration': 0,
                                    ConstantsArgument
                                        .isCSREvent:
                                    isCSREvent,
                                    ConstantsArgument.editForm:
                                    showEPGridsModel
                                        .editBefore,
                                  },
                                );
                              },
                            ),

                          if (showEPGridsModel.during ?? false)
                            _rowCard(
                              iconData: Icons.event,
                              label: Constants
                                  .duringEventInformation,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  eventInfoRoute,
                                  arguments: {
                                    'title': Constants
                                        .duringEventInformation,
                                    'id': id,
                                    'eventDuration': 1,
                                    ConstantsArgument.editForm:
                                    showEPGridsModel
                                        .editDuring,
                                    ConstantsArgument
                                        .isCSREvent:
                                    isCSREvent,
                                  },
                                );
                              },
                            ),

                          if (showEPGridsModel.after ?? false)
                            _rowCard(
                              iconData: Icons.event,
                              label: Constants
                                  .afterEventInformation,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  eventInfoRoute,
                                  arguments: {
                                    'title': Constants
                                        .afterEventInformation,
                                    'id': id,
                                    'eventDuration': 2,
                                    ConstantsArgument.editForm:
                                    showEPGridsModel
                                        .editAfter,
                                    ConstantsArgument
                                        .isCSREvent:
                                    isCSREvent,
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}

/// 🔹 GLASS ROW CARD
Widget _rowCard({
  IconData? iconData,
  required String label,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(27),
    child: Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.09),
            Colors.transparent,
            Colors.white.withValues(alpha: 0.09),
          ],
          stops: const [0.02, 0.35, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(27),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.6),
          width: 0.7,
        ),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 35, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Styles.textStyleWhite16,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
