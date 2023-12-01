
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class CustomInternationalization extends StatefulWidget {
  const CustomInternationalization({super.key,required this.title,this.count});
  final String title;
  final int? count;

  @override
  State<CustomInternationalization> createState() => CustomInternationalizationState();
}

class CustomInternationalizationState extends State<CustomInternationalization> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController keyTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return AlertDialog(
      title: 
           Align(
             alignment: Alignment.center,
             child: Text(
                widget.title,
                style: Styles.textFontSet(18, AppColors.textgreyThemecolor, FontWeight.normal,
                    Constants.customFontSemiBoldFamily),
              ),
           ),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    content: Builder(
                      builder: (context) {
                         // Get available height and width of the build area of this widget. Make a choice depending on the size.                              
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
                        return SingleChildScrollView(
                          child: SizedBox(
                            height: height/3,
                                  width: width,
                            child: Stack(
                              clipBehavior: Clip.none, children: <Widget>[
                               
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                     
                                CommonWidgets.verticalSpacerWidget(height * 0.01),
                                
                                setuplistContainer(height, width, widget.count ?? 1),
                                
                                 CommonWidgets.verticalSpacerWidget(height * 0.03),
                                  buttonViews(context,width),    
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  );

  }
  Widget setuplistContainer(double height, double width, int count ) {
  return 
  SizedBox(
    //padding: const EdgeInsets.all(20),
   height: height / 4.5, // Change as per your requirement
  // width: width- 50, // Change as per your requirement
 //width: double.maxFinite,
    child: 
    ListView.builder(
      //shrinkWrap: true,
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return  ListTile(
          title: FlutterInputField(
                                  lineHeight: 5,
                                  textFieldController: nameTextController,
                                  textFormKey: Keys.nameTextController,
                                  hintText: '',
                                  onChange: (String username) {
                                    //this.username = username;
                                    setState(() {});
                                  },
                                  validateTextField: (String? user) {},
                                ),
        );
      },
    ),
  );
  }
  Widget buttonViews(BuildContext context, double width) {
    return Container(
      color: AppColors.backgroundWhitecolor,
      child:  Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[cancelButton(width), saveButton(width)],
      ),
    );
  }
  Widget cancelButton(double width) {
    return PopButton(
      width: width / 3.5,
                            key: const Key(Keys.cancelButton),
                            //buttonText: Constants.cancel,
                            imageText: AppIcon.vectoridentify,
                            buttonTextKey: Keys.cancelButtonText,
          foregroundColor: AppColors.textgreyThemecolor,
          textStyle: Styles.styleHeaderGreyText16,
          boarderColor: AppColors.textgreyThemecolor,
                            onTap: () {
                              //loginFormKey.currentState!.validate();
                              FocusScope.of(context).unfocus();
                              try {
                                // final ValidLoginDetails validLoginDetails =
                                //     ValidLoginDetails(userName: username, password: password);
                                // widget.onValidLogin(validLoginDetails);
                                 //Navigator.pushNamed(context, homePageRoute);
                                  Navigator.of(context).pop();
                              } catch (e) {
                                // present userwith error message
                              }
                            },
                          );
  }
  Widget saveButton(double width) {
    return PopButton(
      width: width / 3.5,
                            key: const Key(Keys.saveButton),
                            buttonText: Constants.save,
                            buttonTextKey: Keys.saveButtonText,
                            boarderColor:AppColors.navigationSkybluecolor,
                            backgroundColor: AppColors.navigationSkybluecolor,
          foregroundColor: Colors.white,
          textStyle: Styles.textStyleSemiBold16White,
                            onTap: () {
                              //loginFormKey.currentState!.validate();
                              FocusScope.of(context).unfocus();
                              try {
                                // final ValidLoginDetails validLoginDetails =
                                //     ValidLoginDetails(userName: username, password: password);
                                // widget.onValidLogin(validLoginDetails);
                                 //Navigator.pushNamed(context, homePageRoute);
                              } catch (e) {
                                // present userwith error message
                              }
                            },
                          );
        
  }
}