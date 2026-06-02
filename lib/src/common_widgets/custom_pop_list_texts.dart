import 'dart:developer';
import 'dart:ui';

import 'package:db_atom/index.dart';

class CustomListTexts extends StatefulWidget {
  const CustomListTexts({
    super.key,
    this.imageName,
    this.duplicateEmployeeDepartments,
    this.duplicateArticleList,
    this.onTap,
    this.duplicateDepositorList,
    this.onLeftButtonTap,
    this.leftImageName,
    this.duplicateEntityList,
    this.duplicateLeoDepartments,
    this.duplicateLeoPurposeVisits,
    this.duplicateLoadGroups,
    this.duplicateAtomCompanyTypes,
    this.duplicateDayPassReason,
    this.duplicateT1Analyst,
    this.duplicateActivePassInfoList,
    this.duplicateQuantityUnitList,
    this.isEmployeeId,
    this.location,
    this.roleName,
    this.isDbUser
  });

  final String? imageName;
  final List<Organisation>? duplicateEmployeeDepartments;
  final List<Organisation>? duplicateArticleList;
  final List<Organisation>? duplicateEntityList;
  final List<BaseUser>? duplicateDepositorList;
  final List<Organisation>? duplicateLeoDepartments;
  final List<Organisation>? duplicateLeoPurposeVisits;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;
  final List<Organisation>? duplicateLoadGroups;
  final List<Organisation>? duplicateAtomCompanyTypes;
  final List<Organisation>? duplicateDayPassReason;
  final List<BaseUser>? duplicateT1Analyst;
  final List<Organisation>? duplicateActivePassInfoList;

  final List<Organisation>? duplicateQuantityUnitList;
  final bool? isEmployeeId;
  final int? location;
  final String? roleName;
  final bool? isDbUser;

  @override
  State<CustomListTexts> createState() => CustomListTextsState();
}

class CustomListTextsState extends State<CustomListTexts> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  List<Organisation> employeeDepartments = [];
  List<Organisation> articleList = [];
  List<Organisation> entityList = [];
  List<BaseUser> depositorList = [];
  List<Organisation> leoDepartments = [];
  List<Organisation> leoPurposeVisits = [];
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
    log('--duplicateatomCompanyTypes--${widget.duplicateAtomCompanyTypes?.length}--');


    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      child: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 10,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),


        // ---------- ONLY ONE GLASS CONTAINER ----------
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.2),
                    // Color(0xFF6474C6).withOpacity(0.14)
                  ],
                  stops: const [0.02, 0.35, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(27),
                border: Border.all(
                  color: Colors.white
                      .withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6474C6)
                        .withValues(alpha: 0.09),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// Expanded search bar (stays fixed)
                      Expanded(child: searchWidget()),

                      const SizedBox(width: 10),

                      /// Close icon
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          AppIcon.closeIcon,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Builder(
                    builder: (context) {
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return SizedBox(
                        height: height / 2,
                        width: width - 40,

                        /// Now only the list scrolls
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              setupAlertDialogContainer(height, width),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ),


      ),
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

    else if (widget.duplicateDepositorList != null) {
      depositorList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      // for (var userDetail in widget.duplicateDepositorList!) {
      if (text.length >= 5 ) {
        // Call the API only once when the search text length is greater than 2
        try {
          final response = await CommonServices().getBaseUsers(
            roleName: widget.roleName, // Replace with actual role
            locationId: widget.location, // Replace with actual location ID
            isDbUser: widget.isDbUser, // Set based on your use case
            search: int.tryParse(text) ?? text, // Pass the search parameter
          );

          depositorList.clear(); // Clear the existing list
          if (response.isNotEmpty) {
            depositorList.addAll(response); // Add API response to the list
          }
        } catch (e) {
          log('Error while fetching users: $e');
        }
      } else {
        // Perform local filtering for shorter text
        depositorList.clear(); // Clear the existing list
        for (var userDetail in widget.duplicateDepositorList!) {
          if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
            log('--userDetail--ddd-${userDetail.name}--');
            depositorList.add(userDetail);
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
      leoDepartments.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateLeoDepartments!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leoDepartments.add(userDetail);
        }
      }
    } else if (widget.duplicateLeoPurposeVisits != null) {
      leoPurposeVisits.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateLeoPurposeVisits!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          leoPurposeVisits.add(userDetail);
        }
      }
    } else if (widget.duplicateLoadGroups != null) {
      loadGroups.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateLoadGroups!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          loadGroups.add(userDetail);
        }
      }
    } else if (widget.duplicateAtomCompanyTypes != null) {
      log('-text---$text--');
      companyTypes.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateAtomCompanyTypes!) {
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
    } else if (widget.duplicateDayPassReason != null) {
      log('-text---$text--');

      dayPassReason.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateDayPassReason!) {
        log('-text---$text--');

        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          dayPassReason.add(userDetail);
        }
      }
    } else if (widget.duplicateT1Analyst != null) {
      t1analysts.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateT1Analyst!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          t1analysts.add(userDetail);
        }
      }
    } else if (widget.duplicateActivePassInfoList != null) {
      activePassInfoList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateActivePassInfoList!) {
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
        ((widget.duplicateDepositorList != null && widget.duplicateDepositorList!.isEmpty) ||
            (widget.duplicateDepositorList != null &&
                _searchCtrl.text.isNotEmpty &&
                depositorList.isEmpty)) ||
        ((widget.duplicateEntityList != null && widget.duplicateEntityList!.isEmpty) ||
            (widget.duplicateEntityList != null &&
                _searchCtrl.text.isNotEmpty &&
                entityList.isEmpty)) ||
        ((widget.duplicateLeoDepartments != null && widget.duplicateLeoDepartments!.isEmpty) ||
            (widget.duplicateLeoDepartments != null &&
                _searchCtrl.text.isNotEmpty &&
                leoDepartments.isEmpty)) ||
        ((widget.duplicateLeoPurposeVisits != null && widget.duplicateLeoPurposeVisits!.isEmpty) ||
            (widget.duplicateLeoPurposeVisits != null &&
                _searchCtrl.text.isNotEmpty &&
                leoPurposeVisits.isEmpty) ||
            (widget.duplicateLoadGroups != null &&
                _searchCtrl.text.isNotEmpty &&
                loadGroups.isEmpty) ||
            (widget.duplicateAtomCompanyTypes != null &&
                _searchCtrl.text.isNotEmpty &&
                companyTypes.isEmpty) ||
            (widget.duplicateDayPassReason != null &&
                _searchCtrl.text.isNotEmpty &&
                dayPassReason.isEmpty) ||
            (widget.duplicateT1Analyst != null &&
                _searchCtrl.text.isNotEmpty &&
                t1analysts.isEmpty) ||
            (widget.duplicateActivePassInfoList != null &&
                _searchCtrl.text.isNotEmpty &&
                activePassInfoList.isEmpty))) {
      return //const Expanded(
          // child:
          const Center(
        child: Text(
          Constants.nodata,
          style: Styles.textStyleRegularNormalWhite14,
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
              : (widget.duplicateActivePassInfoList != null
                  ? (_searchCtrl.text.isNotEmpty &&
                          activePassInfoList.isNotEmpty)
                      ? activePassInfoList.length
                      : widget.duplicateActivePassInfoList?.length
                  : widget.duplicateT1Analyst != null
                      ? (_searchCtrl.text.isNotEmpty && t1analysts.isNotEmpty)
                          ? t1analysts.length
                          : widget.duplicateT1Analyst?.length
                      : widget.duplicateQuantityUnitList != null
                          ? (_searchCtrl.text.isNotEmpty &&
                                  quantityUnitList.isNotEmpty)
                              ? quantityUnitList.length
                              : widget.duplicateQuantityUnitList?.length
                          : widget.duplicateDayPassReason != null
                              ? (_searchCtrl.text.isNotEmpty &&
                                      dayPassReason.isNotEmpty)
                                  ? dayPassReason.length
                                  : widget.duplicateDayPassReason?.length
                              : widget.duplicateAtomCompanyTypes != null
                                  ? (_searchCtrl.text.isNotEmpty &&
                                          companyTypes.isNotEmpty)
                                      ? companyTypes.length
                                      : widget.duplicateAtomCompanyTypes?.length
                                  : widget.duplicateArticleList != null
                                      ? (_searchCtrl.text.isNotEmpty &&
                                              articleList.isNotEmpty)
                                          ? articleList.length
                                          : widget.duplicateArticleList?.length
                                      : widget.duplicateDepositorList != null
                                          ? (_searchCtrl.text.isNotEmpty &&
                                                  depositorList.isNotEmpty)
                                              ? depositorList.length
                                              : widget
                                                  .duplicateDepositorList?.length
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
                                                          leoDepartments
                                                              .isNotEmpty)
                                                      ? leoDepartments.length
                                                      : widget
                                                          .duplicateLeoDepartments
                                                          ?.length
                                                  : widget.duplicateLeoPurposeVisits !=
                                                          null
                                                      ? (_searchCtrl.text
                                                                  .isNotEmpty &&
                                                              leoPurposeVisits
                                                                  .isNotEmpty)
                                                          ? leoPurposeVisits
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
                                                              .duplicateLoadGroups
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateDepositorList != null &&
                widget.isEmployeeId == false) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && depositorList.isNotEmpty)) {
                articleItem = depositorList[index];

                log('--articleItem--ddd-${articleItem.name}--');
              } else {
                articleItem = widget.duplicateDepositorList?[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateDepositorList != null &&
                widget.isEmployeeId == true) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && depositorList.isNotEmpty)) {
                articleItem = depositorList[index];

                log('--articleItem--ddd-${articleItem.name}--');
              } else {
                articleItem = widget.duplicateDepositorList?[index];
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
                          style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateLeoPurposeVisits != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  leoPurposeVisits.isNotEmpty)) {
                articleItem = leoPurposeVisits[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateLeoDepartments != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && leoDepartments.isNotEmpty)) {
                articleItem = leoDepartments[index];
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateLoadGroups != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && loadGroups.isNotEmpty)) {
                articleItem = loadGroups[index];
              } else {
                articleItem = widget.duplicateLoadGroups?[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateAtomCompanyTypes != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && companyTypes.isNotEmpty)) {
                articleItem = companyTypes[index];
              } else {
                articleItem = widget.duplicateAtomCompanyTypes?[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateDayPassReason != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && dayPassReason.isNotEmpty)) {
                articleItem = dayPassReason[index];
              } else {
                articleItem = widget.duplicateDayPassReason?[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateT1Analyst != null) {
              BaseUser? articleItem;
              if ((_searchCtrl.text.isNotEmpty && companyTypes.isNotEmpty)) {
                articleItem = t1analysts[index];
              } else {
                articleItem = widget.duplicateT1Analyst?[index];
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
                      style: Styles.textStyleRegularWhite14,
                      textAlign: TextAlign.left,
                    ),
                  ));
            } else if (widget.duplicateActivePassInfoList != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty &&
                  activePassInfoList.isNotEmpty)) {
                articleItem = activePassInfoList[index];
              } else {
                articleItem = widget.duplicateActivePassInfoList?[index];
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
                      style: Styles.textStyleRegularWhite14,
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
