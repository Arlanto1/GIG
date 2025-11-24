import 'dart:developer';
import 'dart:ui';

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
    this.isDbUser
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
  bool? isDbUser;

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

    // return AlertDialog(
    //   icon: widget.leftImageName != null
    //       ? Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: <Widget>[
    //               GestureDetector(
    //                   onTap: () {
    //                     widget.onLeftButtonTap != null
    //                         ? widget.onLeftButtonTap!()
    //                         : null;
    //                   },
    //                   child: SvgPicture.asset(
    //                     widget.leftImageName ?? '',
    //                     colorFilter: const ColorFilter.mode(
    //                       AppColors.navigationSkyBlueColor,
    //                       BlendMode.srcIn,
    //                     ),
    //                     // color: AppColors.navigationSkyBlueColor,
    //                   ) //Icon(Icons.cancel)
    //                   ),
    //               GestureDetector(
    //                   onTap: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                   child: SvgPicture.asset(
    //                       AppIcon.closeicon, colorFilter: const ColorFilter.mode(AppColors.black,BlendMode.srcIn,),) //Icon(Icons.cancel)
    //                   ),
    //             ])
    //       : Align(
    //           alignment: Alignment.topRight,
    //           child: GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).pop();
    //               }, child: SvgPicture.asset(
    //             AppIcon.closeicon, colorFilter: const ColorFilter.mode(AppColors.black,BlendMode.srcIn,),) //Icon(Icons.cancel)
    //             //Icon(Icons.cancel)
    //               )),
    //   backgroundColor: AppColors.lavender.withValues(alpha: 0.9),
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   content: Builder(builder: (context) {
    //     // Get available height and width of the build area of this widget. Make a choice depending on the size.
    //     var height = MediaQuery.of(context).size.height;
    //     var width = MediaQuery.of(context).size.width;
    //     return SizedBox(
    //       height: height / 2,
    //       width: width - 40,
    //       child: Padding(
    //         padding: const EdgeInsets.all(0.0),
    //         child: SingleChildScrollView(
    //           child: Column(
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               // (widget.articleList != null && widget.articleList!.isNotEmpty) ||
    //               //         (widget.duplicateemployeeDepartments != null &&
    //               //             widget.duplicateemployeeDepartments!.isNotEmpty) ||
    //               //         (widget.depostorList != null &&
    //               //             widget.depostorList!.isNotEmpty)
    //               //  ?
    //               searchWidget(),
    //               //  : Container(),
    //               setupAlertDialogContainer(height, width),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   }),
    // );

    // return AlertDialog(
    //     // backgroundColor: Colors.white,
    //     elevation: 0,
    //     contentPadding: EdgeInsets.zero,
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //     icon: widget.leftImageName != null
    //         ? Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         GestureDetector(
    //           onTap: () {
    //             widget.onLeftButtonTap?.call();
    //           },
    //           child: SvgPicture.asset(
    //             widget.leftImageName ?? '',
    //             colorFilter: const ColorFilter.mode(
    //               AppColors.navigationSkyBlueColor,
    //               BlendMode.srcIn,
    //             ),
    //           ),
    //         ),
    //         GestureDetector(
    //           onTap: () => Navigator.of(context).pop(),
    //           child: SvgPicture.asset(
    //             AppIcon.closeicon,
    //             colorFilter: const ColorFilter.mode(
    //               AppColors.black,
    //               BlendMode.srcIn,
    //             ),
    //           ),
    //         ),
    //       ],
    //     )
    //         : Align(
    //       alignment: Alignment.topRight,
    //       child: GestureDetector(
    //         onTap: () => Navigator.of(context).pop(),
    //         child: SvgPicture.asset(
    //           AppIcon.closeicon,
    //           colorFilter: const ColorFilter.mode(
    //             AppColors.black,
    //             BlendMode.srcIn,
    //           ),
    //         ),
    //       ),
    //     ),
    //
    //     // --------- KEEP ONLY THE INNER GLASS CONTAINER ----------
    //     content: ClipRRect(
    //       borderRadius: BorderRadius.circular(20),
    //       child: BackdropFilter(
    //         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
    //         child: Container(
    //           padding: const EdgeInsets.all(20),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(20),
    //             gradient: LinearGradient(
    //               colors: [
    //                 Colors.white.withOpacity(0.15),
    //                 Colors.white.withOpacity(0.05),
    //               ],
    //             ),
    //             border: Border.all(
    //               color: Colors.white.withOpacity(0.25),
    //             ),
    //           ),
    //
    //           child: Builder(builder: (context) {
    //             var height = MediaQuery.of(context).size.height;
    //             var width = MediaQuery.of(context).size.width;
    //
    //             return SizedBox(
    //               height: height / 2,
    //               width: width - 40,
    //               child: SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     searchWidget(),
    //                     setupAlertDialogContainer(height, width),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }),
    //         ),
    //       ),
    //     ),
    //   );

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      child: AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 10,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // ---------- CLOSE ICON ABOVE SEARCH ----------
        // titlePadding: const EdgeInsets.only(top: 10, right: 10),
        // title: Align(
        //   alignment: Alignment.topRight,
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).pop(),
        //     child: SvgPicture.asset(
        //       AppIcon.closeicon,
        //       height: 22,
        //       width: 22,
        //       colorFilter: const ColorFilter.mode(
        //         AppColors.black,
        //         BlendMode.srcIn,
        //       ),
        //     ),
        //   ),
        // ),

        // ---------- ONLY ONE GLASS CONTAINER ----------
        content: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   gradient: LinearGradient(
              //     colors: [
              //       Colors.white.withOpacity(0.05),
              //       AppColors.lavender.withOpacity(0.15),
              //     ],
              //   ),
              //   border: Border.all(
              //     color: Colors.white.withOpacity(0.35),
              //   ),
              // ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.2),
                    // Color(0xFF6474C6).withOpacity(0.14)
                  ],
                  stops: [0.02, 0.35, 1],
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
                          AppIcon.closeicon,
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

    else if (widget.duplicateDepostorList != null) {
      depostorList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      // for (var userDetail in widget.duplicateDepostorList!) {
      if (text.length >= 5 ) {
        // Call the API only once when the search text length is greater than 2
        try {
          final response = await CommonServices().getBaseUsers(
            roleName: widget.roleName, // Replace with actual role
            locationId: widget.location, // Replace with actual location ID
            isDbUser: widget.isDbUser, // Set based on your use case
            search: int.tryParse(text) ?? text, // Passthe search parameter
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
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
                      style: Styles.textStyleRegularWhite14,
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
