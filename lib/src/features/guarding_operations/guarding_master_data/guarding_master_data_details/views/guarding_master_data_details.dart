import 'dart:developer';

import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/app_button.dart';
import '../../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/base_widget/base_drop_down.dart';
import '../../../../../common_widgets/base_widget/base_image_upload.dart';
import '../../../../../common_widgets/base_widget/check_box.dart';
import '../../../../../common_widgets/base_widget/date_picker_dialog.dart';
import '../../../../../common_widgets/base_widget/multiple_selection_pop_up.dart';
import '../../../../../common_widgets/base_widget/radio_buttons_yes_no.dart';
import '../../../../../common_widgets/base_widget/selected_tile_value_widget.dart';
import '../../../../../common_widgets/basic_reusable_widgets.dart';
import '../../../../../common_widgets/create_fields.dart';
import '../../../../../common_widgets/custom_list_expansion_pop_up.dart';
import '../../../../../common_widgets/image_download.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../common_widgets/textfiled_addbutton.dart';
import '../../../../../constants/app_icon.dart';
import '../../../../../constants/constants.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
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
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<CreateImage>? guardImages;
  List<CreateImage>? deploymentFiles;
  List<CreateImage>? bioDataFiles;
  List<CreateImage>? permanentAddressFiles;
  List<CreateImage>? localAddressFiles;
  List<CreateImage>? pVCFiles;
  List<CreateImage>? trainingFiles;
  List<CreateImage>? medicalFiles;
  List<FoundImage>? getAttachments;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();
  TextEditingController participationDateController = TextEditingController();
  TextEditingController pvcIssuedDateController = TextEditingController();
  TextEditingController pvcExpiryDateController = TextEditingController();
  TextEditingController medicalCertificateValidUntilController =
      TextEditingController();
  TextEditingController dateOfFirstCovidDoseController =
      TextEditingController();
  TextEditingController dateOfSecondCovidDoseController =
      TextEditingController();
  TextEditingController dateOfPrecautionaryCovidDose = TextEditingController();
  TextEditingController ertCertificationDate = TextEditingController();
  TextEditingController firstAidTrainingCompletionDate =
      TextEditingController();

  TextEditingController rankController = TextEditingController();
  TextEditingController dutyTypeController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController deploymentTypeController = TextEditingController();
  TextEditingController systemAccessController = TextEditingController();
  TextEditingController statusController = TextEditingController();
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
        initializeDates();
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

  void initializeDates() {
    dateOfBirthController.text = Utils.timestamptoDateConversion(
        int.tryParse(widget.guardingMasterData?.dateOfBirth ?? '0'),
        Constants.dateFormat);

    dateOfJoiningController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.dateOfJoining ?? '0'),
        Constants.dateFormat);

    pvcIssuedDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.pvcIssuedDate ?? '0'),
        Constants.dateFormat);
    pvcExpiryDateController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.pvcExpiryDate ?? '0'),
        Constants.dateFormat);

    medicalCertificateValidUntilController.text =
        Utils.timestamptoDateConversion(
            int.parse(
                widget.guardingMasterData?.medicalCertificateValidUntil ?? '0'),
            Constants.dateFormat);

    dateOfFirstCovidDoseController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidFirstDoseDate ?? '0'),
        Constants.dateFormat);

    dateOfSecondCovidDoseController.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidSecondDoseDate ?? '0'),
        Constants.dateFormat);

    dateOfPrecautionaryCovidDose.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.covidPrecautionaryDoseDate ?? '0'),
        Constants.dateFormat);

    ertCertificationDate.text = Utils.timestamptoDateConversion(
        int.parse(widget.guardingMasterData?.ertCertificationDate ?? '0'),
        Constants.dateFormat);
    firstAidTrainingCompletionDate.text = Utils.timestamptoDateConversion(
        int.parse(
            widget.guardingMasterData?.firstAidTrainingCompletionDate ?? '0'),
        Constants.dateFormat);
  }

  getBodybuilder(GuardingMasterDataDetailsState state, height) {
    //returnableTextController.text =
    // state.materialMovement.returnable! ? 'Returnable' : 'Non Returnable';

    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FormStatus.addAttachment ||
        state.status == FormStatus.initial) {
      // log('---getAttachments----builder----${getAttachments?.length}-----');
      // getFiles = state.loadAttachments ?? [];
      // log('---guardAttachments----builder----${state.guardAttachments?.length}-----');

      guardImages = state.guardAttachments ?? [];
      deploymentFiles = state.deploymentAttachments;
      bioDataFiles = state.bioDataAttachments;
      bioDataFiles = state.bioDataAttachments;
      bioDataFiles = state.bioDataAttachments;
      bioDataFiles = state.bioDataAttachments;
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
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: statusController,
                                items: statusDropDownValues,
                                initialValue:
                                    state.guardingMasterData.status.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                      context: context,
                                      dropDownValues: statusDropDownValues
                                          .map((label) => label.key)
                                          .toList(),
                                      onTap: (String value) {
                                        Label? selectedLabel;
                                        selectedLabel =
                                            statusDropDownValues.firstWhere(
                                          (label) => label.key == value,
                                          orElse: () =>
                                              const Label(key: '', value: ''),
                                        );
                                        BlocProvider.of<
                                                    GuardingMasterDataDetailsCubit>(
                                                context)
                                            .updateDropdownValues(
                                                status: int.tryParse(
                                                    selectedLabel.value));
                                      },
                                    );
                                  }
                                }),
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
                            BaseDate().creationDateDisplay(
                                state.guardingMasterData.inputDate ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Building  Location
                            CommonWidgets.textDisplay(
                                Constants.buildingLocation,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            locationWidgetdislay(state),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Entity
                            CommonWidgets.textDisplay(
                              Constants.entity,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            entityaddButtonwidgetLoading(
                              context: context,
                              state: state,
                              selectedValues:
                                  state.guardingMasterData.entities ?? [],
                              all: state.listOfEntities ?? [],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Sl No.
                            CommonWidgets.horizentaltextHandling(Constants.slno,
                                state.guardingMasterData.slNo ?? ''),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Guard Name
                            Column(
                              children: [
                                CommonWidgets.textDisplay(
                                  Constants.name,
                                  Styles.textStyleBlack14,
                                ),
                                TextfieldAddButton(
                                    title:
                                        state.guardingMasterData.guard?.name ??
                                            '',
                                    height: 70,
                                    isDisableColor: false,
                                    onTap: () {
                                      if (widget.guardingMasterData == null) {
                                        BaseDeparmentDialog().userDialog(
                                          context: context,
                                          users: state.emailUsers!,
                                          // TODO: Need to change EntrySecurity to BaseUser
                                          onTap: (BaseUser user) {
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .updateDropdownValues(
                                              guard: user,
                                            );
                                          },
                                        );
                                      }
                                    }),

                                // widget.guardingMasterData == null
                                //     ? TextfieldAddButton(
                                //         title: state.guardingMasterData.guard
                                //                 ?.name ??
                                //             '',
                                //         height: 70,
                                //         isDisableColor: false,
                                //         onTap: () {
                                //           if (widget.guardingMasterData !=
                                //               null) {
                                //             BaseDeparmentDialog().userDialog(
                                //               context: context,
                                //               users: state.emailUsers!,
                                //               // TODO: Need to change EntrySecurity to BaseUser
                                //               onTap: (EntrySecurity user) {
                                //                 BlocProvider.of<
                                //                             GuardingMasterDataDetailsCubit>(
                                //                         context)
                                //                     .updateDropdownValues(
                                //                         guard: user);
                                //               },
                                //             );
                                //           }
                                //         })
                                //     : FlutterInputField(
                                //         initialValue: state.guardingMasterData
                                //                 .guard?.name ??
                                //             '',
                                //         textFormKey: Keys.requesterEmailKey,
                                //         hintText: '',
                                //         isEnable: true,
                                //         isDisableColor:
                                //             state.guardingMasterData.status ==
                                //                 6,
                                //         onChange: (String username) {},
                                //         validateTextField: (String? user) {},
                                //       ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ),

                            /// upload Photo
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadPhoto,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: guardImages,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in guardImages!.toList()) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(guardImages: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.guardAttachments,
                              files: guardImages,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// Guarding Vendor
                            CommonWidgets.textDisplay(
                              Constants.guardingVendor,
                              Styles.textStyleBlack14,
                            ),
                            TextfieldAddButton(
                              title: state.guardingMasterData.vendor?.name,
                              height: 60,
                              isDisableColor: false,
                              onTap: () {
                                BaseDeparmentDialog().departmentDialog(
                                  context: context,
                                  departments: state.departments,
                                  onTap: (Department department) {
                                    BlocProvider.of<
                                                GuardingMasterDataDetailsCubit>(
                                            context)
                                        .updateDropdownValues(
                                            vendor: department);
                                  },
                                );
                              },
                            ),

                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Guarding POC
                            CommonWidgets.textDisplay(
                                Constants.guardingPoc, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue:
                                  state.guardingMasterData.guardingPOC,
                              textFormKey: Keys.guardingPOCKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.guardingPOC ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor: (widget.guardingMasterData !=
                                          null &&
                                      (widget.guardingMasterData?.guardingPOC !=
                                          null))
                                  ? true
                                  : false,
                              onChange: (String value) {
                                state.guardingMasterData.guardingPOC = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

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
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.employeeCode !=
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Rank
                            CommonWidgets.textDisplay(
                                Constants.rank, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: rankController,
                                items: guardRankDropDownValues,
                                initialValue: state.guardingMasterData.guardRank
                                    .toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: guardRankDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              guardRankDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  guardRank: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// DB Employee ID
                            CommonWidgets.textDisplay(Constants.dbEmployeeId,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.dbEmployeeId,
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
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.dbEmployeeId !=
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Type of Duty
                            CommonWidgets.textDisplay(
                                Constants.typeOfDuty, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: dutyTypeController,
                                items: dutyTypeDropDownValues,
                                initialValue: state.guardingMasterData.dutyType
                                    .toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: dutyTypeDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              dutyTypeDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  dutyType: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Gender
                            CommonWidgets.textDisplay(
                                Constants.gender, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: genderController,
                                items: genderDropDownValues,
                                initialValue:
                                    state.guardingMasterData.gender.toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues: genderDropDownValues
                                            .map((label) => label.key)
                                            .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              genderDropDownValues.firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  gender: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Marital Status
                            CommonWidgets.textDisplay(Constants.maritalStatus,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: maritalStatusController,
                                items: maritalStatusDropDownValues,
                                initialValue: state
                                    .guardingMasterData.maritalStatus
                                    .toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            maritalStatusDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              maritalStatusDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  maritalStatus: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Contact Num
                            CommonWidgets.textDisplay(
                                Constants.mobileNum, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.guardingMasterData.contactNo,
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Birth
                            CommonWidgets.textDisplay(
                              Constants.dateOfBirth,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfBirthController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfBirthController.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),

                            /// Date of Joining
                            CommonWidgets.textDisplay(
                              Constants.dateOfJoining,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfJoiningController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfJoiningController.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),

                            /// Type of Deployment
                            CommonWidgets.textDisplay(
                                Constants.typeOfDeployment,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: deploymentTypeController,
                                items: deploymentTypeDropDownValues,
                                initialValue: state
                                    .guardingMasterData.typeOfDeployment
                                    .toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            deploymentTypeDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              deploymentTypeDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  typeOfDeployment:
                                                      int.tryParse(
                                                          selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Deployment order Submitted?
                            CommonWidgets.textDisplay(
                                Constants.deploymentOrderSubmitted,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue: state.guardingMasterData
                                        .deploymentOrderSubmitted
                                    ? 1
                                    : 0,
                                onChangedYes: widget
                                            .guardingMasterData?.status ==
                                        6
                                    ? null
                                    : (val) {
                                        state.guardingMasterData
                                            .deploymentOrderSubmitted = true;
                                        BlocProvider.of<
                                                    GuardingMasterDataDetailsCubit>(
                                                context)
                                            .showFields(
                                                deploymentOrderSubmitted: true);
                                        //.onModelValueChange(state.guardingMasterData
                                        //);
                                      },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                    .deploymentOrderSubmitted =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    deploymentOrderSubmitted:
                                                        false);
                                            // .onModelValueChange(state.guardingMasterData
                                            //  );
                                          }),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: deploymentFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in deploymentFiles ?? []) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(deploymentFiles: files);
                                    },
                                  )
                                : Container(),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.deploymentAttachments,
                              files: deploymentFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// Height
                            CommonWidgets.textDisplay(
                                Constants.height, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.height.toString(),
                              textFormKey: Keys.heightKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.height ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.height !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (int value) {
                                state.guardingMasterData.height = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Weight
                            CommonWidgets.textDisplay(
                                Constants.weight, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.weight.toString(),
                              textFormKey: Keys.weightKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.weight ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.weight !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (int value) {
                                state.guardingMasterData.height = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Chest
                            CommonWidgets.textDisplay(
                                Constants.chest, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue:
                                  state.guardingMasterData.chest.toString(),
                              textFormKey: Keys.chestKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.chest ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.chest !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (int value) {
                                state.guardingMasterData.height = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Local Language
                            CommonWidgets.textDisplay(Constants.localLanguage,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.text,
                              initialValue:
                                  state.guardingMasterData.localLanguage,
                              textFormKey: Keys.languageKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.localLanguage ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData
                                                  ?.localLanguage !=
                                              null))
                                      ? true
                                      : false,
                              onChange: (String value) {
                                state.guardingMasterData.localLanguage = value;
                                context
                                    .read<GuardingMasterDataDetailsCubit>()
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              validateTextField: (String? user) {},
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            ///Local Language Proficiency
                            CommonWidgets.textDisplay(
                                Constants.localLanguageProficiency,
                                Styles.textStyleBlack14),
                            const CheckBoxRow(),

                            ///Hindi Language Proficiency
                            CommonWidgets.textDisplay(
                                Constants.hindiLanguageProficiency,
                                Styles.textStyleBlack14),
                            const CheckBoxRow(),

                            ///English Language Proficiency
                            CommonWidgets.textDisplay(
                                Constants.englishLanguageProficiency,
                                Styles.textStyleBlack14),
                            const CheckBoxRow(),

                            /// Physically Fit?
                            CommonWidgets.textDisplay(Constants.physicallyFit,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue:
                                    state.guardingMasterData.physicallyFit
                                        ? 1
                                        : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .physicallyFit = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .physicallyFit = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          }),

                            /// Security Experience
                            CommonWidgets.textDisplay(
                                Constants.securityExperience,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                            CommonWidgets.textDisplay(Constants.uploadBioData,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: bioDataFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in bioDataFiles ?? []) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(bioDataFiles: files);
                                    },
                                  )
                                : Container(),
                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.bioDataAttachments,
                              files: bioDataFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// permanent Address
                            CommonWidgets.textDisplay(
                                Constants.permanentAddress,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: permanentAddressFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in permanentAddressFiles!.toList()) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(data: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.permanentAddressAttachments,
                              files: permanentAddressFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// Local Address
                            CommonWidgets.textDisplay(Constants.localAddress,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
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
                                state.guardingMasterData.localAddress = value;
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
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: localAddressFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in localAddressFiles!.toList()) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(data: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.localAddressAttachments,
                              files: localAddressFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// Qualifications
                            CommonWidgets.textDisplay(
                              Constants.qualifications,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            qualificationAddButtonWidgetLoading(
                              context: context,
                              state: state,
                              selectedValues:
                                  state.guardingMasterData.qualifications ?? [],
                              all: state.listOfQualifications ?? [],
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// PVC Issued Date
                            CommonWidgets.textDisplay(
                              Constants.pvcIssuedDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcIssuedDateController,
                              onChange: (String value) {
                                log('---value-$value------');
                                log('-----pvcIssuedDateController---value-${pvcIssuedDateController.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                state.guardingMasterData.pvcIssuedDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                                // pvcIssuedDateController.text = state.guardingMasterData.pvcIssuedDate??'';
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// PVC Expiry Date
                            CommonWidgets.textDisplay(
                              Constants.pvcExpiryDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: pvcExpiryDateController,
                              onChange: (String value) {
                                log('--fr-value-${pvcIssuedDateController.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: pVCFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in pVCFiles!.toList()) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(data: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.pVCAttachments,
                              files: pVCFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /// Training Certificate
                            CommonWidgets.textDisplay(
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
                                            state.guardingMasterData
                                                    .trainingCertificateProvided =
                                                true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                    .trainingCertificateProvided =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          }),
                            if (state.guardingMasterData
                                .trainingCertificateProvided) ...[
                              /// upload File
                              widget.guardingMasterData == null
                                  ? CommonWidgets.textDisplay(
                                      Constants.uploadfile,
                                      Styles.textStyleBlack14)
                                  : Container(),
                              widget.guardingMasterData == null
                                  ? CommonWidgets.verticalSpacerWidget(
                                      height * 0.001)
                                  : Container(),
                              widget.guardingMasterData == null
                                  ? BaseImageUpload().uploadWidget(
                                      context: context,
                                      loggedInUserDetails:
                                          state.loggedInUserDetails ??
                                              EntrySecurity(),
                                      getFiles: trainingFiles,
                                      onImageSelected: (CreateImage data) {
                                        log('-------function---onImageSelected---------');
                                        List<CreateImage>? files = [];
                                        files.add(data);
                                        for (CreateImage image
                                            in trainingFiles!.toList()) {
                                          files.add(image);
                                        }
                                        BlocProvider.of<
                                                    GuardingMasterDataDetailsCubit>(
                                                context)
                                            .addAttchment(data: files);
                                      },
                                    )
                                  : Container(),

                              // Attachments
                              BaseImageUpload().getAttachment(
                                height: height,
                                attachments: state.trainingAttachments,
                                files: trainingFiles,
                                showDownloadIcon:
                                    widget.guardingMasterData != null
                                        ? true
                                        : false,
                              ),
                            ],

                            /// Medical Certificate Valid Until
                            CommonWidgets.textDisplay(
                              Constants.medicalCertificateValidUntil,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController:
                                  medicalCertificateValidUntilController,
                              onChange: (String value) {
                                log('--fr-value-${medicalCertificateValidUntilController.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// upload File
                            widget.guardingMasterData == null
                                ? CommonWidgets.textDisplay(
                                    Constants.uploadfile,
                                    Styles.textStyleBlack14)
                                : Container(),
                            widget.guardingMasterData == null
                                ? CommonWidgets.verticalSpacerWidget(
                                    height * 0.001)
                                : Container(),
                            widget.guardingMasterData == null
                                ? BaseImageUpload().uploadWidget(
                                    context: context,
                                    loggedInUserDetails:
                                        state.loggedInUserDetails ??
                                            EntrySecurity(),
                                    getFiles: medicalFiles,
                                    onImageSelected: (CreateImage data) {
                                      log('-------function---onImageSelected---------');
                                      List<CreateImage>? files = [];
                                      files.add(data);
                                      for (CreateImage image
                                          in medicalFiles!.toList()) {
                                        files.add(image);
                                      }
                                      BlocProvider.of<
                                                  GuardingMasterDataDetailsCubit>(
                                              context)
                                          .addAttchment(data: files);
                                    },
                                  )
                                : Container(),

                            // Attachments
                            BaseImageUpload().getAttachment(
                              height: height,
                              attachments: state.medicalAttachments,
                              files: medicalFiles,
                              showDownloadIcon:
                                  widget.guardingMasterData != null
                                      ? true
                                      : false,
                            ),

                            /*    /// System Access
                                CommonWidgets.textDisplay(Constants.systemAccess,
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
*/

                            /// System Access
                            CommonWidgets.textDisplay(Constants.systemAccess,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            BaseDropDown().getDropDown(
                                isDisabled:
                                    state.guardingMasterData.status != 6,
                                textController: systemAccessController,
                                items: systemAccessDropDownValues,
                                initialValue: state
                                    .guardingMasterData.systemAccess
                                    .toString(),
                                onTap: () {
                                  if (isDisabled) {
                                    BaseDropDown().assetTypeDialog(
                                        context: context,
                                        dropDownValues:
                                            systemAccessDropDownValues
                                                .map((label) => label.key)
                                                .toList(),
                                        onTap: (String value) {
                                          Label? selectedLabel;
                                          selectedLabel =
                                              systemAccessDropDownValues
                                                  .firstWhere(
                                            (label) => label.key == value,
                                            orElse: () =>
                                                const Label(key: '', value: ''),
                                          );
                                          BlocProvider.of<
                                                      GuardingMasterDataDetailsCubit>(
                                                  context)
                                              .updateDropdownValues(
                                                  systemAccess: int.tryParse(
                                                      selectedLabel.value));
                                        });
                                  }
                                }),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// OnBoarded
                            CommonWidgets.textDisplay(
                                Constants.onBoarded, Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue:
                                    state.guardingMasterData.onboarded ? 1 : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.guardingMasterData.onboarded =
                                                true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData.onboarded =
                                                false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .onModelValueChange(
                                                    state.guardingMasterData);
                                          }),

                            /// ESIC No
                            CommonWidgets.textDisplay(
                                Constants.esicNo, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.guardingMasterData.esicNo,
                              textFormKey: Keys.esicKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.esicNo ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// UAN  No
                            CommonWidgets.textDisplay(
                                Constants.uanNo, Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              keyboardType: TextInputType.number,
                              initialValue: state.guardingMasterData.uanNo,
                              textFormKey: Keys.uanNoKey,
                              hintText: '',
                              isEnable: widget.guardingMasterData == null
                                  ? true
                                  : (widget.guardingMasterData != null &&
                                          (widget.guardingMasterData?.uanNo ==
                                              null))
                                      ? false
                                      : true,
                              isDisableColor:
                                  (widget.guardingMasterData != null &&
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
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of First Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfFirstCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfFirstCovidDoseController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfFirstCovidDoseController.text}------');
                                // widget.guardingMasterData?.covidFirstDoseDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Second Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfSecondCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfSecondCovidDoseController,
                              onChange: (String value) {
                                log('--fr-value-${dateOfSecondCovidDoseController.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// Date of Precautionary Covid Dose
                            CommonWidgets.textDisplay(
                              Constants.dateOfPrecautionaryCovidDose,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: dateOfPrecautionaryCovidDose,
                              onChange: (String value) {
                                log('--fr-value-${dateOfPrecautionaryCovidDose.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// ERT Certification Date
                            CommonWidgets.textDisplay(
                              Constants.ertCertificationDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: ertCertificationDate,
                              onChange: (String value) {
                                log('--fr-value-${ertCertificationDate.text}------');
                                //widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// First Aid Training Completion Date
                            CommonWidgets.textDisplay(
                              Constants.firstAidTrainingCompletionDate,
                              Styles.textStyleBlack14,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),

                            BaseDate().datePickerWidgetLoading(
                              textController: firstAidTrainingCompletionDate,
                              onChange: (String value) {
                                log('--fr-value-${firstAidTrainingCompletionDate.text}------');
                                // widget.guardingMasterData?.inputDate = value;
                                BlocProvider.of<GuardingMasterDataDetailsCubit>(
                                        context)
                                    .onModelValueChange(
                                        state.guardingMasterData);
                              },
                              context: context,
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),

                            /// CSR Participation
                            CommonWidgets.textDisplay(
                                Constants.csrParticipation,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue:
                                    state.guardingMasterData.csrParticipation
                                        ? 1
                                        : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .csrParticipation = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    csrParticipation: true);
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .csrParticipation = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    csrParticipation: false);
                                          }),

                            if (state.guardingMasterData.csrParticipation) ...[
                              CommonWidgets.textDisplay(
                                  Constants.participationDates,
                                  Styles.textStyleBlack14),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: <Widget>[
                                    // Expanded(
                                    //child:
                                    const SizedBox(width: 14),
                                    SvgPicture.asset(
                                      AppIcon.pluscircle,
                                      //color: AppColors.navigationSkybluecolor,
                                    ),
                                    // ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      Constants.addParticipationDates,
                                      style: TextStyle(
                                        color: AppColors.navigationSkybluecolor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],

                            Column(
                              children: getParticipationDates(state, height),
                            ),

                            /// Special Achivements
                            CommonWidgets.textDisplay(
                                Constants.specialAchievements,
                                Styles.textStyleBlack14),
                            RadioButtonsYesNo(
                                status: state.guardingMasterData.status ?? 0,
                                selectedValue:
                                    state.guardingMasterData.specialAchievement
                                        ? 1
                                        : 0,
                                onChangedYes:
                                    widget.guardingMasterData?.status == 6
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .specialAchievement = true;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    specialAchievement: true);
                                            // .onModelValueChange(state.guardingMasterData
                                            // );
                                          },
                                onChangedNo:
                                    widget.guardingMasterData?.status == 4
                                        ? null
                                        : (val) {
                                            state.guardingMasterData
                                                .specialAchievement = false;
                                            BlocProvider.of<
                                                        GuardingMasterDataDetailsCubit>(
                                                    context)
                                                .showFields(
                                                    specialAchievement: false);
                                          }),

                            if (state
                                .guardingMasterData.specialAchievement) ...[
                              CommonWidgets.verticalSpacerWidget(
                                  height * 0.001),
                              FlutterInputField(
                                lineHeight: 6,
                                initialValue: state
                                    .guardingMasterData.additionalInitiatives,
                                textFormKey: Keys.additionInitiativesKey,
                                hintText: Constants.informationhere,
                                isEnable: state.guardingMasterData.status != 4,
                                isDisableColor:
                                    state.guardingMasterData.status == 4,
                                onChange: (String value) {
                                  state.guardingMasterData
                                      .additionalInitiatives = value;
                                  context
                                      .read<GuardingMasterDataDetailsCubit>()
                                      .onModelValueChange(
                                          state.guardingMasterData);
                                },
                                validateTextField: (String? user) {},
                              ),
                              CommonWidgets.verticalSpacerWidget(height * 0.01),
                            ],

                            /// Additional Initiatives Info
                            CommonWidgets.textDisplay(
                                Constants.additionalInitiativesInfo,
                                Styles.textStyleBlack14),
                            CommonWidgets.verticalSpacerWidget(height * 0.001),
                            FlutterInputField(
                              lineHeight: 6,
                              initialValue: state
                                  .guardingMasterData.additionalInitiatives,
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

  List<Widget> getParticipationDates(
      GuardingMasterDataDetailsState state, height) {
    List<Widget> widgets = [];

    log('-state.participationDates---${state.participationDates?.length}---');
    for (String date in state.participationDates ?? []) {
      TextEditingController dateController = TextEditingController();
      // dateController.text = Utils.timestamptoDateConversion(
      //     int.parse(widget.guardingMasterData?.dateOfBirth ?? '0'),
      //     Constants.dateFormat);
      dateController.text = date;
      widgets.add(
        BaseDate().datePickerWidgetLoading(
          textController: dateController,
          onChange: (String value) {
            log('--fr-value-${dateController.text}------');
            // widget.guardingMasterData?.inputDate = value;
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .onModelValueChange(state.guardingMasterData);
          },
          context: context,
        ),
      );
      widgets.add(CommonWidgets.verticalSpacerWidget(height * 0.01));
    }
    return widgets;
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

  // Widget uploadWidget({
  //   required BuildContext context,
  //   required EntrySecurity loggedInUserDetails,
  //   required Function onImageSelected,
  //   // required List<CreateImage>? getFiles,
  // }) {
  //   return Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: const Color(0xFFCACACA),
  //           width: 1.0,
  //         ),
  //         borderRadius: const BorderRadius.all(Radius.circular(8))),
  //     child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //       Padding(
  //         padding: const EdgeInsets.only(right: 5.0),
  //         child: ElevatedButton.icon(
  //           style:
  //           ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
  //           onPressed: () {
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext dialogContext) {
  //                   return UploadAttachment(
  //                     userdetails: loggedInUserDetails,
  //                     getFiles: getFiles ?? [],
  //                     onImageSelected: onImageSelected,
  //                   );
  //                 });
  //           },
  //
  //           icon: SvgPicture.asset(
  //             //AppIcon.dropdownicon,
  //             AppIcon.uploadicon,
  //             //fit: BoxFit.,
  //             color: AppColors.backgroundWhitecolor,
  //             width: 13,
  //             height: 13,
  //             key: const Key(Keys.userIcon),
  //           ),
  //           label: const Text(
  //             Constants.clicktoupload,
  //             style: Styles.textStyleRegularNormalWhite12,
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }

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

                  BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                      .updateDropdownValues(location: location, entities: []);
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

  Widget attachmentListviews(
    List<CreateImage>? attachmentListviews,
    List<FoundImage>? attachmentListviews1,
  ) {
    log('----attachmentListviews---cc--${attachmentListviews?.length}-----------');
    log('----attachmentListviews1----found-${attachmentListviews1?.length}-----------');

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

  Widget entityaddButtonwidgetLoading({
    required BuildContext context,
    required GuardingMasterDataDetailsState state,
    required List<Entity> selectedValues,
    required List<Entity> all,
  }) {
    String title = '';
    // log('--selectedValues.length-${selectedValues.length}--');
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Entity entity = selectedValues[i];
        // log('--entity name-${entity.name}--');

        String value = entity.name ?? '';
        title = '$title  $value';
      }
    }

    return TextfieldAddButton(
      title: title,
      height: (selectedValues.length) > 4
          ? (selectedValues.length) > 9
              ? 140
              : 100
          : 60,
      isDisableColor: false,
      onTap: () {
        _showEntitySelectionDialog(context, state);
      },
    );
  }

  void _showEntitySelectionDialog(
      BuildContext context, GuardingMasterDataDetailsState state) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionListTexts(
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddNewFields(
                    title: Constants.addentitytype,
                    // createpassmgmtstate: state,
                  );
                });
          },
          duplicateEntityList: state.listOfEntities ?? [],
          mainSelectedEntityList: state.guardingMasterData.entities ?? [],
          onTap: (List<Entity> selectedEntities) {
            log('--selectedEntities----${selectedEntities.length}');
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .updateDropdownValues(entities: selectedEntities);
            Navigator.of(context).pop(); // Close the dialog
          },
          leftImageName: AppIcon.addicon, // Provide your left button icon
        );
      },
    );
  }

  Widget qualificationAddButtonWidgetLoading({
    required BuildContext context,
    required GuardingMasterDataDetailsState state,
    required List<Entity> selectedValues,
    required List<Entity> all,
  }) {
    String title = '';
    log('--selectedValues.length-${selectedValues.length}--');
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Entity qualification = selectedValues[i];
        log('--entity name-${qualification.name}--');

        String value = qualification.name ?? '';
        title = '$title  $value';
      }
    }

    return TextfieldAddButton(
      title: title,
      height: (selectedValues.length) > 4
          ? (selectedValues.length) > 9
              ? 140
              : 100
          : 60,
      isDisableColor: false,
      onTap: () {
        _showQualificationSelectionDialog(context, state);
      },
    );
  }

  void _showQualificationSelectionDialog(
      BuildContext context, GuardingMasterDataDetailsState state) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionListTexts(
          onLeftButtonTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AddNewFields(
                    title: Constants.addQualificationType,
                  );
                });
          },
          duplicateEntityList: state.listOfQualifications ?? [],
          mainSelectedEntityList: state.guardingMasterData.qualifications ?? [],
          onTap: (List<Entity> selectedQualifications) {
            log('--selectedEntities----${selectedQualifications.length}');
            BlocProvider.of<GuardingMasterDataDetailsCubit>(context)
                .updateDropdownValues(qualifications: selectedQualifications);
            Navigator.of(context).pop(); // Close the dialog
          },
          leftImageName: AppIcon.addicon, // Provide your left button icon
        );
      },
    );
  }
}
