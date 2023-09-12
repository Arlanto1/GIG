import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';
import 'package:flutter/material.dart';

import '../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../common_widgets/base_widget/base_tile.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/router.dart';
import '../../../../utils/app_themes/colors/app_color.dart';

class EventProtectionDetails extends StatelessWidget {
  final int id;

  EventProtectionDetails({super.key, required this.id});

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
                    bool showGuardInfo = await services.showGuardInfo(id);
                    nav.pushNamed(
                      generalInfoTilesViewRoute,
                      arguments: {'id': id, 'showGuardInfo': showGuardInfo},
                    );
                  },
                  child: Tile(
                    label: 'General\nInformation',
                    height: height,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, eventInfoRoute,
                        arguments: {'title': Constants.beforeEventInformation});
                  },
                  child: Tile(
                    label: 'Before the Event\nInformation',
                    height: height,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, eventInfoRoute,
                        arguments: {'title': Constants.duringEventInformation});
                  },
                  child: Tile(
                    label: 'During the Event\nInformation',
                    height: height,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, eventInfoRoute,
                        arguments: {'title': Constants.afterEventInformation});
                  },
                  child: Tile(
                    label: 'After the Event\nInformation',
                    height: height,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
