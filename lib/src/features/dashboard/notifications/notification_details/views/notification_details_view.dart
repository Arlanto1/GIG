import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/dashboard/notifications/notification_details/cubits/notification_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/models/key_loss_destruction_list_model.dart';
import 'package:db_atom/src/features/guarding_operations/key_management_data/key_loss_destruction_list/services/key_loss_destruction_list_services.dart';
import 'package:db_atom/src/features/law_enforcement_new/models/law_enforcement_model_new.dart';
import 'package:db_atom/src/features/law_enforcement_new/services/law_enforcement_services_new.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../guarding_operations/sla_violation_penalty/services/sla_violation_penalty_services.dart';

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
        Utils().formError(state, context);
        Utils().errorAndLogout(state, context);

        if (state.status == FormStatus.success) {
          Navigator.pop(context);

          // var dialog = CustomAlertDialog(
          //   title: 'Material Movement',
          //   message: state.message ?? '',
          //   positiveBtnText: Constants.ok,
          //   onPostivePressed: () {
              /// TODO: Need to improve this code
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
          backgroundColor: Colors.transparent,
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
    // return Container(
    //   // color: AppColors.white,
    //   child:
    return Scaffold(                          //  Scaffold gives bounded constraints
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,                 //  forces Stack to fill all available space
          children: [
            // 🌄 Background Image
            Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    // 🔹 Blur Layer
    Positioned.fill(
    child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
    child: Container(
    color: Colors.black.withValues(alpha: 0.1), // optional tint
    ),
    ),
    ),
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const ShapeDecoration(
                color: Colors.transparent,
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
                        CommonWidgets.verticalSpacerWidget(height * 0.02),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            state.model.content?.subject ?? '',
                            style: Styles.styleHeaderWhiteText30,
                          ),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                        SingleChildScrollView(
                          child: HtmlWidget(
                            textStyle: Styles.textStyleWhite16,
                            // _sanitizeHtml(state.model.content?.text),
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
                            Styles.textStyleRegularNormalWhite14,
                          ),
                          BaseImageUpload().getAttachment(
                            height: height,
                            attachments: state.model.attachments,
                            files: state.model.attachments,
                            moduleCode: state.model.moduleCode ?? '',
                            showDeleteIcon: false,
                          ),
                        ],
                        if (!state.model.moduleCode.isEmptyOrNull &&
                            state.model.moduleId != null) ...[
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
    ],));
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
                    "isCreate": false,
                    "title": Constants.materialMovementOutwardCreate,
                  });
              break;
            }

          case 'SVP':
            {
              SLAViolationPenaltyModel model =
              await SLAViolationPenaltyServices().getGvpById(moduleId);

              nav.pushNamed(slaViolationPenaltyDetailsRoute,
                  arguments: {
                    "model": model,
                    "title": Constants.slaViolationPenaltyTitle,
                  });
              // nav.pushNamed(slaViolationPenaltyDetailsRoute, arguments: {
              //   ConstantsArgument.title: Constants.slaViolationPenaltyTitle,
              //   ConstantsArgument.attdInfoId: null,
              //   ConstantsArgument.locationRegion: null,
              //   "model": moduleId,
              // });
              break;
            }
          case 'LEO':
            {
              LawEnforcementModelNew? model =
                  await LawEnforcementServicesNew().getById(moduleId);

              // nav.pushNamed(lawEnforcementDetailsViewRoute, arguments: {
              //   "UserElement": model,
              // });

              nav.pushNamed(lawEnforcementNewDetailsViewRoute, arguments: {
                "model": model,
                "title": Constants.editlawenforcement,
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
      width: Constants.cancelButtonWidth,
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
