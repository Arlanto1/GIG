import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/routing/router.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../common_widgets/base_widget/multiple_selection_pop_up.dart';
import '../../../../../common_widgets/create_fields.dart';
// import '../../../../../common_widgets/custom_multiple_selection_popup.dart';
import '../../../../../common_widgets/date_time_picker.dart';
import '../../../../../models/department.dart';
import '../../../../../models/entity.dart';
import '../../../../lawenforcement/models/addentities.dart';

class RatesInfo extends StatefulWidget {
  final GMRate? rate;
  final String title;

  const RatesInfo({
    super.key,
    this.rate,
    required this.title,
  });

  @override
  State<RatesInfo> createState() => _RatesInfoState();
}

class _RatesInfoState extends State<RatesInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String receiverDepartmentName = '';
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
    BlocProvider.of<PayRateCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
        appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: widget.title,
          showPopUp: false,
          showSaveButton: true,
          onTapSave: () {
            FocusScope.of(context).unfocus();
            // BlocProvider.of<PayRateCubit>(context)
            //     .submitForm(isSaveOnly: true);
          },
        ),
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     cancelButtonDisplay(),
        //     // TODO: Need to remove this InkWell as Navigation will be handled via Bloc Listener
        //     submitButtonDisplay(onTap: () {
        //
        //
        //       final state = myCubit.state;
        //       log('-onTapSubmit--${state.rate.vendor?.name}----');
        //       FocusScope.of(context).unfocus();F
        //       BlocProvider.of<PayRateCubit>(context).onSave(
        //         isSubmit: false,
        //       );
        //       Navigator.pushNamed(
        //         context,
        //         payRateRoute,
        //         arguments: {
        //           "gmRate": state.rate,
        //           "title": Constants.materialMovementOutwardEdit,
        //         },
        //       );
        //     }),
        //   ],
        // ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocConsumer<PayRateCubit, PayRateState>(
          listener: (context, state) {
            if (state.status == FormStatus.success) {
              Utils.dynamicAlert(
                  context, state.message ?? '', 'Material Movement', '');
            }
            // TODO: Navigate to Next Page
            if (state.status == FormStatus.error) {
              Validator().showToast(
                context,
                state.message ?? 'Invalid Information',
              );
            }
          },
          builder: (context, state) {
            log('--status--${state.status}----');

            if (state.status == FormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
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
                      // autovalidateMode: state.rate.status == 6
                      //     ? AutovalidateMode.disabled
                      //     : AutovalidateMode.onUserInteraction,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: Column(children: [
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.02),

                                /// Created By
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        CommonWidgets.verticalTextHandling(
                                            Constants.createdby,
                                            state.loggedInUserDetails?.name ??
                                                ''),
                                        CommonWidgets.verticalSpacerWidget(
                                            height * 0.01),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Text('1/6'),
                                  ],
                                ),

                                /// Location
                                CommonWidgets.textDisplay(Constants.location,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                locationWidgetdislay(state),

                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Date of creation
                                CommonWidgets.textDisplay(
                                    Constants.dateofcreation,
                                    Styles.textStyleBlack14),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.001),
                                datecreateWidgetdisplay(
                                    state.rate.inputDate ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Sl No.
                                CommonWidgets.horizentaltextHandling(
                                    Constants.slno, state.rate.slNo ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Entity
                                CommonWidgets.textDisplay(
                                  Constants.entity,
                                  Styles.textStyleBlack14,
                                ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                // entityaddButtonwidgetLoading(state),

                                // ElevatedButton(
                                //   onPressed: () {
                                //     _showEntitySelectionDialog(context, state);
                                //   },
                                //   child: const Text('Select Entities'),
                                // ),

                                entityaddButtonwidgetLoading(context, state, state.rate.entities??[], state.listOfEntities??[]),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Vendor
                                CommonWidgets.textDisplay(
                                  Constants.vendor,
                                  Styles.textStyleBlack14,
                                ),
                                widget.rate == null
                                    ? FlutterInputField(
                                        initialValue: state.rate.vendor?.name,
                                        textFormKey: Keys.vendorDepartmentKey,
                                        hintText: '',
                                        isEnable: true,
                                        isDisableColor: false,
                                        onChange: (String value) {},
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.rate.vendor?.name,
                                        height: 60,
                                        isDisableColor: false,
                                        onTap: () {
                                          BaseDialog().departmentDialog(
                                            context: context,
                                            departments: state.departments,
                                            onTap: (Department department) {
                                              BlocProvider.of<PayRateCubit>(
                                                      context)
                                                  .updateDropdownValues(
                                                      vendor: department);
                                            },
                                          );
                                        },
                                      ),

                                // quantityUnitPopUp(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ]),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                cancelButtonDisplay(),
                                submitButtonDisplay(onTap: () {
                                  log('-onTapSubmit--${state.rate.vendor?.name}----');
                                  FocusScope.of(context).unfocus();
                                  BlocProvider.of<PayRateCubit>(context).onSave(
                                    isSubmit: false,
                                  );

                                  // BlocProvider.of<PayRateCubit>(context)
                                  //     .onModelValueChange(state.);

                                  Navigator.pushNamed(
                                    context,
                                    payRateRoute,
                                    arguments: {
                                      "payRates": state.rate.securityGuardRates,
                                      "gmRate": state.rate,
                                      "title":
                                          Constants.createSecurityGuard,
                                    },
                                  );
                                }),
                              ],
                            )
                          ]),
                    ),
                  ),
                ]),
              ),
            );
          },
        )); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  Widget entityaddButtonwidgetLoading(BuildContext context, PayRateState state, List<Entity> selectedValues, List<Entity> all) {
    String title = '';
    if (selectedValues.isNotEmpty) {
      for (int i = 0; i < selectedValues.length; i++) {
        Entity entity = selectedValues[i];
        log('-entities--name-${entity.name}--');


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
        log('--list-${selectedValues.length}-');

        // if ((selectedValues != null && (title.isEmpty))) {
          log('----');
        _showEntitySelectionDialog(context, state);
        // }
      },
    );
  }

  void _showEntitySelectionDialog(BuildContext context, PayRateState state) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomMultipleSelectionListTexts(
          duplicateEntityList: state.listOfEntities??[],
          mainSelectedEntityList: state.rate.entities??[], // Pass initially selected entities here
          onTap: (List<Entity> selectedEntities) {
            // This callback is called when the user confirms the selection
            // Do something with selectedEntities
            print('Selected Entities: ${selectedEntities.map((e) => e.name).toList()}');
            Navigator.of(context).pop(); // Close the dialog
          },
          leftImageName: 'left_arrow_icon.png', // Provide your left button icon
        );
      },
    );
  }

  // entityTypeDialog(PayRateState state) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext dialogContext) {
  //         return CustomMultipleSelectionListTexts(
  //           duplicateentityList: state.getEntitiesResponse?.atomEntities ?? [],
  //           leftimagename: AppIcon.addicon,
  //           mainselectedentityList:state.listOfEntities ?? [],
  //           onLeftButtonTap: () {
  //             Navigator.pop(context);
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext dialogContext) {
  //                   return  AddNewFields(
  //                     title: Constants.addentitytype,
  //                     payRateState: state,
  //                     entityFun: (){
  //                       // BlocProvider.of<PayRateCubit>(context).getEntityData();
  //                     },
  //                   );
  //                 });
  //
  //           },
  //           onTap: (List<Entity> list) {
  //             BlocProvider.of<PayRateCubit>(
  //                 context)
  //                 .updateDropdownValues(
  //               entities: list);
  //             BlocProvider.of<PayRateCubit>(context).getEntityData(list);
  //           },
  //         );
  //       });
  // }

  Widget datepickerWidgetLoading({
    required TextEditingController textfiled,
    bool isDisabled = false,
    required Function onChange,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          datePickerDialog(textfiled);
        }
      },
      child: FlutterInputField(
        textFieldController: textfiled,
        textFormKey: textfiled == textfiled
            ? Keys.founddateTextController
            : Keys.handedoverdateTextController,
        hintText: '',
        isEnable: !isDisabled,
        isDisableColor: isDisabled,
        onChange: onChange,
        validateTextField: (String? user) {},
        suffixWidget: GestureDetector(
          onTap: () async {
            if (textfiled.text.isEmpty) {
              datePickerDialog(textfiled);
              // state.materialMovement.tak
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              AppIcon.calendaricon,
              color: AppColors.textgreyThemecolor,
              width: 20,
              key: const Key(Keys.userIcon),
            ),
          ),
        ),
      ),
    );
  }

  datePickerDialog(TextEditingController textfield) async {
    DateTime? pickedDate = await showDateTimePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    String formattedDate = DateFormat(Constants.fulldateFormat)
        .format(pickedDate ?? DateTime.now());
    //you can implement different kind of Date Format here according to your requirement
    takenOutOnDateController.text = formattedDate;
    setState(() {
      // dateinput.text = formattedDate; //set output date to TextField value.
    });
  }

  Widget cancelButtonDisplay() {
    return AppButton(
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

  Widget submitButtonDisplay({required Function onTap}) {
    return AppButton(
      width: 150,
      key: const Key(Keys.submitButton),
      buttonText: Constants.next,
      buttonTextKey: Keys.submitButton,
      onTap: onTap,
    );
  }

  Widget locationWidgetdislay(PayRateState state) {
    return GestureDetector(
      onTap: () {
        if (widget.rate == null || (state.rate.location?.name ?? '').isEmpty) {
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
                  state.rate.location = location;

                  BlocProvider.of<PayRateCubit>(context)
                      .updateDropdownValues(location: location);

                  // state.copyWith(
                  //   materialMovement: state.materialMovement,
                  // );
                  // log('--state.materialMovement.location-----${state.materialMovement.location?.name}---');

                  // TODO: Need to check this setState
                  // May be calling SlNo. API and then setting the state
                  // setState(() {});

                  // await lawenforcementCubit.getSerialnumberDetails(
                  //     list?.id.toString() ?? '', 'AF');
                  // // locationselectedText = list?.name ?? '';
                  // // locationSelectedlist = list;
                  // lawenforcementCubit.getlocationsResponseData(list);
                },
              );
            },
          );
        }
      },
      child: SelectedTileValueWidget(name: state.rate.location?.name ?? ''),
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
}
