import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../common_widgets/base_widget/base_tile.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/router.dart';
import '../../../../utils/app_themes/colors/app_color.dart';
import '../general_information/guard_info/models/show_guard_info_response.dart';

class EventProtectionDetails extends StatelessWidget {
  final String id;
  final int eventStatus;

  EventProtectionDetails(
      {super.key, required this.id, required this.eventStatus});

  final EventProtectionServices services = EventProtectionServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final height = size.height;
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.eventProtectionTitle,
        showPopUp: true,
        showSaveButton: false,
        showSubmitButton: false,
        showDisLikeButton: false,
        showLikeButton: false,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                InkWell(
                  onTap: () async {
                    NavigatorState nav = Navigator.of(context);
                    bool? showGuardInfo = false;
                    if (id.isNotEmpty) {
                      ShowGuardInfoResponse showGuardInfoResponse =
                          await services.showGuardInfo(id);
                      showGuardInfo = showGuardInfoResponse.showGuardInfo;
                    }
                    nav.pushNamed(
                      generalInfoGIRoute, // change it
                      arguments: {
                        'id': id,
                        'showGuardInfo': showGuardInfo,
                      },
                    );
                  },
                  child: Tile(
                    label: 'General\nInformation',
                    height: height,
                  ),
                ),
                if (eventStatus >= 20) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.beforeEventInformation,
                          'id': id,
                          'eventDuration': 0,
                        },
                      );
                    },
                    child: Tile(
                      label: 'Before the Event\nInformation',
                      height: height,
                      icon: Icons.event,
                    ),
                  ),
                ],
                if (eventStatus >= 21) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.duringEventInformation,
                          'id': id,
                          'eventDuration': 1,
                        },
                      );
                    },
                    child: Tile(
                      label: 'During the Event\nInformation',
                      height: height,
                      icon: Icons.event,
                    ),
                  ),
                ],
                if (eventStatus >= 22) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.afterEventInformation,
                          'id': id,
                          'eventDuration': 2,
                        },
                      );
                    },
                    child: Tile(
                      label: 'After the Event\nInformation',
                      height: height,
                      icon: Icons.event_available,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
