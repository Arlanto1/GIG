import 'package:db_atom/index.dart';
import 'package:db_atom/src/features/material_movement/models/approval_model.dart';
import '../bloc/material_movement_bloc.dart';


class MaterialApproveRejectPopUp extends StatefulWidget {
  const MaterialApproveRejectPopUp({
    super.key,
    required this.title,
    required this.onSubmit,
    required this.model,
    required this.mainContext,
    this.extraProperties,
  });

  final String title;
  final Function onSubmit;
  final ApprovalModel model;
  final BuildContext mainContext;
  final ExtraProperties? extraProperties;

  @override
  State<MaterialApproveRejectPopUp> createState() => MaterialApproveRejectPopUpState();
}

class MaterialApproveRejectPopUpState extends State<MaterialApproveRejectPopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController rejectionCommentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController requestorController = TextEditingController();
  TextEditingController gatePassController = TextEditingController();
  TextEditingController approveRejectController = TextEditingController();

  bool isReadOnly = false;
  @override
  void initState() {
    super.initState();
    if (widget.model.apStepId != null) {
      if (widget.model.decision != null) {
        final selected = approveReject.firstWhere(
              (e) => e.value == widget.model.decision.toString(),
          orElse: () => const Label(key: '', value: ''),
        );

        approveRejectController.text = selected.key;
      }
      // approveRejectController.text = widget.model.decision!=null?
      //     widget.model.decision.toString() :'';
      rejectionCommentController.text = widget.model.reasonForRejection ?? '';
      locationController.text = widget.model.location ?? '';
      requestorController.text = widget.model.requestor ??'';
      gatePassController.text = widget.model.gatePassApprovers??'';
    }
  }

  @override
  Widget build(BuildContext context) {
    // MaterialItemsState state = const MaterialItemsState();
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: Styles.textFontSet(18, AppColors.white,
              FontWeight.normal, Constants.customFontSemiBoldFamily),
        ),
      ),
      backgroundColor: AppColors.blue.withValues(alpha: 0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return SizedBox(
          height: height / 1.8,
          width: width,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

                      /// Decision
                      CommonWidgets.textDisplay(
                        'Decision',
                        Styles.textStyleWhite14,
                      ),

                      BaseDropDown().getDropDown(
                        isDisabled: false,
                        textController:
                        approveRejectController,
                        items: workShift,
                        onTap: () {
                          BaseDropDown().assetTypeDialog(
                            context: context,
                            dropDownValues: approveReject
                                .map((e) => e.key)
                                .toList(),
                            onTap: (value) {
                              final selected = approveReject.firstWhere(
                                    (e) => e.key == value,
                                orElse: () =>
                                const Label(key: '', value: ''),
                              );
                              setState(() {
                              approveRejectController.text =
                                  selected.key;
                              widget.model.decision =
                                  int.tryParse(selected.value);

                              });
                            },
                          );
                        },
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Gate Pass Approvers
                      CommonWidgets.textDisplay(
                        'Gate Pass Approvers',
                        Styles.textStyleWhite16,
                      ),

                      FlutterInputField(
                        textInputType: TextInputType.text,
                        controller: gatePassController,
                        // initialValue:
                        // widget.model.gatePassApprovers,
                        textFormKey: Keys.poNumberKey,
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (value) {
                        }, hintText: '',
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Requestor
                      CommonWidgets.textDisplay(
                        'Requestor',
                        Styles.textStyleWhite16,
                      ),

                      FlutterInputField(
                        textInputType: TextInputType.text,
                        controller: requestorController,
                        // initialValue:
                        // widget.model.requestor,
                        textFormKey: Keys.poNumberKey,
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (value) {
                        }, hintText: '',
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      /// Location
                      CommonWidgets.textDisplay(
                        'Location',
                        Styles.textStyleWhite16,
                      ),
                      FlutterInputField(
                        textInputType: TextInputType.text,
                        // initialValue:
                        // widget.model.location,
                        controller: locationController,
                        textFormKey: Keys.poNumberKey,
                        isEnable: false,
                        isDisableColor: true,
                        onChange: (value) {
                        },
                        hintText: '',
                      ),

                      CommonWidgets.verticalSpacerWidget(height * 0.02),

                      if(widget.model.decision == 0)...[
                      ///Rejection Comment
                      CommonWidgets.textDisplay(
                        Constants.rejectionComment,
                        isMandatory: true,
                        Styles.textStyleWhite14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),

                      FlutterInputField(
                        controller: rejectionCommentController,
                        textInputType: TextInputType.text,
                        textFormKey: Keys.visitorsNameKey,
                        hintText: '',
                        isEnable:  true,
                        isDisableColor:  false,
                        onChange: (String value) {
                          widget.model.reasonForRejection = value;
                          rejectionCommentController.text = value;
                          // BlocProvider.of<PayRateCubit>(widget.mainContext)
                          //     .onModelValueChange(widget.payRate);
                        },
                        validateTextField: (String? user) {},
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
],
                      CommonWidgets.verticalSpacerWidget(height * 0.03),
                      buttonViews(widget.mainContext, width),
                      CommonWidgets.verticalSpacerWidget(height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        cancelButton(width),
          saveButton(width, widget.onSubmit)
      ],
    );
  }

  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textGreyThemeColor,
      textStyle: Styles.styleHeaderGreyText16,
      backgroundColor: AppColors.white,
      boarderColor: AppColors.textGreyThemeColor,
      onTap: () {
        //loginFormKey.currentState!.validate();
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width, Function onSubmit) {
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      boarderColor: AppColors.navigationSkyBlueColor,
      backgroundColor: AppColors.navigationSkyBlueColor,
      foregroundColor: Colors.white,
      textStyle: Styles.textStyleSemiBold16White,
      onTap: () {
        if (!isFormValid.status) {
          Validator().showToast(
            context,
            isFormValid.message,
          );
          return;
        }
        onSubmit(widget.model);
        context.read<MaterialMovementBloc>().add(const RefreshList());
        Navigator.pop(context);
      },
    );
  }

  ErrorResponse get isFormValid {
    return const ErrorResponse(status: true, message: 'Form is Valid');
  }
}
