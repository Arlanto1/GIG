import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/enums/form_status.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/event_protection/event_protection_details/contact_info/models/contact_info_model.dart';
import 'package:db_atom/src/features/event_protection/models/event_protection_model.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/customalert.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main_DEV.dart';
import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/new_search_textfield.dart';
import '../../../../../common_widgets/textfiled_addbutton.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../cubits/contact_info_cubit.dart';

class ContactInfoView extends StatefulWidget {
  final ContactInfoModel? model;
  final bool? isAnnualPowerShutDown;
   const ContactInfoView({
    this.model,
    super.key,  this.isAnnualPowerShutDown,
  });

  @override
  State<ContactInfoView> createState() => _ContactInfoViewState();
}

class _ContactInfoViewState extends State<ContactInfoView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GetUserDetails? userDetails;
  List<CreateImage>? getFiles;
  List<FoundImage>? getAttachments;
  //bool isExtraSecurityDeployed = true;
 bool annualPowerShutDown = true;
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController dateOfJoiningController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  bool isDisabled = true;

  get guardingMasterData => null;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactInfoCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<ContactInfoCubit, ContactInfoState>(
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
            showSaveButton: true,
            // showSaveButton: state.model.status != 4 ? true : false,
            onTapSave: () {
              FocusScope.of(context).unfocus();
              BlocProvider.of<ContactInfoCubit>(context)
                  .submitForm(isSaveOnly: true);
            },
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBodybuilder(state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBodybuilder(ContactInfoState state, height) {
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
                // autovalidateMode: state.model.status == 4
                //     ? AutovalidateMode.disabled
                //     : AutovalidateMode.onUserInteraction,
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

                        if(annualPowerShutDown== false)...[
                          /// Sub Regional Head (SRH) 1
                          CommonWidgets.textDisplay(
                            Constants.subRegionalHead1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.srh1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Srh1 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    subRegionalHead1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Sub Regional Head (SRH) 2
                          CommonWidgets.textDisplay(
                            Constants.subRegionalHead2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.srh2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Srh2 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    subRegionalHead2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                     ],

                           if(annualPowerShutDown== true)...[
                          /// Event Protection Manager 1
                          CommonWidgets.textDisplay(
                            Constants.eventProtectionManager1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.epManager1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (EpManager1 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    epManager1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Event Protection Manager 2
                          CommonWidgets.textDisplay(
                            Constants.eventProtectionManager2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.epManager2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (EpManager2 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    epManager2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                       ],
                          /// Location Security  Manager 1
                          CommonWidgets.textDisplay(
                            Constants.locationSecurityManager1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.lsm1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Lsm1 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    locationSecurityManager1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///LSM 1 Contact No
                          CommonWidgets.textDisplay(
                              Constants.lsm1ContactNo, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.lsm1ContactNo,
                            textFormKey: Keys.lsm1ContactNOKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.lsm1ContactNo == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.lsm1ContactNo != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.lsm1ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          /// Location Security  Manager 2
                          CommonWidgets.textDisplay(
                            Constants.locationSecurityManager2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.lsm2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Lsm2 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    locationSecurityManager2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///LSM 2 Contact No
                          CommonWidgets.textDisplay(
                              Constants.lsm2ContactNo, Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.lsm2ContactNo,
                            textFormKey: Keys.lsm2ContactNOKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.lsm2ContactNo == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.lsm2ContactNo != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.lsm2ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1
                          CommonWidgets.textDisplay(
                            Constants.businessPoc1,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu1?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Bu1 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    bu1: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1 Contact No
                          CommonWidgets.textDisplay(
                              Constants.businessPoc1ContactNo,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.bu1ContactNo,
                            textFormKey: Keys.bu1ContactNOKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.bu1ContactNo == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.bu1ContactNo != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.bu1ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 2

                          CommonWidgets.textDisplay(
                            Constants.businessPoc2,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu2?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (Bu2 user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    bu2: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 2 Contact No
                          CommonWidgets.textDisplay(
                              Constants.businessPoc2ContactNo,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.number,
                            initialValue: state.model.bu2ContactNo,
                            textFormKey: Keys.bu2ContactNOKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.bu2ContactNo == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.bu2ContactNo != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.bu2ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 1Department
                          CommonWidgets.textDisplay(
                            Constants.businessPoc1Department,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu1Dept?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                          bu1Dept: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Business POC 2 Department
                          CommonWidgets.textDisplay(
                            Constants.businessPoc2Department,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.bu2Dept?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                          bu2Dept: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///System Vendor 1 Email
                          CommonWidgets.textDisplay(
                              Constants.systemVendor1Email,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor1,
                            textFormKey: Keys.systemVendor1EmailKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor1 == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor1 != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor1 = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///System Vendor 1 Email
                          CommonWidgets.textDisplay(
                              Constants.systemVendor1Email,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor1,
                            textFormKey: Keys.systemVendor1EmailKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor1 == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor1 != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor1 = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Vendor 1 Contact No
                          CommonWidgets.textDisplay(Constants.vendor1ContactNO,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor1ContactNo,
                            textFormKey: Keys.vendor1Contact1Key,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor1ContactNo ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor1ContactNo !=
                                        null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor1ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Name
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerName,
                              state.model.vendor1Primary ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerContact,
                              state.model.vendor1PrimaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Name
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerName,
                              state.model.vendor1Secondary ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerContact,
                              state.model.vendor1SecondaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///System Vendor 2 Email
                          CommonWidgets.textDisplay(
                              Constants.systemVendor2Email,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor2,
                            textFormKey: Keys.systemVendor2EmailKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor2 == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor2 != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor2 = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Vendor 2 Contact No
                          CommonWidgets.textDisplay(Constants.vendor2ContactNO,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor2ContactNo,
                            textFormKey: Keys.vendor2ContactKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor2ContactNo ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor2ContactNo !=
                                        null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor2ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerContact,
                              state.model.vendor2PrimaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerContact,
                              state.model.vendor2PrimaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Name
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerName,
                              state.model.vendor2Secondary ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerContact,
                              state.model.vendor2SecondaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///System Vendor 3 Email
                          CommonWidgets.textDisplay(
                              Constants.systemVendor3Email,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor3,
                            textFormKey: Keys.systemVendor2EmailKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor3 == null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor3 != null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor3 = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Vendor 2 Contact No
                          CommonWidgets.textDisplay(Constants.vendor3ContactNO,
                              Styles.textStyleBlack14),
                          CommonWidgets.verticalSpacerWidget(height * 0.001),
                          FlutterInputField(
                            keyboardType: TextInputType.text,
                            initialValue: state.model.systemVendor2ContactNo,
                            textFormKey: Keys.vendor2ContactKey,
                            hintText: '',
                            isEnable: widget.model == null
                                ? true
                                : (widget.model != null &&
                                        (widget.model?.systemVendor2ContactNo ==
                                            null))
                                    ? false
                                    : true,
                            isDisableColor: (widget.model != null &&
                                    (widget.model?.systemVendor2ContactNo !=
                                        null))
                                ? true
                                : false,
                            onChange: (String value) {
                              state.model.systemVendor2ContactNo = value;
                              context
                                  .read<ContactInfoCubit>()
                                  .onModelValueChange(state.model);
                            },
                            validateTextField: (String? user) {},
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerContact,
                              state.model.vendor3PrimaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Primary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.primaryServiceEngineerContact,
                              state.model.vendor3PrimaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Name
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerName,
                              state.model.vendor3Secondary ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Secondary Service Engineer Contact
                          CommonWidgets.horizentaltextHandling(
                              Constants.secondaryServiceEngineerContact,
                              state.model.vendor3SecondaryContact ?? ''),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Requester Department
                          CommonWidgets.textDisplay(
                            Constants.requesterDepartment,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.requesterDepartment?.name,
                            height: 60,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().departmentDialog(
                                context: context,
                                departments: state.departments,
                                onTap: (Department department) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                          requesterDepartment: department);
                                },
                              );
                            },
                          ),

                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Event Protection Officer
                          CommonWidgets.textDisplay(
                            Constants.eventProtectionOfficers,
                            Styles.textStyleBlack14,
                          ),
                          TextfieldAddButton(
                            title: state.model.epOfficers,
                            height: 70,
                            isDisableColor: false,
                            onTap: () {
                              BaseDepartmentDialog().userDialog(
                                context: context,
                                users: state.emailUsers!,
                                onTap: (BaseUser user) {
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .updateDropdownValues(
                                    epOfficers: user,
                                  );
                                },
                              );
                            },
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),

                          ///Is Extra Security Deployment Required
                          if(annualPowerShutDown== false)...[
                          Row(children: [
                            CommonWidgets.textDisplay(
                              Constants.isExtraSecurityDeploymentRequired,
                              Styles.textStyleBlack14,
                            ),
                            Checkbox(
                                activeColor: AppColors.navigationSkybluecolor,
                                focusColor: AppColors.navigationSkybluecolor,
                                value: state.model.extraSecurityDeployed ?? false,
                                onChanged: (bool? value) {
                                  state.model.extraSecurityDeployed = value;
                                  BlocProvider.of<ContactInfoCubit>(context)
                                      .onCheckBoxChange(state.model);
                                })
                          ]),
],

                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                        ]),
                      ),

                      /// SubmitButton
                      // if (state.model.status != 4) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cancelButtonDisplay(),
                          submitButtonDisplay()
                        ],
                      ),
                      // ],
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
        BlocProvider.of<ContactInfoCubit>(context)
            .submitForm(isSaveOnly: false);
      },
    );
  }
}
