import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_circular_loader.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/models/rates_response.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common_widgets/base_widget/base_department_dialog.dart';
import '../../../../../common_widgets/base_widget/base_entities_dropdown.dart';
import '../../../../../common_widgets/basic_reusable_widgets.dart';
import '../../../../../enums/form_status.dart';
import '../../../../../models/organisation.dart';
import '../../../../../routing/router.dart';
import '../../../../../utils/app_themes/styles/app_styles.dart';

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
  TextEditingController returnableTextController = TextEditingController();
  TextEditingController takenOutOnDateController = TextEditingController();
  TextEditingController expectedDateOfReturnController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PayRateCubit>(context).initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return BlocConsumer<PayRateCubit, PayRateState>(
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          Utils.dynamicAlert(context, state.message ?? '', 'Guard Rates', '');
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
            showSaveButton: false,
          ),
          backgroundColor: AppColors.backgroundWhitecolor,
          body: getBody(context, state, height),
        );
      },
    ); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  getBody(BuildContext context, PayRateState state, height) {
    log('--status--${state.status}--#####--');

    if (state.status == FormStatus.loading) {
      return const BaseLoader();
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
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(children: [
                        CommonWidgets.verticalSpacerWidget(height * 0.02),

                        /// Created By
                        Row(
                          children: [
                            Row(
                              children: [
                                CommonWidgets.verticalTextHandling(
                                    Constants.createdby,
                                    '${state.loggedInUserDetails?.firstName ?? ''} ${state.loggedInUserDetails?.lastName ?? ''}'),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ],
                            ),
                            const Spacer(),
                            const Text('1/6'),
                          ],
                        ),

                        /// Location
                        CommonWidgets.textDisplay(
                            Constants.location,isMandatory: true, Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        locationWidgetdislay(state),

                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Date of creation
                        CommonWidgets.textDisplay(
                            Constants.dateofcreation,isMandatory: true, Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        datecreateWidgetdisplay(state.model.inputDate ?? ''),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Sl No.
                        CommonWidgets.horizentaltextHandling(
                            Constants.slno,isMandatory: true, state.model.slNo ?? ''),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Entity
                        CommonWidgets.textDisplay(
                          Constants.entity,isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        BaseEntitiesSelection().entityDropDownSelection(
                          context: context,
                          selectedValues: state.model.entities ?? [],
                          all: state.listOfEntities ?? [],
                          onTap: (List<Organisation> selectedEntities) {
                            log('--selectedEntities----${selectedEntities.length}');
                            BlocProvider.of<PayRateCubit>(context)
                                .updateDropdownValues(entities: selectedEntities);
                            Navigator.of(context).pop(); // Close the dialog
                          }
                        ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Vendor
                        CommonWidgets.textDisplay(
                          Constants.vendor,isMandatory: true,
                          Styles.textStyleBlack14,
                        ),
                        widget.rate == null
                            ? FlutterInputField(
                                initialValue: state.model.vendor?.name,
                                textFormKey: Keys.vendorDepartmentKey,
                                hintText: '',
                                isEnable: true,
                                isDisableColor: false,
                                onChange: (String value) {},
                                validateTextField: (String? user) {},
                              )
                            : TextfieldAddButton(
                                title: state.model.vendor?.name,
                                height: 60,
                                isDisableColor: false,
                                onTap: () {
                                  BaseDepartmentDialog().departmentDialog(
                                    context: context,
                                    departments: state.departments,
                                    onTap: (Organisation department) {
                                      BlocProvider.of<
                                          PayRateCubit>(
                                          context)
                                          .updateDropdownValues(
                                          vendor: department);
                                    },
                                  );
                                },
                              ),

                        // quantityUnitPopUp(state),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),
                      ]),
                    ),
                    CommonWidgets.verticalSpacerWidget(height * 0.01),
                    CommonWidgets.verticalSpacerWidget(height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cancelButtonDisplay(),
                        submitButtonDisplay(
                          onTap: () {
                            log('-onTapSubmit--${state.model.vendor?.name}----');
                            FocusScope.of(context).unfocus();
                            BlocProvider.of<PayRateCubit>(context).onSave(
                              isSubmit: false,
                            );

                            // BlocProvider.of<PayRateCubit>(context)
                            //     .onModelValueChange(state.);

                            Navigator.pushReplacementNamed(
                              context,
                              payRateRoute,
                              arguments: {
                                "payRates": state.model.securityGuardRates,
                                "gmRate": state.model,
                                "title": Constants.createSecurityGuard,
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
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
        if (widget.rate == null || (state.model.location?.name ?? '').isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              // print(state.getLocationsResponse);
              return CustomExpansionListTexts(
                locationList: state.locations,
                onTap: (Organisation? list) async {
                  Organisation location = Organisation();
                  location.id = list?.id;
                  location.name = list?.name;
                  state.model.location = location;

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
      child: SelectedTileValueWidget(name: state.model.location?.name ?? ''),
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
