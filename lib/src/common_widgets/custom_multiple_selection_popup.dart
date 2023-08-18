import 'dart:ffi';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/views/found_list_item.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/emplyee_departments_model.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/createfound/models/get_depositor_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/addentities.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class CustomMultipleSelectionListTexts extends StatefulWidget {
  CustomMultipleSelectionListTexts({
    super.key,
    this.imagename,
    this.onTap,
    this.onLeftButtonTap,
    this.leftimagename,
    this.duplicateentityList,
  });
  final String? imagename;

  List<AtomEntity>? duplicateentityList;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftimagename;
  @override
  State<CustomMultipleSelectionListTexts> createState() =>
      CustomMultipleSelectionListTextsState();
}

class CustomMultipleSelectionListTextsState
    extends State<CustomMultipleSelectionListTexts> {
  final _formKey = GlobalKey<FormState>();
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  var selectedListindexes = [];

  List<AtomEntity> entityList = [];
  List<AtomEntity> selectentityList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // employeeDepartments = widget.duplicateemployeeDepartments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;

    return AlertDialog(
      icon:
          // widget.leftimagename != null
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //             GestureDetector(
          //                 onTap: () {
          //                   widget.onLeftButtonTap != null
          //                       ? widget.onLeftButtonTap!()
          //                       : null;
          //                 },
          //                 child: SvgPicture.asset(
          //                   widget.leftimagename ?? '',
          //                   color: AppColors.navigationSkybluecolor,
          //                 ) //Icon(Icons.cancel)
          //                 ),
          //             GestureDetector(
          //                 onTap: () {
          //                   Navigator.of(context).pop();
          //                 },
          //                 child: SvgPicture.asset(
          //                     AppIcon.closeicon) //Icon(Icons.cancel)
          //                 ),
          //           ])
          //:
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                          AppIcon.closeicon) //Icon(Icons.cancel)
                      ),
                  SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        widget.onLeftButtonTap != null
                            ? widget.onLeftButtonTap!()
                            : null;
                      },
                      child: SvgPicture.asset(
                        widget.leftimagename ?? '',
                        color: AppColors.navigationSkybluecolor,
                      ) //Icon(Icons.cancel)
                      ),
                ]),
            GestureDetector(
              onTap: () {
                //lawenforcementValidations(context, globalState);
                widget.onTap!(selectentityList);
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.send,
                color: AppColors.navigationSkybluecolor,
              ),
            ),
          ]),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          height: height / 2,
          width: width - 40,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // (widget.articleList != null && widget.articleList!.isNotEmpty) ||
                  //         (widget.duplicateemployeeDepartments != null &&
                  //             widget.duplicateemployeeDepartments!.isNotEmpty) ||
                  //         (widget.depostorList != null &&
                  //             widget.depostorList!.isNotEmpty)
                  //  ?
                  searchWidget(),
                  //  : Container(),
                  setupAlertDialoadContainer(height, width),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

// Search Widget
  Widget searchWidget() {
    return SearchWidget(
      controller: _searchCtrl,
      hintText: Constants.searchHintText,
      textInputFieldKey: Keys.searchInputField,
      leadingIcon: AppIcon.searchIcon,
      border: borderColor,
      isEnabled: false,
      // suffixIcon: _searchCtrl.text.length >  0 ? Conatiner()  :SizedBox(width: 0,),
      onChange: (String txt) {
        filterText(txt);
      },
      focusChange: (bool focus) {
        if (focus) {
          borderColor = AppColors.navigationSkybluecolor;
        } else {
          borderColor = AppColors.textgreyThemecolor;
        }
        setState(() {});
      },
      onSubmit: (String txt) {
        filterText(txt);
      },
    );
  }

  filterText(String txt) {
    //  if (txt.trim().length >= 15) {
    //     } else {
    //       //Show error message for validations
    //     }
    //_searchCtrl.text = txt;
    onSearchTextChanged(txt);
  }

  onSearchTextChanged(String text) async {
    if (widget.duplicateentityList != null) {
      entityList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateentityList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          entityList.add(userDetail);
        }
      });
    }

    setState(() {});
  }

  Widget setupAlertDialoadContainer(double height, double width) {
    if ((widget.duplicateentityList != null &&
            widget.duplicateentityList!.isEmpty) ||
        (widget.duplicateentityList != null &&
            _searchCtrl.text.length > 0 &&
            entityList.isEmpty)) {
      return //const Expanded(
          // child:
          Center(
        child: Text(
          Constants.nodata,
          style: Styles.textStyleRegularGrey16,
          // ),
        ),
      );
    } else {
      return Container(
        //padding: const EdgeInsets.all(20),
       // height: height / 1.6, // Change as per your requirement
        // width: width- 50, // Change as per your requirement
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.duplicateentityList != null
              ? (_searchCtrl.text.length > 0 && entityList.isNotEmpty)
                  ? entityList.length
                  : widget.duplicateentityList?.length
              : widget.duplicateentityList?.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.duplicateentityList != null) {
              AtomEntity? articleItem;
              if ((_searchCtrl.text.length > 0 && entityList.isNotEmpty)) {
                articleItem = entityList[index];
              } else {
                articleItem = widget.duplicateentityList?[index];
              }
              return ListTile(
                  onTap: () {
                    //widget.onTap!(articleItem);
                    // Navigator.of(context).pop();

                    if (selectedListindexes.contains(index)) {
                      selectedListindexes.remove(index);

                      AtomEntity? articleItem1 =
                          widget.duplicateentityList?[index];
                      selectentityList.removeWhere(
                          (item) => item.id == (articleItem1?.id ?? 0));
                    } else {
                      selectedListindexes.add(index);
                      selectentityList.add(articleItem!);
                    }

                    setState(() {});
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imagename != null && widget.imagename != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: VisualDensity(vertical: 0), // to expand
                  leading: (widget.imagename != null && widget.imagename != '')
                      ? SvgPicture.asset(
                          //AppIcon.dropdownicon,
                          AppIcon.apple,
                          //fit: BoxFit.,
                          //color: AppColors.textColor,
                          width: 20,
                          height: 20,
                        )
                      : const SizedBox.shrink(),
                  title: Align(
                    alignment: Alignment.topLeft,
                    child: Text(articleItem?.name ?? '',
                        //style: Styles.textStyleRegularGrey16,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.customFontRegularFamily,
                            fontWeight: FontWeight.w600,
                            color: selectedListindexes.contains(index)
                                ? AppColors.navigationSkybluecolor
                                : AppColors.textgreyThemecolor)),
                  ));
            }
          },
        ),
      );
    }
  }
}
