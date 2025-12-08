import 'package:db_atom/index.dart';

class AddDutyPostLocationNamePopUp extends StatefulWidget {
  const AddDutyPostLocationNamePopUp({
    super.key,
    required this.mainContext,
    required this.model,
  });

  final BuildContext mainContext;
  final DutyPostNameMasterModel? model;

  @override
  State<AddDutyPostLocationNamePopUp> createState() =>
      AddDutyPostLocationNamePopUpState();
}

class AddDutyPostLocationNamePopUpState
    extends State<AddDutyPostLocationNamePopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dutyPostLocationNameController =
      TextEditingController();
  bool isTransportShift = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.newColor3.withValues(alpha: 2),
                  AppColors.newColor,
                  AppColors.newColor3.withValues(alpha: 2),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.6),
                width: 0.7,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.0),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SizedBox(
              height: height / 3.8,
              width: width,
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          /// Duty Post Location Name
                          CommonWidgets.textDisplay(
                            Constants.dutyPostLocationName,
                            Styles.textStyleWhite16,
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          FlutterInputField(
                            lineHeight: 1,
                            controller: dutyPostLocationNameController,
                            textFormKey: Keys.equipmentNoKey,
                            hintText: '',
                            isEnable: true,
                            isDisableColor: false,
                            onChange: (String value) {
                              dutyPostLocationNameController.text = value;
                            },
                            validateTextField: (String value) {},
                          ),

                          /// is Transport Shift
                          Row(
                            children: <Widget>[
                              CommonWidgets.textDisplay(
                                Constants.isTransportShift,
                                Styles.textStyleWhite16,
                              ),
                              Checkbox(
                                value: isTransportShift,
                                activeColor: AppColors.black,
                                focusColor: AppColors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isTransportShift = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          CommonWidgets.verticalSpacerWidget(height * 0.01),
                          buttonViews(widget.mainContext, width),
                          CommonWidgets.verticalSpacerWidget(height * 0.02),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  Widget buttonViews(BuildContext context, double width) {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[cancelButton(width), saveButton(width)],
    );
  }

  Widget cancelButton(double width) {
    return AppButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      // foregroundColor: AppColors.white,
      // textStyle: Styles.styleHeaderGreyText16,
      // boarderColor: AppColors.white,
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
    );
  }

  Widget saveButton(double width) {
    return AppButton(
      width: width / 3.5,
      key: const Key(Keys.saveButton),
      buttonText: Constants.save,
      buttonTextKey: Keys.saveButtonText,
      // backgroundColor: AppColors.navigationSkyBlueColor,
      onTap: () {
        DpName dpName = DpName();
        dpName.dutyPostName = dutyPostLocationNameController.text;
        dpName.transportShift = isTransportShift;
        // widget.model?.dpName = dutyPostLocationNameController.text;
        BlocProvider.of<DutyPostNameMasterDetailsCubit>(widget.mainContext)
            .onAddDutyPostLocationName(dpName);
        Navigator.pop(context);
      },
    );
  }
}
