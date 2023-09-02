import 'dart:developer';

import 'package:db_atom/src/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/app_button.dart';
import '../../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../../common_widgets/base_widget/date_picker_dialog.dart';
import '../../../../../common_widgets/base_widget/radio_buttons_yes_no.dart';
import '../../../../../common_widgets/base_widget/selected_tile_value_widget.dart';
import '../../../../../common_widgets/basic_reusable_widgets.dart';
import '../../../../../common_widgets/custom_list_expansion_pop_up.dart';
import '../../../../../common_widgets/custom_simple_list_texts.dart';
import '../../../../../common_widgets/image_download.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../constants/constants.dart';
import '../../../../../models/entry_security.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/app_themes/colors/app_color.dart';
import '../../../../../utils/app_themes/styles/app_styles.dart';
import '../../../../../utils/customalert.dart';
import '../../../../../utils/helpers/keys/keys.dart';
import '../../../../../utils/util.dart';
import '../../../../../utils/validators/validator.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../../../../createfound/models/create_found_request.dart';
import '../../../../createfound/models/get_locations_model.dart';
import '../../../../createfound/models/get_user_model.dart';
import '../../../../createfound/views/upload_attachment.dart';
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
  TextEditingController dateOfBirth =
      TextEditingController();
  TextEditingController dateOfJoining =
  TextEditingController();
  TextEditingController pvcIssuedDate =
  TextEditingController();
  TextEditingController pvcExpiryDate =
  TextEditingController();
  TextEditingController medicalCertificateValidUntil =
  TextEditingController();
  TextEditingController dateOfFirstCovidDoseController =
  TextEditingController();
  TextEditingController dateOfSecondCovidDose =
  TextEditingController();
  TextEditingController dateOfPrecautionaryCovidDose =
  TextEditingController();
  TextEditingController ertCertificationDate =
  TextEditingController();
  TextEditingController firstAidTrainingCompletionDate  =
  TextEditingController();
  bool isDisabled = true;


  @override
  void initState() {
    super.initState();
    BlocProvider.of<GuardingMasterDataDetailsCubit>(context).initializeValues();
    initializeControllerValues();
  }
  void initializeControllerValues() {
    dateOfFirstCovidDoseController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidFirstDoseDate ?? '0'), Constants.dateFormat);
    // TODO: Add remaining Date Values here

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

  getBodybuilder(GuardingMasterDataDetailsState state, height) {
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

                            /// Date of creation
                            CommonWidgets.textDisplay(Constants.dateofcreation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            datecreateWidgetdisplay(
                                state.guardingMasterData.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Building  Location
                            CommonWidgets.textDisplay(
                                Constants.buildingLocation, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(Constants.slno,
                                state.guardingMasterData.slNo ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload Photo
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadPhoto, Styles.textStyleBlack14)
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

                            /// Received For
                         /*   if (!state.materialMovement.originalReceiver) ...[
                              Column(
                                children: [
                                  CommonWidgets.textDisplay(
                                    Constants.receivedFor,
                                    Styles.textStyleBlack14,
                                  ),
                                  widget.guardingMasterData == null
                                      ? TextfieldAddButton(
                                      title: state
                                          .materialMovement.receiverEmail,
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
                                                  :
                                                  user);
                                            },
                                          );
                                        }
                                      })
                                      : FlutterInputField(
                                    initialValue: state.materialMovement
                                        .otherReceiverName,
                                    textFormKey:
                                    Keys.depositorTextController,
                                    hintText: '',
                                    isEnable:
                                    state.materialMovement.status !=
                                        6,
                                    isDisableColor:
                                    state.materialMovement.status ==
                                        6,
                                    onChange: (String username) {},
                                    validateTextField:
                                        (String? user) {},
                                  ),
                                  CommonWidgets.verticalSpacerWidget(
                                      height * 0.01),
                                ],
                              ),
                            ],*/

                            /// Guarding POC
                            CommonWidgets.textDisplay(
                                Constants.guardingPoc, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.guardingPoc,
                              textFormKey: Keys.guardingPOCKey,
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
                                  state.guardingMasterData.employeeCode,
                              textFormKey: Keys.guardingAgencyKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.employeeCode ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: (widget.guardingMasterData !=
                                          null &&
                                      (widget.guardingMasterData?.employeeCode !=
                                          null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.employeeCode = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),

                            /// Guard Rank
                            CommonWidgets.textDisplay(
                                Constants.rank,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.rankKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// DB Employee ID
                        CommonWidgets.textDisplay(
                            Constants.dbEmployeeId,
                            Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        FlutterInputField(
                          keyboardType: TextInputType.number,
                          initialValue:
                          state.guardingMasterData.guardingPoc,
                          textFormKey: Keys.dbEmployeeIDKey,
                          hintText: '',
                          isEnable: widget.guardingMasterData == null
                              ? true
                              : (widget.guardingMasterData != null &&
                              (widget.guardingMasterData
                                  ?.dbEmployeeId ==
                                  null))
                              ? false
                              : true,
                          isDisableColor: (widget.guardingMasterData !=
                              null &&
                              (widget.guardingMasterData?.dbEmployeeId !=
                                  null))
                              ? true
                              : false,
                          onChange: (String value) {
                            state.guardingMasterData.dbEmployeeId = value;
                            context
                                .read<GuardingMasterDataDetailsCubit>()
                                .onModelValueChange(
                                state.guardingMasterData);
                          },
                          validateTextField: (String? user) {},
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.04),

                            /// Type Of Duty
                            CommonWidgets.textDisplay(
                                Constants.typeOfDuty,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.typeOfDutyKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Gender
                            CommonWidgets.textDisplay(
                                Constants.gender,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.genderKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Marital Status
                            CommonWidgets.textDisplay(
                                Constants.maritalStatus,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.maritalStatusKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Contact Num
                            CommonWidgets.textDisplay(
                                Constants.mobileNum,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                              state.guardingMasterData.contactNo,
                              textFormKey: Keys.contactNoKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                  (widget.guardingMasterData
                                      ?.contactNo ==
                                      null))
                                  ? false
                                  : true,
                              isDisableColor: (widget.guardingMasterData !=
                                  null &&
                                  (widget.guardingMasterData?.contactNo !=
                                      null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.contactNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),

                            /// Date of Birth
                            CommonWidgets.textDisplay(
                              Constants.dateOfBirth,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfBirth,
                              onChange: (String value) {
                                log('--fr-value-${dateOfBirth.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),


                            /// Date of Joining
                            CommonWidgets.textDisplay(
                              Constants.dateOfJoining,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfJoining,
                              onChange: (String value) {
                                log('--fr-value-${dateOfJoining.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            /// Type of Deployment
                            CommonWidgets.textDisplay(
                                Constants.typeOfDeployment,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.deploymentTypeKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Deployment order Submitted?
                            CommonWidgets.textDisplay(
                                Constants.deploymentOrderSubmitted,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue: state.guardingMasterData
                                    .deploymentOrderSubmitted!
                                    ? 1
                                    : 0,
                                onChangedYes:
                                widget.guardingMasterData?.status == 6
                                    ? null
                                    : (val) {
                                  state.guardingMasterData.deploymentOrderSubmitted = true;
                                  BlocProvider.of<
                                      GuardingMasterDataDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.guardingMasterData
                                  );
                                },
                                onChangedNo:
                                widget.guardingMasterData?.status == 4
                                    ? null
                                    : (val) {
                                  state.guardingMasterData.deploymentOrderSubmitted = false;
                                  BlocProvider.of<
                                      GuardingMasterDataDetailsCubit>(
                                      context)
                                      .onModelValueChange(state.guardingMasterData
                                  );
                                }),

                            /// Security Experience
                            CommonWidgets.textDisplay(
                                Constants.securityExperience,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue:
                              state.guardingMasterData.securityExperience,
                              textFormKey: Keys.securityExperienceKey,
                              hintText: Constants.informationhere,
                              isEnable: state.guardingMasterData.status != 4,
                              isDisableColor:
                              state.guardingMasterData.status == 4,
                              onChange: (String value) {
                                state.guardingMasterData.securityExperience =
                                    value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                Constants.uploadfile, Styles.textStyleBlack14)
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

                            /// permanent Address
                            CommonWidgets.textDisplay(
                                Constants.permanentAddress,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue:
                              state.guardingMasterData.permanentAddress,
                              textFormKey: Keys.permanentAddressKey,
                              hintText: Constants.informationhere,
                              isEnable: state.guardingMasterData.status != 4,
                              isDisableColor:
                              state.guardingMasterData.status == 4,
                              onChange: (String value) {
                                state.guardingMasterData.permanentAddress =
                                    value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                Constants.uploadfile, Styles.textStyleBlack14)
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


                            /// Local Address
                            CommonWidgets.textDisplay(
                                Constants.localAddress,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue:
                              state.guardingMasterData.localAddress,
                              textFormKey: Keys.localAddressKey,
                              hintText: Constants.informationhere,
                              isEnable: state.guardingMasterData.status != 4,
                              isDisableColor:
                              state.guardingMasterData.status == 4,
                              onChange: (String value) {
                                state.guardingMasterData.localAddress =
                                    value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                Constants.uploadfile, Styles.textStyleBlack14)
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

                            /// PVC Issued Date
                            CommonWidgets.textDisplay(
                              Constants.pvcIssuedDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcIssuedDate,
                              onChange: (String value) {
                                log('--fr-value-${pvcIssuedDate.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// PVC Expiry Date
                            CommonWidgets.textDisplay(
                              Constants.pvcExpiryDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcExpiryDate,
                              onChange: (String value) {
                                log('--fr-value-${pvcIssuedDate.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                Constants.uploadfile, Styles.textStyleBlack14)
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

                            /// Training Certificate?
                          /*  CommonWidgets.textDisplay(
                                Constants.trainingCertificate,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue: state.guardingMasterData
                                    .trainingCertificateProvided
                                    ? 1
                                    : 0,
                                onChangedYes:
                                widget.guardingMasterData?.status == 6
                                    ? null
                                    : (val) {
                                  BlocProvider.of<
                                      GuardingMasterDataDetailsCubit>(
                                      context)
                                      .showFields(

                                  );
                                },
                                onChangedNo:
                                widget.guardingMasterData?.status == 4
                                    ? null
                                    : (val) {
                                  BlocProvider.of<
                                      GuardingMasterDataDetailsCubit>(
                                      context)
                                      .showFields(
                                  );
                                }),*/

                            /// Medical Certificate Valid Until
                            CommonWidgets.textDisplay(
                              Constants.medicalCertificateValidUntil,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: medicalCertificateValidUntil,
                              onChange: (String value) {
                                log('--fr-value-${medicalCertificateValidUntil.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                Constants.uploadfile, Styles.textStyleBlack14)
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

                            /// System Access
                            CommonWidgets.textDisplay(
                                Constants.systemAccess,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            GestureDetector(
                              onTap: () {
                                if (state.guardingMasterData.status != 4) {
                                  assetTypeDialog(state);
                                }
                              },
                              child: FlutterInputField(
                                textFieldController: returnableTextController,
                                textFormKey: Keys.systemAccessKey,
                                hintText: '',
                                isEnable: false,
                                isDisableColor:
                                state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  log('val----$value');
                                },
                                validateTextField: (String? user) {},
                                suffixWidget: IconButton(
                                    icon: SvgPicture.asset(
                                        width: 10,
                                        height: 10,
                                        AppIcon.dropdownicon,
                                        key: const Key('closed_eye')),
                                    onPressed: () {}),
                              ),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ESIC No
                            CommonWidgets.textDisplay(
                                Constants.esicNo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                              state.guardingMasterData.esicNo,
                              textFormKey: Keys.esicKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                  (widget.guardingMasterData
                                      ?.esicNo ==
                                      null))
                                  ? false
                                  : true,
                              isDisableColor: (widget.guardingMasterData !=
                                  null &&
                                  (widget.guardingMasterData?.esicNo !=
                                      null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.esicNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),

                            /// UAN  No
                            CommonWidgets.textDisplay(
                                Constants.uanNo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                              state.guardingMasterData.uanNo,
                              textFormKey: Keys.uanNoKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                  (widget.guardingMasterData
                                      ?.uanNo ==
                                      null))
                                  ? false
                                  : true,
                              isDisableColor: (widget.guardingMasterData !=
                                  null &&
                                  (widget.guardingMasterData?.uanNo !=
                                      null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.uanNo = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),

                            /// Date of First Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfFirstCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfFirstCovidDoseController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfFirstCovidDoseController.text}------');
                               // widget.guardingMasterData?.covidFirstDoseDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Second Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfSecondCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfSecondCovidDose,
                              onChange: (String value) {
                                log('--fr-value-${dateOfSecondCovidDose.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Precautionary Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfPrecautionaryCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfPrecautionaryCovidDose,
                              onChange: (String value) {
                                log('--fr-value-${dateOfPrecautionaryCovidDose.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ERT Certification Date
                            CommonWidgets.textDisplay(
                              Constants.ertCertificationDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: ertCertificationDate,
                              onChange: (String value) {
                                log('--fr-value-${ertCertificationDate.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// First Aid Training Completion Date
                            CommonWidgets.textDisplay(
                              Constants.firstAidTrainingCompletionDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            BaseDate().datePickerWidgetLoading(
                              textController: firstAidTrainingCompletionDate,
                              onChange: (String value) {
                                log('--fr-value-${firstAidTrainingCompletionDate.text}------');
                               // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                                    .onModelValueChange(state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Additional Initiatives Info
                            CommonWidgets.textDisplay(
                                Constants.additionalInitiativesInfo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(
                                height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue:
                              state.guardingMasterData.additionalInitiatives,
                              textFormKey: Keys.additionInitiativesKey,
                              hintText: Constants.informationhere,
                              isEnable: state.guardingMasterData.status != 4,
                              isDisableColor:
                              state.guardingMasterData.status == 4,
                              onChange: (String value) {
                                state.guardingMasterData.additionalInitiatives =
                                    value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                    state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                    showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return UploadAttachment(
                               userdetails:
                              state.loggedInUserDetails ?? EntrySecurity(),
                              getFiles: getFiles ?? [],
                             dataState: state,
                              onImageSelected: (CreateImage data) {
                               log('-------function---onImageSelected---------');
                               List<CreateImage>? files = [];
                              files.add(data);
                               for (CreateImage image in getFiles!.toList()) {
                                 files.add(image);
                               }
                               BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                  context)
                                  .addAttchment(files);
                               },
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

                  Location location = Location()  ;
                  location.id = list?.id;
                  location.name = list?.name;
                  state.guardingMasterData.location = location;

                  BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                      .updateDropdownValues(location: location);
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
  assetTypeDialog(GuardingMasterDataDetailsState state) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomSimpleListTexts(
            texts: const ["Male","Female","Transgender"],
            onTap: (String value) {
             // bool isReturnable = value == 'Returnable' ? true : false;
              //state.materialMovement.returnable = isReturnable;
             BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                 .updateDropdownValues();
            });
      },
    );
  }

}
