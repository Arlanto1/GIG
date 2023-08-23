import 'dart:developer';

import 'package:db_atom/src/common_widgets/app_button.dart';
import 'package:db_atom/src/common_widgets/base_widget/add_button_widget.dart';
import 'package:db_atom/src/common_widgets/base_widget/base_app_bar.dart';
import 'package:db_atom/src/common_widgets/base_widget/department_dialog.dart';
import 'package:db_atom/src/common_widgets/base_widget/radio_buttons_yes_no.dart';
import 'package:db_atom/src/common_widgets/base_widget/selected_tile_value_widget.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/custom_list_expansion_pop_up.dart';
import 'package:db_atom/src/common_widgets/custom_pop_list_texts.dart';
import 'package:db_atom/src/common_widgets/custom_simple_list_texts.dart';
import 'package:db_atom/src/common_widgets/image_download.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/textfiled_addbutton.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/add_employee_deparment.dart';
import 'package:db_atom/src/features/createfound/views/upload_attachment.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_rate/guarding_rate_details/pay_rates/cubits/pay_rate_cubit.dart';
import 'package:db_atom/src/features/law_enforcement_list/models/law_enforcement_details.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/material_movement/models/material_movements_model.dart';
import 'package:db_atom/src/features/material_movement/models/quantity_units.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/util.dart';
import 'package:db_atom/src/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../common_widgets/date_time_picker.dart';
import '../../../../../models/base_user.dart';
import '../../../../../models/department.dart';
import '../../../../../models/entry_security.dart';

class RatesInfo extends StatefulWidget {
  final MaterialMovementModel? materialMovement;
  final String title;

  const RatesInfo({
    super.key,
    this.materialMovement,
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
    BlocProvider.of<MaterialMovementDetailsCubit>(context).initializeValues();
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
            BlocProvider.of<MaterialMovementDetailsCubit>(context)
                .submitForm(isSaveOnly: true);
          },
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButtonDisplay(),
            // TODO: Need to remove this InkWell as Navigation will be handled via Bloc Listener
            InkWell(onTap: (){


            },child: submitButtonDisplay()),
          ],
        ),
        backgroundColor: AppColors.backgroundWhitecolor,
        body: BlocConsumer<PayRateCubit,
            PayRateState>(
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

            if (state.status == FormStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            log('--status-2-builder--${state.status}----');


            log('-slno- ${state.rate.slNo}---');

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
                                            state.loggedInUserDetails?.name ?? ''),
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
                                    Constants.slno,
                                    state.rate.slNo ?? ''),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Entity
                                CommonWidgets.textDisplay(
                                  Constants.entity,
                                  Styles.textStyleBlack14,
                                ),
                                // widget.materialMovement != null
                                    // ? FlutterInputField(
                                    //     initialValue: state.rate
                                    //         .entities?.name,
                                    //     textFormKey:
                                    //         Keys.preparedByDepartmentKey,
                                    //     hintText: '',
                                    //     isEnable:
                                    //         true,
                                    //     isDisableColor:
                                    //         false,
                                    //     onChange: (String value) {},
                                    //     validateTextField: (String? user) {},
                                    //   )
                                    // : TextfieldAddButton(
                                    //     title: state.rate
                                    //         .entities?.name,
                                    //     height: 60,
                                    //     isDisableColor:
                                    //         widget.materialMovement == null
                                    //             ? false
                                    //             : true,
                                    //     onTap: () {
                                    //       if (widget.materialMovement == null) {
                                    //         BaseDialog().departmentDialog(
                                    //           context: context,
                                    //           departments: state.departments,
                                    //           onTap: (Department department) {
                                    //             BlocProvider.of<
                                    //                         MaterialMovementDetailsCubit>(
                                    //                     context)
                                    //                 .updateDropdownValues(
                                    //                     preparedByDepartment:
                                    //                         department);
                                    //           },
                                    //         );
                                    //         // leodepartmentsDialog(state);
                                    //       }
                                    //     },
                                    //   ),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),

                                /// Vendor
                                CommonWidgets.textDisplay(
                                  Constants.vendor,
                                  Styles.textStyleBlack14,
                                ),
                                widget.materialMovement != null
                                    ? FlutterInputField(
                                        initialValue: state.rate
                                            .vendor?.name,
                                        textFormKey:
                                            Keys.preparedByDepartmentKey,
                                        hintText: '',
                                        isEnable:
                                            true,
                                        isDisableColor:
                                            false,
                                        onChange: (String value) {},
                                        validateTextField: (String? user) {},
                                      )
                                    : TextfieldAddButton(
                                        title: state.rate
                                            .vendor?.name,
                                        height: 60,
                                        isDisableColor:
                                            widget.materialMovement == null
                                                ? false
                                                : true,
                                        onTap: () {
                                          if (widget.materialMovement == null) {
                                            BaseDialog().departmentDialog(
                                              context: context,
                                              departments: state.departments,
                                              onTap: (Department department) {
                                                BlocProvider.of<
                                                            MaterialMovementDetailsCubit>(
                                                        context)
                                                    .updateDropdownValues(
                                                        preparedByDepartment:
                                                            department);
                                              },
                                            );
                                            // leodepartmentsDialog(state);
                                          }
                                        },
                                      ),

                                // quantityUnitPopUp(state),
                                CommonWidgets.verticalSpacerWidget(
                                    height * 0.01),
                              ]),
                            ),
                            CommonWidgets.verticalSpacerWidget(height * 0.01),
                            CommonWidgets.verticalSpacerWidget(height * 0.04),
                          ]),
                    ),
                  ),
                ]),
              ),
            );
          },
        )); //BlocBuilder<CreateFoundArticleCubit, CreateFoundState>(
  }

  String getStatusString(int status) {
    switch (status) {
      case 0:
        return 'Draft';
      case 1:
        return 'Submitted';
      case 2:
        return 'Approved';
      case 3:
        return 'Rejected';
      case 4:
        return 'Outward Waiting';
      case 5:
        return 'Inward Waiting';
      case 6:
        return 'Closed';
      case 7:
        return 'Cancelled';
      default:
        return 'Unknown Status';
    }
  }

  assetTypeDialog(MaterialMovementDetailsState state) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return CustomSimpleListTexts(
            texts: const ["Returnable", "Non Returnable"],
            onTap: (String value) {
              bool isReturnable = value == 'Returnable' ? true : false;
              state.materialMovement.returnable = isReturnable;
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(isReturnable: isReturnable);
            });
      },
    );
  }

  Widget quantityUnitPopUp(MaterialMovementDetailsState state) {
    return TextfieldAddButton(
      title: 'Quantity',
      height: 60,
      isDisableColor: state.materialMovement.quantity == null ? false : true,
      onTap: () {
        if (state.materialMovement.quantity == null) {
          quantityUnitDialog(
              context: context, quantityUnits: state.quantityUnits);
        }
      },
    );
  }

  quantityUnitDialog(
      {required BuildContext context,
      required List<QuantityUnit> quantityUnits}) {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return CustomListTexts(
            duplicateQuantityUnitList: quantityUnits,
            leftimagename: AppIcon.addicon,
            onLeftButtonTap: () {
              Navigator.pop(context);
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AddEmployeeDepartment(
                      title: Constants.addQuantity,
                      // createoundstate:  state,
                    );
                  });
            },
            onTap: (QuantityUnit unit) {
              BlocProvider.of<MaterialMovementDetailsCubit>(context)
                  .updateDropdownValues(quantityUnit: unit);
            },
          );
        });
  }

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
      buttonText: Constants.previous,
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
      buttonText: Constants.next,
      buttonTextKey: Keys.submitButton,
      onTap: () async {
        FocusScope.of(context).unfocus();
        BlocProvider.of<MaterialMovementDetailsCubit>(context).submitForm();
      },
    );
  }

  Widget uploadWidget(MaterialMovementDetailsState state) {
    return widget.materialMovement == null
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
                            userdetails:
                                state.loggedInUserDetails ?? EntrySecurity(),
                            getFiles: getFiles ?? [],
                            inwardState: state,
                            onImageSelected: (CreateImage data) {
                              log('-------function---onImageSelected---------');
                              List<CreateImage>? files = [];
                              files.add(data);
                              for (CreateImage image in getFiles!.toList()) {
                                files.add(image);
                              }
                              BlocProvider.of<MaterialMovementDetailsCubit>(
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
    log('---getAttachments--------${getAttachments?.length}-----');

    return getAttachments != null ||
            getFiles != null ||
            getFiles?.length != 0 ||
            getAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
  }

  Widget getAttachement(MaterialMovementDetailsState state, double height) {
    log('---getAttachments----aaa----${getAttachments?.length}-----');

    return (state.loadAttachments == null ||
            state.loadAttachments!.isEmpty ||
            widget.materialMovement == null)
        ? state.loadAttachments?.length == 0 || getFiles == null
            ? Container()
            : attachmentListviews(getFiles, getAttachments)
        : attachmentListviews(getFiles, getAttachments);
  }

  Widget locationWidgetdislay(PayRateState state) {
    return GestureDetector(
      onTap: () {
        if (widget.materialMovement == null ||
            (state.rate.location?.name ?? '').isEmpty) {
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
      child: SelectedTileValueWidget(
          name: state.rate.location?.name ?? ''),
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
            if (widget.materialMovement != null) {
              imagedata1 = attachmentListviews1?[index];
            } else {
              imagedata = attachmentListviews?[index];
            }

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: widget.materialMovement != null
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
                  title: widget.materialMovement != null
                      ? Text(imagedata1?.title ?? '')
                      : Text(imagedata?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //                           <-- Divider
              ],
            );
          }),
    );
  }
}
