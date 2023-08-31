import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/app_button.dart';
import '../../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../../common_widgets/base_widget/selected_tile_value_widget.dart';
import '../../../../../common_widgets/basic_reusable_widgets.dart';
import '../../../../../common_widgets/custom_list_expansion_pop_up.dart';
import '../../../../../common_widgets/image_download.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../constants/constants.dart';
import '../../../../../models/location.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/app_themes/colors/app_color.dart';
import '../../../../../utils/app_themes/styles/app_styles.dart';
import '../../../../../utils/customalert.dart';
import '../../../../../utils/helpers/keys/keys.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_locations_model.dart';
import '../../../../createfound/models/get_user_model.dart';
import '../../../../createfound/views/upload_attachment.dart';
import '../../../../material_movement/models/material_movements_model.dart';
import '../../models/guarding_master_data_model.dart';
import '../cubits/guarding_master_data_details_cubit.dart';

class GuardigMasterDataDetails extends StatefulWidget {
  final GuardingMastersDataModel? guardingMasterData;
  final String title;

  const GuardigMasterDataDetails({
    super.key,
    this.guardingMasterData,
    required this.title,
  });

  @override
  State<GuardigMasterDataDetails> createState() =>
      _GuardigMasterDataDetailsState();
}

class _GuardigMasterDataDetailsState extends State<GuardigMasterDataDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController returnableTextController = TextEditingController();
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();
  bool isDisabled = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardingMasterDataDetailsCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<GuardingMasterDataDetailsCubit,
        GuardingMasterDataDetailsState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Guarding Master Data',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, guardingMasterDataRoute,
                  arguments: {});
            },
          );
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => dialog);

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
            title: widget.title,
            showPopUp: false,
            showSaveButton: state.guardingMasterData.status != 4 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      log('---getAttachments----builder----${getAttachments?.length}-----');
      getFiles = state.loadAttachments ?? [];
      log('---getFiles----builder----${getFiles?.length}-----');
    }

    return Container(
        color: AppColors.navigationSkybluecolor,
        child: SingleChildScrollView(
            child: Column(children: [
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
                  )),
              child: Form(
                  key: _formKey,
                  autovalidateMode: state.guardingMasterData.status == 4
                      ? AutovalidateMode.disabled
                      : AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                Constants.generalinformation,
                                style: Styles.styleHeaderGreyText16,
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Status
                            CommonWidgets.textDisplay(
                                Constants.status, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              isEnable: false,
                              isDisableColor: true,
                              textFormKey: Keys.statusTextController,
                              hintText: '',
                              initialValue: getStatusString(
                                  state.guardingMasterData.status ?? 0),
                              onChange: (String value) {},
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Created By
                            CommonWidgets.verticalTextHandling(
                                Constants.createdby,
                                state.loggedInUserDetails?.name ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Location
                            CommonWidgets.textDisplay(
                                Constants.location, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of creation
                            CommonWidgets.textDisplay(Constants.dateofcreation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.guardingMasterData.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            /*  if (!state.guardingMasterData.name) ...[
                                  Column(
                                    children: [
                                      CommonWidgets.textDisplay(
                                        Constants.entity,
                                        Styles.textStyleBlack14,
                                      ),
                                      widget.guardingMasterData == null
                                          ? TextfieldAddButton(
                                          title: state
                                              .guardingMasterData.entity,
                                          height: 70,
                                          isDisableColor:
                                          widget.guardingMasterData == null
                                              ? false
                                              : true,
                                          onTap: () {
                                            if (widget.guardingMasterData ==
                                                null) {
                                              BaseDialog().userDialog(
                                                context: context,
                                                users: state.emailUsers!,
                                                onTap: (BaseUser user) {
                                                  BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                      context)
                                                      .updateDropdownValues(
                                                      name:
                                                      user);
                                                },
                                              );
                                            }
                                          })
                                          : FlutterInputField(
                                        initialValue: state.guardingMasterData
                                            .otherEntity,
                                        textFormKey:
                                        Keys.depositorTextController,
                                        hintText: '',
                                        isEnable:
                                        state.guardingMasterData.status !=
                                            4,
                                        isDisableColor:
                                        state.guardingMasterData.status ==
                                            4,
                                        onChange: (String username) {},
                                        validateTextField:
                                            (String? user) {},
                                      ),
                                      CommonWidgets.verticalSpacerWidget(
                                          height * 0.01),
                                    ],
                                  ),
                                ],*/

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(Constants.slno,
                                state.guardingMasterData.slNo ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.upload, Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? uploadWidget(state)
                                : Container(),

                            // Attachments
                            getSpaceattchment(height),
                            getAttachement(state, height),

                            /// Guarding POC
                            CommonWidgets.textDisplay(
                                Constants.guardingPoc, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.guardingPoc,
                              textFormKey: Keys.poNumberKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.guardingPoc ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: (widget.guardingMasterData !=
                                          null &&
                                      (widget.guardingMasterData?.guardingPoc !=
                                          null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.guardingPoc = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),



                            /// Guarding Agency Employee Code
                            CommonWidgets.textDisplay(
                                Constants.guardingAgencyEmpCode,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.guardingPoc,
                              textFormKey: Keys.poNumberKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.guardingPoc ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: (widget.guardingMasterData !=
                                          null &&
                                      (widget.guardingMasterData?.guardingPoc !=
                                          null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.guardingPoc = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),
                          ]),
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// SubmitButton
                        if (state.guardingMasterData.status != 4) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cancelButtonDisplay(),
                              submitButtonDisplay()
                            ],
                          ),
                        ],
                        CommonWidgets.verticalSpacerWidget(height * 0.04),
                      ])))
        ])));
  }

  String getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Active';
      case 2:
        return 'InActive';
      case 3:
        return 'Leave';
      case 4:
        return 'Week Off ';
      default:
        return 'Unknown Status';
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

  Widget submitButtonDisplay() {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.submit,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<GuardingMasterDataDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget uploadWidget(GuardingMasterDataDetailsState state) {
    return widget.guardingMasterData == null
        ? Container(
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFCACACA),
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
                  onPressed: () {
                    // Navigator.pushNamed(context,
                    //     createFoundAttachmentRoute);
                    //UploadAttachment();
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                              // userdetails:
                              //state.loggedInUserDetails ?? EntrySecurity(),
                              //getFiles: getFiles ?? [],
                              //onImageSelected: (CreateImage data) {
                              // log('-------function---onImageSelected---------');
                              // List<CreateImage>? files = [];
                              //files.add(data);
                              // for (CreateImage image in getFiles!.toList()) {
                              //   files.add(image);
                              // }
                              // BlocProvider.of<GuardingMasterDataDetailsCubit>(
                              //    context)
                              //    .addAttchment(files);
                              // },
                              );
                        });
                  },

                  icon: SvgPicture.asset(
                    //AppIcon.dropdownicon,
                    AppIcon.uploadicon,
                    //fit: BoxFit.,
                    color: AppColors.backgroundWhitecolor,
                    width: 13,
                    height: 13,
                    key: const Key(Keys.userIcon),
                  ),
                  // const Icon(
                  //   // <-- Icon
                  //   Icons.upload,
                  //   color: AppColors.backgroundWhitecolor,
                  //   size: 24.0,
                  // ),
                  label: const Text(
                    Constants.clicktoupload,
                    style: Styles.textStyleRegularNormalWhite12,
                  ), // <-- Text
                ),
              ),
            ]),
          )
        : Container();
  }

  Widget getSpaceattchment(double height) {
    return getAttachments != null ||
            getFiles != null ||
            getFiles?.length != 0 ||
            getAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget getAttachement(GuardingMasterDataDetailsState state, double height) {
    return (state.loadAttachments == null ||
            state.loadAttachments!.isEmpty ||
            widget.guardingMasterData == null)
        ? state.loadAttachments?.length == 0 || getFiles == null
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  Widget locationWidgetdislay(GuardingMasterDataDetailsState state) {
    return GestureDetector(
      onTap: () {
        if (widget.guardingMasterData == null ||
            (state.guardingMasterData.location?.name ?? '').isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                getLocationsresponse: state.locations,
                onTap: (Mumbai? list) async {
                  log('list?.name-----${list?.name}');

                  Location location = Location();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.guardingMasterData.location = location;
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(
          name: state.guardingMasterData.location?.name ?? ''),
    );
  }

  Widget datecreateWidgetdisplay(String date) {
    return FlutterInputField(
      textFormKey: Keys.dateofcreationTextController,
      initialValue: date,
      hintText: '',
      isEnable: false,
      isDisableColor: true,
      onChange: (String value) {},
      validateTextField: (String? user) {},
    );
  }

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    log('----attachmentListviews-----${attachmentListviews?.length}-----------');
    log('----attachmentListviews1-----${attachmentListviews1?.length}-----------');

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              attachmentListviews1?.length ?? attachmentListviews?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            CreateImage? imagedata;
            FoundImage? imagedata1;
            if (widget.guardingMasterData != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.guardingMasterData != null
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage().saveImage(
                        context, imagedata1?.id ?? 0, imagedata1?.title ?? '');
                  },
                  title: widget.guardingMasterData != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //
              ],
            );
          }),
    );
  }
}
