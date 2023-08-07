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
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/analyst_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/company_type_model.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class CustomListTexts extends StatefulWidget {
  CustomListTexts(
      {super.key,
      this.imagename,
      this.duplicateemployeeDepartments,
      this.duplicatearticleList,
      this.onTap,
      this.duplicatedepostorList,
      this.onLeftButtonTap,
      this.leftimagename,
      this.duplicateentityList,
      this.duplicateleodepartments,
      this.duplicateleopurposevisits,
      this.duplicateloadGroups,
      this.duplicateatomCompanyTypes,
      this.duplicatedayPassReason,
      this.duplicatet1Analyst});
  final String? imagename;
  List<EmployeeDepartment>? duplicateemployeeDepartments;
  List<ArticleList>? duplicatearticleList;
  List<AtomEntity>? duplicateentityList;
  List<AtomStaticUser>? duplicatedepostorList;
  List<AtomLeoDepartment>? duplicateleodepartments;
  List<AtomLeoPurposeVisit>? duplicateleopurposevisits;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftimagename;
  List<DistributionGroup>? duplicateloadGroups;
  List<AtomCompanyType>? duplicateatomCompanyTypes;
  List<DayPassReasonElement>? duplicatedayPassReason;
  List<T1Analyst>? duplicatet1Analyst;
  @override
  State<CustomListTexts> createState() => CustomListTextsState();
}

class CustomListTextsState extends State<CustomListTexts> {
  final _formKey = GlobalKey<FormState>();
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  List<EmployeeDepartment> employeeDepartments = [];
  List<ArticleList> articleList = [];
  List<AtomEntity> entityList = [];
  List<AtomStaticUser> depostorList = [];
  List<AtomLeoDepartment> leodepartments = [];
  List<AtomLeoPurposeVisit> leopurposevisits = [];
  List<DistributionGroup> loadGroups = [];
  List<AtomCompanyType> companyTypes = [];
  List<DayPassReasonElement> dayPassReason = [];
  List<T1Analyst> t1analysts = [];

  // List<ArticleList>? articleList;
  // List<AtomEntity>? entityList;
  // List<AtomStaticUser>? depostorList;
  // List<AtomLeoDepartment>? leodepartments;
  // List<AtomLeoPurposeVisit>? leopurposevisits;
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
          height: height/2,
          width: width - 40,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SingleChildScrollView(
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
    if (widget.duplicateemployeeDepartments != null) {
      employeeDepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateemployeeDepartments!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          employeeDepartments.add(userDetail);
        }
      });
    } else if (widget.duplicatearticleList != null) {
      articleList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicatearticleList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          articleList.add(userDetail);
        }
      });
    } else if (widget.duplicatedepostorList != null) {
      depostorList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicatedepostorList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          depostorList.add(userDetail);
        }
      });
    } else if (widget.duplicateentityList != null) {
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
    } else if (widget.duplicateleodepartments != null) {
      leodepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateleodepartments!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leodepartments.add(userDetail);
        }
      });
    } else if (widget.duplicateleopurposevisits != null) {
      leopurposevisits.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateleopurposevisits!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leopurposevisits.add(userDetail);
        }
      });
    }

    else if (widget.duplicateloadGroups != null) {
      loadGroups.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateloadGroups!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          loadGroups.add(userDetail);
        }
      });
    }

     else if (widget.duplicateatomCompanyTypes != null) {
      companyTypes.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateatomCompanyTypes!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          companyTypes.add(userDetail);
        }
      });
    }
    else if (widget.duplicatedayPassReason != null) {
      dayPassReason.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicatedayPassReason!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          dayPassReason.add(userDetail);
        }
      });
    }
    else if (widget.duplicatet1Analyst != null) {
      t1analysts.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicatet1Analyst!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          t1analysts.add(userDetail);
        }
      });
    }

    setState(() {});
  }

  Widget setupAlertDialoadContainer(double height, double width) {
    if (((widget.duplicatearticleList != null &&
                widget.duplicatearticleList!.isEmpty) ||
            (widget.duplicatearticleList != null &&
                _searchCtrl.text.length > 0 &&
                articleList.isEmpty)) ||
        ((widget.duplicateemployeeDepartments != null &&
                widget.duplicateemployeeDepartments!.isEmpty) ||
            (widget.duplicateemployeeDepartments != null &&
                _searchCtrl.text.length > 0 &&
                employeeDepartments.isEmpty)) ||
        ((widget.duplicatedepostorList != null &&
                widget.duplicatedepostorList!.isEmpty) ||
            (widget.duplicatedepostorList != null &&
                _searchCtrl.text.length > 0 &&
                depostorList.isEmpty)) ||
        ((widget.duplicateentityList != null &&
                widget.duplicateentityList!.isEmpty) ||
            (widget.duplicateentityList != null &&
                _searchCtrl.text.length > 0 &&
                entityList.isEmpty)) ||
        ((widget.duplicateleodepartments != null &&
                widget.duplicateleodepartments!.isEmpty) ||
            (widget.duplicateleodepartments != null &&
                _searchCtrl.text.length > 0 &&
                leodepartments.isEmpty)) ||
        ((widget.duplicateleopurposevisits != null &&
                widget.duplicateleopurposevisits!.isEmpty) ||
            (widget.duplicateleopurposevisits != null &&
                _searchCtrl.text.length > 0 &&
                leopurposevisits.isEmpty) || (widget.duplicateloadGroups != null &&
                _searchCtrl.text.length > 0 &&
                loadGroups.isEmpty) || (widget.duplicateatomCompanyTypes != null &&
                _searchCtrl.text.length > 0 &&
                companyTypes.isEmpty) || (widget.duplicatedayPassReason != null &&
                _searchCtrl.text.length > 0 &&
                dayPassReason.isEmpty) || (widget.duplicatet1Analyst != null &&
                _searchCtrl.text.length > 0 &&
                t1analysts.isEmpty))) {
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
        //padding: const EdgeInsets.all(0),
       // height: height, // Change as per your requirement
        // width: width- 50, // Change as per your requirement
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.duplicateemployeeDepartments != null
              ? (_searchCtrl.text.length > 0 && employeeDepartments.isNotEmpty)
                  ? employeeDepartments.length
                  : widget.duplicateemployeeDepartments?.length
              : (
                widget.duplicatet1Analyst != null
                  ? (_searchCtrl.text.length > 0 && t1analysts.isNotEmpty)
                      ? t1analysts.length
                      : widget.duplicatet1Analyst?.length
                : widget.duplicatedayPassReason != null
                  ? (_searchCtrl.text.length > 0 && dayPassReason.isNotEmpty)
                      ? dayPassReason.length
                      : widget.duplicatedayPassReason?.length :
              widget.duplicateatomCompanyTypes != null
                  ? (_searchCtrl.text.length > 0 && companyTypes.isNotEmpty)
                      ? companyTypes.length
                      : widget.duplicateatomCompanyTypes?.length
              : widget.duplicatearticleList != null
                  ? (_searchCtrl.text.length > 0 && articleList.isNotEmpty)
                      ? articleList.length
                      : widget.duplicatearticleList?.length
                  : widget.duplicatedepostorList != null
                      ? (_searchCtrl.text.length > 0 && depostorList.isNotEmpty)
                          ? depostorList.length
                          : widget.duplicatedepostorList?.length
                      : widget.duplicateentityList != null
                          ? (_searchCtrl.text.length > 0 &&
                                  entityList.isNotEmpty)
                              ? entityList.length
                              : widget.duplicateentityList?.length
                          : widget.duplicateleodepartments != null
                              ? (_searchCtrl.text.length > 0 &&
                                      leodepartments.isNotEmpty)
                                  ? leodepartments.length
                                  : widget.duplicateleodepartments?.length
                              :  widget.duplicateleopurposevisits != null ? (_searchCtrl.text.length > 0 &&
                                      leopurposevisits.isNotEmpty)
                                  ? leopurposevisits.length
                                  : widget.duplicateleopurposevisits?.length :(_searchCtrl.text.length > 0 &&
                                      loadGroups.isNotEmpty)
                                  ? loadGroups.length
                                  : widget.duplicateloadGroups?.length ),
          itemBuilder: (BuildContext context, int index) {
            if (widget.duplicateemployeeDepartments != null) {
              EmployeeDepartment? drawerItem;
              if ((_searchCtrl.text.length > 0 &&
                  employeeDepartments.isNotEmpty)) {
                drawerItem = employeeDepartments[index];
              } else {
                drawerItem = widget.duplicateemployeeDepartments?[index];
              }

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
            } else if (widget.duplicatearticleList != null) {
              ArticleList? articleItem;
              if ((_searchCtrl.text.length > 0 && articleList.isNotEmpty)) {
                articleItem = articleList[index];
              } else {
                articleItem = widget.duplicatearticleList?[index];
              }
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
            } else if (widget.duplicatedepostorList != null) {
              AtomStaticUser? articleItem;
              if ((_searchCtrl.text.length > 0 && depostorList.isNotEmpty)) {
                articleItem = depostorList[index];
              } else {
                articleItem = widget.duplicatedepostorList?[index];
              }
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
            } else if (widget.duplicateentityList != null) {
              AtomEntity? articleItem;
              if ((_searchCtrl.text.length > 0 && entityList.isNotEmpty)) {
                articleItem = entityList[index];
              } else {
                articleItem = widget.duplicateentityList?[index];
              }
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
            } else if (widget.duplicateleopurposevisits != null) {
              AtomLeoPurposeVisit? articleItem;
              if ((_searchCtrl.text.length > 0 &&
                  leopurposevisits.isNotEmpty)) {
                articleItem = leopurposevisits[index];
              } else {
                articleItem = widget.duplicateleopurposevisits?[index];
              }
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
            } else if (widget.duplicateleodepartments != null) {
              AtomLeoDepartment? articleItem;
              if ((_searchCtrl.text.length > 0 && leodepartments.isNotEmpty)) {
                articleItem = leodepartments[index];
              } else {
                articleItem = widget.duplicateleodepartments?[index];
              }
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
            }
            else if (widget.duplicateloadGroups != null) {
              DistributionGroup? articleItem;
              if ((_searchCtrl.text.length > 0 && loadGroups.isNotEmpty)) {
                articleItem = loadGroups[index];
              } else {
                articleItem = widget.duplicateloadGroups?[index];
              }
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
            }
            else if (widget.duplicateatomCompanyTypes != null) {
              AtomCompanyType? articleItem;
              if ((_searchCtrl.text.length > 0 && companyTypes.isNotEmpty)) {
                articleItem = companyTypes[index];
              } else {
                articleItem = widget.duplicateatomCompanyTypes?[index];
              }
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
            }
            else if (widget.duplicatedayPassReason != null) {
              DayPassReasonElement? articleItem;
              if ((_searchCtrl.text.length > 0 && companyTypes.isNotEmpty)) {
                articleItem = dayPassReason[index];
              } else {
                articleItem = widget.duplicatedayPassReason?[index];
              }
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
            }
             else if (widget.duplicatet1Analyst != null) {
              T1Analyst? articleItem;
              if ((_searchCtrl.text.length > 0 && companyTypes.isNotEmpty)) {
                articleItem = t1analysts[index];
              } else {
                articleItem = widget.duplicatet1Analyst?[index];
              }
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
            }
            
          },
        ),
      );
    }
  }
}
