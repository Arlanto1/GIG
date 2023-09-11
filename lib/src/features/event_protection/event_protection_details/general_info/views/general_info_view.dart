import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_drop_down.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_entities_dropdown.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_list_tile_item.dart';
import 'package:db_atom/src/common_widgets/base_widget/date_picker_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/models/entity.dart';
import 'package:db_atom/src/models/location.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/base_widget/radio_buttons_yes_no.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../cubits/general_info_cubit.dart';

class GeneralInfoView extends StatefulWidget {
  const GeneralInfoView({
    super.key,
  });

  @override
  State<GeneralInfoView> createState() => _GeneralInfoViewState();
}

class _GeneralInfoViewState extends State<GeneralInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<CreateImage>? guardFiles;
  List<CreateImage>? deploymentFiles;
  List<CreateImage>? bioDataFiles;
  List<CreateImage>? permanentAddressFiles;
  List<CreateImage>? localAddressFiles;
  List<CreateImage>? pVCFiles;
  List<CreateImage>? trainingFiles;
  List<CreateImage>? mSGBAFiles;
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

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GeneralInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<GeneralInfoCubit, GeneralInfoState>(
      listener: (context, state) {
        log('-state.status---${state.status}----');

        if (state.status == FormStatus.success) {
          var dialog = CustomAlertDialog(
            title: 'Guarding Master Data',
            message: state.message ?? '',
            positiveBtnText: Constants.ok,
            onPostivePressed: () {
              // TODO: Need to improve this code
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.popAndPushNamed(
                context,
                guardingMasterDataRoute,
                arguments: {},
              );
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
            title: Constants.generalInformation,
            showPopUp: false,
            showSaveButton: state.model.status != 4 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<GeneralInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(GeneralInfoState state, height) {
    if (state.status == FormStatus.loading) {
      return const Center(child: CircularProgressIndicator());
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
                  )),
              child: Form(
                key: _formKey,
                autovalidateMode: state.model.status == 4
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
                              isDisabled: state.model.status != 6,
                              textController: statusController,
                              items: statusDropDownValues,
                              initialValue: '${state.model.status ?? 1}',
                              onTap: () {
                                if (state.model.id != null) {
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
                                      BlocProvider.of<GeneralInfoCubit>(context)
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
                          BaseDate()
                              .creationDateDisplay(state.model.inputDate ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location
                          CommonWidgets.textDisplay(
                              Constants.location, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          locationWidgetdislay(state),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Entity
                          CommonWidgets.textDisplay(
                            Constants.entity,
                            Styles.textStyleBlack14,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),

                          BaseEntitiesSelection().entityDropDownSelection(
                              context: context,
                              selectedValues: state.model.entities ?? [],
                              all: state.listOfEntities ?? [],
                              onTap: (List<Entity> selectedEntities) {
                                log('--selectedEntities----${selectedEntities.length}');
                                BlocProvider.of<GeneralInfoCubit>(context)
                                    .updateDropdownValues(
                                        entities: selectedEntities);
                                Navigator.of(context).pop(); // Close the dialog
                              }),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Sl No.
                          CommonWidgets.horizentaltextHandling(
                              Constants.slno, state.model.slNo ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ]),
                      ),

                      /// Deployment order Submitted?
                      CommonWidgets.textDisplay(
                          Constants.deploymentOrderSubmitted,
                          Styles.textStyleBlack14),
                      RadioButtonsYesNo(
                          status: state.model.status ?? 0,
                          selectedValue:
                              state.model.annualPowerShutdown ?? false ? 1 : 0,
                          onChangedYes: state.model.status == 6
                              ? null
                              : (val) {
                                  state.model.annualPowerShutdown = true;
                                  BlocProvider.of<
                                              GeneralInfoCubit>(
                                          context)
                                      .onCheckBoxChange(state.model
                                      );
                                  //.onModelValueChange(state.guardingMasterData
                                  //);
                                },
                          onChangedNo: state.model.status == 4
                              ? null
                              : (val) {
                                  state.model.annualPowerShutdown = false;
                                  BlocProvider.of<
                                      GeneralInfoCubit>(
                                          context)
                                      .onCheckBoxChange(
                                      state.model);
                                  // .onModelValueChange(state.guardingMasterData
                                  //  );
                                }),

                      /// SubmitButton
                      if (state.model.status != 4) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            cancelButtonDisplay(),
                            submitButtonDisplay()
                          ],
                        ),
                      ],
                      CommonWidgets.verticalSpacerWidget(height * 0.04),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
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
        BlocProvider.of<GeneralInfoCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }

  Widget locationWidgetdislay(GeneralInfoState state) {
    return GestureDetector(
      onTap: () {
        if (state.model.id == null ||
            (state.model.location?.name ?? '').isEmpty) {
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
                  state.model.location = location;

                  BlocProvider.of<GeneralInfoCubit>(context)
                      .updateDropdownValues(location: location);
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
    );
  }
}
