import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/event_protection/services/event_protection_services.dart';

class EventProtectionDetails extends StatelessWidget {
  final String id;
  final int eventStatus;
  final ShowEPGridsModel showEPGridsModel;

  EventProtectionDetails({
    super.key,
    required this.id,
    required this.eventStatus,
    required this.showEPGridsModel,
  });

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
                if (showEPGridsModel.before ?? false) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.beforeEventInformation,
                          'id': id,
                          'eventDuration': 0,
                          ConstantsArgument.editForm: showEPGridsModel.editBefore,
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
                if (showEPGridsModel.during ?? false) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.duringEventInformation,
                          'id': id,
                          'eventDuration': 1,
                          ConstantsArgument.editForm: showEPGridsModel.editDuring,
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
                if (showEPGridsModel.after ?? false) ...[
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        eventInfoRoute,
                        arguments: {
                          'title': Constants.afterEventInformation,
                          'id': id,
                          'eventDuration': 2,
                          ConstantsArgument.editForm: showEPGridsModel.editAfter,
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
