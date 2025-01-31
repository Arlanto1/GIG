import 'dart:developer';

import 'package:db_atom/index.dart';

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
    this.isEmployeeId,
    this.location,
    this.roleName,
  });

  final String? imageName;
  List<Organisation>? duplicateEmployeeDepartments;
  List<Organisation>? duplicateArticleList;
  List<Organisation>? duplicateEntityList;
  List<BaseUser>? duplicateDepostorList;
  List<Organisation>? duplicateLeoDepartments;
  List<Organisation>? duplicateLeoPurposeVisits;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;
  List<Organisation>? duplicateloadGroups;
  List<Organisation>? duplicateatomCompanyTypes;
  List<Organisation>? duplicatedayPassReason;
  List<BaseUser>? duplicatet1Analyst;
  List<Organisation>? duplicateactivePassInfoList;

  List<Organisation>? duplicateQuantityUnitList;
  bool? isEmployeeId;
  int? location;
  String? roleName;

  @override
  State<CustomListTexts> createState() => CustomListTextsState();
}

class CustomListTextsState extends State<CustomListTexts> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  List<Organisation> employeeDepartments = [];
  List<Organisation> articleList = [];
  List<Organisation> entityList = [];
  List<BaseUser> depostorList = [];
  List<Organisation> leodepartments = [];
  List<Organisation> leopurposevisits = [];
  List<Organisation> loadGroups = [];
  List<Organisation> companyTypes = [];
  List<Organisation> dayPassReason = [];
  List<BaseUser> t1analysts = [];
  List<Organisation> activePassInfoList = [];
  List<Organisation> quantityUnitList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // employeeDepartments = widget.duplicateemployeeDepartments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    log('--duplicateatomCompanyTypes--${widget.duplicateatomCompanyTypes?.length}--');

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
                        colorFilter: const ColorFilter.mode(
                          AppColors.navigationSkyBlueColor,
                          BlendMode.srcIn,
                        ),
                        // color: AppColors.navigationSkyBlueColor,
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
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
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
          borderColor = AppColors.navigationSkyBlueColor;
        } else {
          borderColor = AppColors.textGreyThemeColor;
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
    }
    else if (widget.duplicateArticleList != null) {
      articleList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateArticleList!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          articleList.add(userDetail);
        }
      }
    }

    else if (widget.duplicateDepostorList != null) {
      depostorList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      // for (var userDetail in widget.duplicateDepostorList!) {
      if (text.isEmpty) {
        // Call the API only once when the search text length empty
        try {
          final response = await CommonServices().getBaseUsers(
            roleName: 'ATOM_STATIC_USER', // Replace with actual role
            locationId: widget.location, // Replace with actual location ID
            isDbUser: true, // Set based on your use case
            search: int.tryParse(text), // Passthe search parameter
          );

          depostorList.clear(); // Clear the existing list
          if (response.isNotEmpty) {
            depostorList.addAll(response); // Add API response to the list
          }
        } catch (e) {
          log('Error while fetching users: $e');
        }
      } else {
        // Perform local filtering for shorter text
        depostorList.clear(); // Clear the existing list
        for (var userDetail in widget.duplicateDepostorList!) {
          if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
            log('--userDetail--ddd-${userDetail.name}--');
            depostorList.add(userDetail);
          }
        }
        // }
      }
    } else if (widget.duplicateEntityList != null) {
      entityList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateEntityList!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          entityList.add(userDetail);
        }
      }
    } else if (widget.duplicateLeoDepartments != null) {
      leodepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateLeoDepartments!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leodepartments.add(userDetail);
        }
      }
    } else if (widget.duplicateLeoPurposeVisits != null) {
      leopurposevisits.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateLeoPurposeVisits!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leopurposevisits.add(userDetail);
        }
      }
    } else if (widget.duplicateloadGroups != null) {
      loadGroups.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateloadGroups!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          loadGroups.add(userDetail);
        }
      }
    } else if (widget.duplicateatomCompanyTypes != null) {
      log('-text---$text--');
      companyTypes.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateatomCompanyTypes!) {
        log('-text---$text--');

        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          companyTypes.add(userDetail);
        }
        // if (userDetail.keyDescription
        //     !.toLowerCase()
        //     .contains(text.toLowerCase())) {
        //   companyTypes.add(userDetail);
        // }
        // for (var userDetail in widget.duplicateatomCompanyTypes!) {
        //   if (userDetail.keyDescription!.toLowerCase().contains(text.toLowerCase())) {
        //     companyTypes.add(userDetail);
        //   }
        // }
      }
    } else if (widget.duplicatedayPassReason != null) {
      log('-text---$text--');

      dayPassReason.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicatedayPassReason!) {
        log('-text---$text--');

        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          dayPassReason.add(userDetail);
        }
      }
    } else if (widget.duplicatet1Analyst != null) {
      t1analysts.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicatet1Analyst!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          t1analysts.add(userDetail);
        }
      }
    } else if (widget.duplicateactivePassInfoList != null) {
      activePassInfoList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateactivePassInfoList!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          activePassInfoList.add(userDetail);
        }
      }
    } else if (widget.duplicateQuantityUnitList != null) {
      quantityUnitList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }
      for (var quantity in widget.duplicateQuantityUnitList!) {
        log('-text---$text--');
        if (quantity.name!.toLowerCase().contains(text.toLowerCase())) {
          quantityUnitList.add(quantity);
        }
      }
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
                quantityUnitList.isEmpty)) ||
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
                              ? quantityUnitList.length
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

              log('drawerItem?.name----${drawerItem?.name}--');

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
              Organisation? articleItem;
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
            } else if (widget.duplicateDepostorList != null &&
                widget.isEmployeeId == false) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && depostorList.isNotEmpty)) {
                articleItem = depostorList[index];

                log('--articleItem--ddd-${articleItem.name}--');
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
                      !(articleItem!.employeeId.isEmptyOrNull)
                          ? '${articleItem.name} (${articleItem.email}, ${articleItem.employeeId})'
                          : !(articleItem.email.isEmptyOrNull)
                              ? '${articleItem.name} (${articleItem.email})'
                              : '${articleItem.name}',
                      style: Styles.textStyleRegularGrey16,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateDepostorList != null &&
                widget.isEmployeeId == true) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && depostorList.isNotEmpty)) {
                articleItem = depostorList[index];

                log('--articleItem--ddd-${articleItem.name}--');
              } else {
                articleItem = widget.duplicateDepostorList?[index];
              }
              return !articleItem!.employeeId.isEmptyOrNull
                  ? ListTile(
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
                      leading:
                          (widget.imageName != null && widget.imageName != '')
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
                          !(articleItem.employeeId.isEmptyOrNull)
                              ? '${articleItem.employeeId}'
                              : '${articleItem.name} (${articleItem.email})',
                          style: Styles.textStyleRegularGrey16,
                          textAlign: TextAlign.left,
                        ),
                      ))
                  : const SizedBox.shrink();
            } else if (widget.duplicateEntityList != null) {
              Organisation? articleItem;
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
              Organisation? articleItem;
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
              Organisation? articleItem;
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
              Organisation? articleItem;
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
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && dayPassReason.isNotEmpty)) {
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
              Organisation? articleItem;
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
            return null;
          },
        ),
      );
    }
  }
}
