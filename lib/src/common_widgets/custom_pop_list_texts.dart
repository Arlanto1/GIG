import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/models/get_articletype_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/distribution_model.dart';
import 'package:db_atom/src/features/lawenforcement/models/leodepartments.dart';
import 'package:db_atom/src/features/lawenforcement/models/leopurposevisit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_numbers_list.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/models/day_pass_reason_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

import '../models/base_user.dart';
import '../models/entity.dart';

class CustomListTexts extends StatefulWidget {
  CustomListTexts({
    super.key,
    this.imageName,
    this.duplicateEmployeeDepartments,
    this.duplicateArticleList,
    this.onTap,
    this.duplicateDepostorList,
    this.onLeftButtonTap,
    this.leftImageName,
    this.duplicateEntityList,
    this.duplicateLeoDepartments,
    this.duplicateLeoPurposeVisits,
    this.duplicateloadGroups,
    this.duplicateatomCompanyTypes,
    this.duplicatedayPassReason,
    this.duplicatet1Analyst,
    this.duplicateactivePassInfoList,
    this.duplicateQuantityUnitList,
  });

  final String? imageName;
  List<Organisation>? duplicateEmployeeDepartments;
  List<ArticleList>? duplicateArticleList;
  List<Entity>? duplicateEntityList;
  List<BaseUser>? duplicateDepostorList;
  List<AtomLeoDepartment>? duplicateLeoDepartments;
  List<AtomLeoPurposeVisit>? duplicateLeoPurposeVisits;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;
  List<DistributionGroup>? duplicateloadGroups;
  List<Organisation>? duplicateatomCompanyTypes;
  List<DayPassReasonElement>? duplicatedayPassReason;
  List<BaseUser>? duplicatet1Analyst;
  List<ActivePassInfoList>? duplicateactivePassInfoList;

  List<Organisation>? duplicateQuantityUnitList;

  @override
  State<CustomListTexts> createState() => CustomListTextsState();
}

class CustomListTextsState extends State<CustomListTexts> {
  final _formKey = GlobalKey<FormState>();
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  List<Organisation> employeeDepartments = [];
  List<ArticleList> articleList = [];
  List<Entity> entityList = [];
  List<BaseUser> depostorList = [];
  List<AtomLeoDepartment> leodepartments = [];
  List<AtomLeoPurposeVisit> leopurposevisits = [];
  List<DistributionGroup> loadGroups = [];
  List<Organisation> companyTypes = [];
  List<DayPassReasonElement> dayPassReason = [];
  List<BaseUser> t1analysts = [];
  List<ActivePassInfoList> activePassInfoList = [];
  List<Organisation> quantityUnitList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // employeeDepartments = widget.duplicateemployeeDepartments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: widget.leftImageName != null
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
                        widget.leftImageName ?? '',
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
          height: height / 2,
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
                  setupAlertDialogContainer(height, width),
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
    if (widget.duplicateEmployeeDepartments != null) {
      employeeDepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateEmployeeDepartments!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          employeeDepartments.add(userDetail);
        }
      }
    } else if (widget.duplicateArticleList != null) {
      articleList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateArticleList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          articleList.add(userDetail);
        }
      });
    } else if (widget.duplicateDepostorList != null) {
      depostorList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateDepostorList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          depostorList.add(userDetail);
        }
      });
    } else if (widget.duplicateEntityList != null) {
      entityList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateEntityList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          entityList.add(userDetail);
        }
      });
    } else if (widget.duplicateLeoDepartments != null) {
      leodepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateLeoDepartments!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leodepartments.add(userDetail);
        }
      });
    } else if (widget.duplicateLeoPurposeVisits != null) {
      leopurposevisits.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateLeoPurposeVisits!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leopurposevisits.add(userDetail);
        }
      });
    } else if (widget.duplicateloadGroups != null) {
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
    } else if (widget.duplicateatomCompanyTypes != null) {
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
    } else if (widget.duplicatedayPassReason != null) {
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
    } else if (widget.duplicatet1Analyst != null) {
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
    } else if (widget.duplicateactivePassInfoList != null) {
      activePassInfoList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateactivePassInfoList!.forEach((userDetail) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          activePassInfoList.add(userDetail);
        }
      });
    } else if (widget.duplicateQuantityUnitList != null) {
      activePassInfoList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      widget.duplicateQuantityUnitList!.forEach((quantity) {
        if (quantity.name!.toLowerCase().contains(text.toLowerCase())) {
          quantityUnitList.add(quantity);
        }
      });
    }

    setState(() {});
  }

  Widget setupAlertDialogContainer(double height, double width) {
    if (((widget.duplicateArticleList != null && widget.duplicateArticleList!.isEmpty) ||
            (widget.duplicateArticleList != null &&
                _searchCtrl.text.isNotEmpty &&
                articleList.isEmpty)) ||
        ((widget.duplicateEmployeeDepartments != null &&
                widget.duplicateEmployeeDepartments!.isEmpty) ||
            (widget.duplicateEmployeeDepartments != null &&
                _searchCtrl.text.isNotEmpty &&
                employeeDepartments.isEmpty)) ||
        ((widget.duplicateQuantityUnitList != null && widget.duplicateQuantityUnitList!.isEmpty) ||
            (widget.duplicateQuantityUnitList != null &&
                _searchCtrl.text.isNotEmpty &&
                employeeDepartments.isEmpty)) ||
        ((widget.duplicateDepostorList != null && widget.duplicateDepostorList!.isEmpty) ||
            (widget.duplicateDepostorList != null &&
                _searchCtrl.text.isNotEmpty &&
                depostorList.isEmpty)) ||
        ((widget.duplicateEntityList != null && widget.duplicateEntityList!.isEmpty) ||
            (widget.duplicateEntityList != null &&
                _searchCtrl.text.isNotEmpty &&
                entityList.isEmpty)) ||
        ((widget.duplicateLeoDepartments != null && widget.duplicateLeoDepartments!.isEmpty) ||
            (widget.duplicateLeoDepartments != null &&
                _searchCtrl.text.isNotEmpty &&
                leodepartments.isEmpty)) ||
        ((widget.duplicateLeoPurposeVisits != null && widget.duplicateLeoPurposeVisits!.isEmpty) ||
            (widget.duplicateLeoPurposeVisits != null &&
                _searchCtrl.text.isNotEmpty &&
                leopurposevisits.isEmpty) ||
            (widget.duplicateloadGroups != null &&
                _searchCtrl.text.isNotEmpty &&
                loadGroups.isEmpty) ||
            (widget.duplicateatomCompanyTypes != null &&
                _searchCtrl.text.isNotEmpty &&
                companyTypes.isEmpty) ||
            (widget.duplicatedayPassReason != null &&
                _searchCtrl.text.isNotEmpty &&
                dayPassReason.isEmpty) ||
            (widget.duplicatet1Analyst != null &&
                _searchCtrl.text.isNotEmpty &&
                t1analysts.isEmpty) ||
            (widget.duplicateactivePassInfoList != null &&
                _searchCtrl.text.isNotEmpty &&
                activePassInfoList.isEmpty))) {
      return //const Expanded(
          // child:
          const Center(
        child: Text(
          Constants.nodata,
          style: Styles.textStyleRegularGrey16,
          // ),
        ),
      );
    } else {
      return SizedBox(
        //padding: const EdgeInsets.all(0),
        // height: height, // Change as per your requirement
        // width: width- 50, // Change as per your requirement
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.duplicateEmployeeDepartments != null
              ? (_searchCtrl.text.isNotEmpty && employeeDepartments.isNotEmpty)
                  ? employeeDepartments.length
                  : widget.duplicateEmployeeDepartments?.length
              : (widget.duplicateactivePassInfoList != null
                  ? (_searchCtrl.text.isNotEmpty &&
                          activePassInfoList.isNotEmpty)
                      ? activePassInfoList.length
                      : widget.duplicateactivePassInfoList?.length
                  : widget.duplicatet1Analyst != null
                      ? (_searchCtrl.text.isNotEmpty && t1analysts.isNotEmpty)
                          ? t1analysts.length
                          : widget.duplicatet1Analyst?.length
                      : widget.duplicateQuantityUnitList != null
                          ? (_searchCtrl.text.isNotEmpty &&
                                  quantityUnitList.isNotEmpty)
                              ? t1analysts.length
                              : widget.duplicateQuantityUnitList?.length
                          : widget.duplicatedayPassReason != null
                              ? (_searchCtrl.text.isNotEmpty &&
                                      dayPassReason.isNotEmpty)
                                  ? dayPassReason.length
                                  : widget.duplicatedayPassReason?.length
                              : widget.duplicateatomCompanyTypes != null
                                  ? (_searchCtrl.text.isNotEmpty &&
                                          companyTypes.isNotEmpty)
                                      ? companyTypes.length
                                      : widget.duplicateatomCompanyTypes?.length
                                  : widget.duplicateArticleList != null
                                      ? (_searchCtrl.text.isNotEmpty &&
                                              articleList.isNotEmpty)
                                          ? articleList.length
                                          : widget.duplicateArticleList?.length
                                      : widget.duplicateDepostorList != null
                                          ? (_searchCtrl.text.isNotEmpty &&
                                                  depostorList.isNotEmpty)
                                              ? depostorList.length
                                              : widget
                                                  .duplicateDepostorList?.length
                                          : widget.duplicateEntityList != null
                                              ? (_searchCtrl.text.isNotEmpty &&
                                                      entityList.isNotEmpty)
                                                  ? entityList.length
                                                  : widget.duplicateEntityList
                                                      ?.length
                                              : widget.duplicateLeoDepartments !=
                                                      null
                                                  ? (_searchCtrl.text
                                                              .isNotEmpty &&
                                                          leodepartments
                                                              .isNotEmpty)
                                                      ? leodepartments.length
                                                      : widget
                                                          .duplicateLeoDepartments
                                                          ?.length
                                                  : widget.duplicateLeoPurposeVisits !=
                                                          null
                                                      ? (_searchCtrl.text
                                                                  .isNotEmpty &&
                                                              leopurposevisits
                                                                  .isNotEmpty)
                                                          ? leopurposevisits
                                                              .length
                                                          : widget
                                                              .duplicateLeoPurposeVisits
                                                              ?.length
                                                      : (_searchCtrl.text
                                                                  .isNotEmpty &&
                                                              loadGroups
                                                                  .isNotEmpty)
                                                          ? loadGroups.length
                                                          : widget
                                                              .duplicateloadGroups
                                                              ?.length),
          itemBuilder: (BuildContext context, int index) {
            if (widget.duplicateEmployeeDepartments != null) {
              Organisation? drawerItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  employeeDepartments.isNotEmpty)) {
                drawerItem = employeeDepartments[index];
              } else {
                drawerItem = widget.duplicateEmployeeDepartments?[index];
              }

              return ListTile(
                  onTap: () {
                    widget.onTap!(drawerItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateArticleList != null) {
              ArticleList? articleItem;
              if ((_searchCtrl.text.isNotEmpty && articleList.isNotEmpty)) {
                articleItem = articleList[index];
              } else {
                articleItem = widget.duplicateArticleList?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateDepostorList != null) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && depostorList.isNotEmpty)) {
                articleItem = depostorList[index];
              } else {
                articleItem = widget.duplicateDepostorList?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateEntityList != null) {
              Entity? articleItem;
              if ((_searchCtrl.text.isNotEmpty && entityList.isNotEmpty)) {
                articleItem = entityList[index];
              } else {
                articleItem = widget.duplicateEntityList?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateLeoPurposeVisits != null) {
              AtomLeoPurposeVisit? articleItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  leopurposevisits.isNotEmpty)) {
                articleItem = leopurposevisits[index];
              } else {
                articleItem = widget.duplicateLeoPurposeVisits?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateLeoDepartments != null) {
              AtomLeoDepartment? articleItem;
              if ((_searchCtrl.text.isNotEmpty && leodepartments.isNotEmpty)) {
                articleItem = leodepartments[index];
              } else {
                articleItem = widget.duplicateLeoDepartments?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateQuantityUnitList != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  quantityUnitList.isNotEmpty)) {
                articleItem = quantityUnitList[index];
              } else {
                articleItem = widget.duplicateQuantityUnitList?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateloadGroups != null) {
              DistributionGroup? articleItem;
              if ((_searchCtrl.text.isNotEmpty && loadGroups.isNotEmpty)) {
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
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateatomCompanyTypes != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && companyTypes.isNotEmpty)) {
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
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicatedayPassReason != null) {
              DayPassReasonElement? articleItem;
              if ((_searchCtrl.text.isNotEmpty && companyTypes.isNotEmpty)) {
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
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicatet1Analyst != null) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && companyTypes.isNotEmpty)) {
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
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
            } else if (widget.duplicateactivePassInfoList != null) {
              ActivePassInfoList? articleItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  activePassInfoList.isNotEmpty)) {
                articleItem = activePassInfoList[index];
              } else {
                articleItem = widget.duplicateactivePassInfoList?[index];
              }
              return ListTile(
                  onTap: () {
                    widget.onTap!(articleItem);
                    Navigator.of(context).pop();
                  },
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  horizontalTitleGap:
                      (widget.imageName != null && widget.imageName != '')
                          ? 20
                          : 0,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
                  leading: (widget.imageName != null && widget.imageName != '')
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
