import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/cubits/notification_details_cubit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

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
        if (state.status == FormStatus.error) {
          Validator().showToast(
            context,
            state.message ?? 'Invalid Information',
          );
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
                            onTapUrl: (url) {

                              print('tapped-- $url'); // getting url value = #
                              launchURL(Uri.encodeFull(url ?? ''));
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
                          ),
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

  String urlss =
      'https://www.google.com/search?q=backend+fcm+notification&sca_esv=590025935&sxsrf=AM9HkKkKOk3k5RhFBbIjS1FejyRL4UhpHA%3A1702353527652&ei=d9p3ZcepJ5KNnesP1ZC8uAI&ved=0ahUKEwiHwbCKgYmDAxWSRmcHHVUIDycQ4dUDCBA&uact=5&oq=backend+fcm+notification&gs_lp=Egxnd3Mtd2l6LXNlcnAiGGJhY2tlbmQgZmNtIG5vdGlmaWNhdGlvbjIIECEYoAEYwwRIrzJQiARYyCZwBXgBkAEAmAHMAaABvQuqAQUwLjkuMbgBA8gBAPgBAcICChAAGEcY1gQYsAPCAg0QABiABBiKBRhDGLADwgIIEAAYCBgHGB7CAgsQABiABBiKBRiGA8ICChAhGKABGMMEGAriAwQYACBBiAYBkAYK&sclient=gws-wiz-serp';

  void launchURL(String url) async {
    log('----launchURL--');
    if (await canLaunchUrl(Uri.parse(url))) {
      log('----canLaunchUrl--');
      await launchUrl(Uri.parse(url));
    } else {
      log('-else---canLaunchUrl--');
      throw 'Could not launch $url';
    }
  }

  Widget submitButtonDisplay(NotificationDetailsState state) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.showDetails,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        int moduleId = state.model.moduleId ?? 0;

        var nav = Navigator.of(context);

        switch (state.model.moduleCode) {
          case 'MM':
            {
              MaterialMovementModel materialMovementModel =
                  await MaterialMovementServices().getById(moduleId);
              nav.pushNamed(materialMovementInwardDetailsRoute, arguments: {
                "MaterialMovementModel": materialMovementModel,
                "isInward": false,
                "isCreate": true,
                "title": Constants.materialMovementOutwardCreate,
              });
              break;
            }
          case 'LEO':
            {
              LawEnforcementDetails? model =
                  await lawEnforcementListCubit.getById(moduleId, context);

              nav.pushNamed(lawenforcementScreenRoute, arguments: {
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
