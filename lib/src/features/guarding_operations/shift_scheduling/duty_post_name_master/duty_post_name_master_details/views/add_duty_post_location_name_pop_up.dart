
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/duty_post_name_master_details/cubits/duty_post_name_master_details_cubit.dart';
import 'package:db_atom/src/features/guarding_operations/shift_scheduling/duty_post_name_master/models/duty_post_name_master_model.dart';

import '../../../../../../../index.dart';


class AddDutyPostLocationNamePopUp extends StatefulWidget {
  const AddDutyPostLocationNamePopUp({
    super.key,
    required this.mainContext,
    required this.model,
  });

  final BuildContext mainContext;
  final DutyPostNameMasterModel? model;

  @override
  State<AddDutyPostLocationNamePopUp> createState() => AddDutyPostLocationNamePopUpState();
}

class AddDutyPostLocationNamePopUpState extends State<AddDutyPostLocationNamePopUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dutyPostLocationNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: height / 4.9,
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
                      ///Duty Post Location Name
                      CommonWidgets.textDisplay(
                        Constants.dutyPostLocationName,
                        Styles.textStyleBlack14,
                      ),
                      CommonWidgets.verticalSpacerWidget(height * 0.01),
                      FlutterInputField(
                        lineHeight: 1,
                        textFieldController: dutyPostLocationNameController,
                        textFormKey: Keys.equipmentNoKey,
                        hintText: '',
                        isEnable: true,
                        isDisableColor: false,
                        onChange: (String value) {
                          dutyPostLocationNameController.text = value;
                        },
                        validateTextField: (String value) {},
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
        );
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
    return PopButton(
      width: width / 3.5,
      key: const Key(Keys.cancelButton),
      buttonText: Constants.cancel,
      buttonTextKey: Keys.cancelButtonText,
      foregroundColor: AppColors.textgreyThemecolor,
      textStyle: Styles.styleHeaderGreyText16,
      boarderColor: AppColors.textgreyThemecolor,
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
      backgroundColor: AppColors.navigationSkybluecolor,
      onTap: () {
        widget.model?.dutyPostLocationName = dutyPostLocationNameController.text;
        BlocProvider.of<DutyPostNameMasterDetailsCubit>(widget.mainContext)
            .onAddDutyPostLocationName(dutyPostLocationNameController.text);
        Navigator.pop(context);
      },
    );
  }
}
