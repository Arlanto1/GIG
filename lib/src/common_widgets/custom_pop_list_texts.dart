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
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class CustomListTexts extends StatefulWidget {
  CustomListTexts(
      {super.key,
      this.imagename,
      this.employeeDepartments,
      this.articleList,
      this.onTap,
      this.depostorList,
      this.onLeftButtonTap,
      this.leftimagename});
  final String? imagename;
  List<EmployeeDepartment>? employeeDepartments;
  List<ArticleList>? articleList;
  List<AtomStaticUser>? depostorList;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftimagename;
  @override
  State<CustomListTexts> createState() => CustomListTextsState();
}

class CustomListTextsState extends State<CustomListTexts> {
  final _formKey = GlobalKey<FormState>();
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    return AlertDialog(
      icon: widget.leftimagename != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                          AppIcon.closeicon) //Icon(Icons.cancel)
                      ),
                ])
          : Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:
                      SvgPicture.asset(AppIcon.closeicon) //Icon(Icons.cancel)
                  )),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          height: height,
          width: width - 40,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // (widget.articleList != null && widget.articleList!.isNotEmpty) ||
              //         (widget.employeeDepartments != null &&
              //             widget.employeeDepartments!.isNotEmpty) ||
              //         (widget.depostorList != null &&
              //             widget.depostorList!.isNotEmpty)
              //     ? searchWidget()
              //     : Container(),
              setupAlertDialoadContainer(height, width),
            ],
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
      focusChange: (bool focus) {
        if (focus) {
          borderColor = AppColors.navigationSkybluecolor;
        } else {
          borderColor = AppColors.textgreyThemecolor;
        }
        setState(() {});
      },
      onSubmit: (String txt) {
        if (txt.trim().length >= 15) {
        } else {
          //Show error message for validations
        }
        _searchCtrl.text = txt;
      },
    );
  }

  Widget setupAlertDialoadContainer(double height, double width) {
    if ((widget.articleList != null && widget.articleList!.isEmpty) ||
        (widget.employeeDepartments != null &&
            widget.employeeDepartments!.isEmpty) ||
        (widget.depostorList != null && widget.depostorList!.isEmpty)) {
      return const Expanded(
        child: Center(
          child: Text(
            Constants.nodata,
            style: Styles.textStyleRegularGrey16,
          ),
        ),
      );
    } else {
      return Container(
        //padding: const EdgeInsets.all(20),
        height: height / 1.6, // Change as per your requirement
        // width: width- 50, // Change as per your requirement
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.employeeDepartments != null
              ? widget.employeeDepartments?.length
              : (widget.articleList != null
                  ? widget.articleList?.length
                  : widget.depostorList?.length),
          itemBuilder: (BuildContext context, int index) {
            if (widget.employeeDepartments != null) {
              EmployeeDepartment? drawerItem =
                  widget.employeeDepartments?[index];
              return ListTile(
                  onTap: () {
                    widget.onTap!(drawerItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imagename != null && widget.imagename != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: VisualDensity(vertical: 0),
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
                    child: Text(
                      drawerItem?.name ?? '',
                      style: Styles.textStyleRegularGrey16,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.articleList != null) {
              ArticleList? articleItem = widget.articleList?[index];
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
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
                    child: Text(
                      articleItem?.name ?? '',
                      style: Styles.textStyleRegularGrey16,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else {
              AtomStaticUser? articleItem = widget.depostorList?[index];
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
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
                    child: Text(
                      //articleItem?.name ?? '',
                      ((articleItem?.name ?? '') +
                          '(' +
                          (articleItem?.email ?? '') +
                          ')'),
                      style: Styles.textStyleRegularGrey16,
                      textAlign: TextAlign.left,
                    ),
                  ));
            }
          },
        ),
      );
    }
  }
}
