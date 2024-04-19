import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/cubits/notification_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../guarding_operations/key_management_data/key_management_master/services/key_management_master_services.dart';

class NotificationDetailsView extends StatefulWidget {
  const NotificationDetailsView({
    super.key,
  });

  @override
  State<NotificationDetailsView> createState() =>
      _NotificationDetailsViewState();
}

class _NotificationDetailsViewState extends State<NotificationDetailsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationDetailsCubit>(context).initializeValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    return BlocConsumer<NotificationDetailsCubit, NotificationDetailsState>(
      listener: (context, state) {
        log('--NN-state.status-${state.status}-------');
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          Navigator.pop(context);

          // var dialog = CustomAlertDialog(
          //   title: 'Material Movement',
          //   message: state.message ?? '',
          //   positiveBtnText: Constants.ok,
          //   onPostivePressed: () {
          //     // TODO: Need to improve this code
          //     Navigator.pop(context);
          //   },
          // );
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) => dialog);

          // Utils.dynamicAlert(
          //     context, state.message ?? '', 'Material Movement', '');
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: BaseAppBar().buildAppHeader(
            context: context,
            title: Constants.notifications,
            showPopUp: false,
            showSaveButton: false,
            showSubmitButton: false,
            onTapSave: () {},
            showCustomIcon: true,
            showDisLikeButton: false,
            showLikeButton: false,
            customIcon: Icons.delete,
            onTapCustomIcon: () => deleteNotification(state.model.id!),
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  void deleteNotification(int id) {
    BlocProvider.of<NotificationDetailsCubit>(context).deleteNotification(id);
  }

  getBodybuilder(NotificationDetailsState state, height) {
    if (state.status == FormStatus.loading) {
      return const BaseLoader();
    }
    return Container(
      color: AppColors.navigationSkybluecolor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.01,
              color: AppColors.navigationSkybluecolor,
            ),
            Container(
              decoration: const ShapeDecoration(
                color: AppColors.backgroundWhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '${state.model.content?.subject}',
                            style: Styles.styleHeaderGreyText30,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        SingleChildScrollView(
                          child: HtmlWidget(
                            state.model.content?.text ?? '',
                            // '<h1>Hello, <i>World</i>!</h1><p>Click <a href="http://www.google.com/">here</a> to visit Example website.</p>',
                            onTapUrl: (url) {
                              log('tapped-- $url'); // getting url value = #
                              launchURL(Uri.encodeFull(url));
                              return true;
                            },
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        if (!state.model.attachments.isEmptyOrNull) ...[
                          /// Attachments
                          CommonWidgets.textDisplay(
                            Constants.attachments,
                            Styles.textStyleBlack14,
                          ),
                          BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.model.attachments,
                              files: state.model.attachments,
                              showDownloadIcon: true,
                              moduleCode: state.model.moduleCode ?? ''),
                        ],
                        if (!state.model.moduleCode.isEmptyOrNull) ...[
                          submitButtonDisplay(state)
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    Uri parsedUrl = Uri.parse(url);
    log('Parsed URL: $parsedUrl');

    if (await canLaunchUrl(parsedUrl)) {
      log('----canLaunchUrl--');
      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
    } else {
      log('-else---canLaunchUrl--');
      throw 'Could not launch URL: $url';
    }
  }

  Widget submitButtonDisplay(NotificationDetailsState state) {
    log('---${state.model.moduleCode}---');

    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.showDetails,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        log('--state.model.moduleId--${state.model.moduleId}--');

        if (state.model.moduleId == null) {
          Validator().showToast(
            context,
            'Module Id is null.',
          );
          return;
        }
        int moduleId = state.model.moduleId ?? 0;

        var nav = Navigator.of(context);

        switch (state.model.moduleCode) {
          case 'MM':
            {
              MaterialMovementModel materialMovementModel =
                  await MaterialMovementServices().getById(moduleId);
              nav.pushNamed(materialMovementInwardOutwardDetailsRoute,
                  arguments: {
                    "MaterialMovementModel": materialMovementModel,
                    "isInward": false,
                    "isCreate": true,
                    "title": Constants.materialMovementOutwardCreate,
                  });
              break;
            }
          case 'LEO':
            {
              LawEnforcementDetailsModel? model =
                  await lawEnforcementListCubit.getById(moduleId, context);

              nav.pushNamed(lawEnforcementDetailsViewRoute, arguments: {
                "UserElement": model,
              });
              break;
            }
          case 'IM':
            {
              nav.pushNamed(
                incidentManagementDetailsRoute,
                arguments: {
                  'id': moduleId.toString(),
                },
              );
              break;
            }
          case 'SSSLA':
            {
              nav.pushNamed(
                sstIncidentDetailsRoute,
                arguments: {
                  'id': moduleId,
                  'isInternal': false,
                  "title": Constants.ticketLifeCycle,
                },
              );
              break;
            }
          case 'KLD':
            {
              KeyLossDestructionListModel keyLossDestructionListModel =
                  await KeyLossDestructionListServices().getById(moduleId);
              nav.pushNamed(
                keyLossDestructionListDetailsRoute,
                arguments: {
                  "keyLossGi": keyLossDestructionListModel,
                  "title": Constants.editKeyLossDestruction
                },
              );
              break;
            }
        }
      },
    );
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Active';
      default:
        return '';
    }
  }

  Widget cancelButtonDisplay() {
    return AppButton(
      // Customize the button properties as needed
      width: 150,
      backgroundColor: Colors.white,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButton,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
