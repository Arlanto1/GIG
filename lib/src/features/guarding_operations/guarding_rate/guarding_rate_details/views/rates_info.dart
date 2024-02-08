import 'dart:developer';

import 'package:db_atom/index.dart';

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
            showSubmitButton: false,
            showDisLikeButton: false,
            showLikeButton: false,
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
                            Constants.location,
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        locationWidgetdislay(state),

                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Date of creation
                        CommonWidgets.textDisplay(
                            Constants.dateofcreation,
                            isMandatory: true,
                            Styles.textStyleBlack14),
                        CommonWidgets.verticalSpacerWidget(height * 0.001),
                        datecreateWidgetdisplay(state.model.inputDate ?? ''),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Sl No.
                        CommonWidgets.horizentaltextHandling(
                            Constants.slno,
                            isMandatory: true,
                            state.model.slNo ?? ''),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Entity
                        CommonWidgets.textDisplay(
                          Constants.entity,
                          isMandatory: true,
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
                                  .updateDropdownValues(
                                      entities: selectedEntities);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          addTitle:'Add Entity',
                          orgName: 'ATOM_ENTITIES',
                          functionToCall: () {
                            // refresh the list
                            BlocProvider.of<PayRateCubit>(
                                context)
                                .refreshList();
                          },
                            ),
                        CommonWidgets.verticalSpacerWidget(height * 0.01),

                        /// Vendor
                        CommonWidgets.textDisplay(
                          Constants.vendor,
                          isMandatory: true,
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
                                  BaseOrganisationDialog().departmentDialog(
                                    context: context,
                                    organisations: state.departments,
                                    onTap: (Organisation department) {
                                      BlocProvider.of<PayRateCubit>(context)
                                          .updateDropdownValues(
                                              vendor: department);
                                    },
                                      orgName: 'ATOM_VENDORS',
                                      createEntity: false,
                                      title: 'Add Vendor',
                                      functionToCall: () {
                                        // refresh the list
                                        BlocProvider.of<
                                            PayRateCubit>(
                                            context)
                                            .refreshList();
                                      }
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
