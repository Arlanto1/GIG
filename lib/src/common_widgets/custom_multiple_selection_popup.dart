import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/models/organisation.dart';
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
    this.mainselectedentityList,
  });

  final String? imagename;

  List<Organisation>? duplicateentityList;
  final Function? onTap;
  final Function? onLeftButtonTap;
  final String? leftimagename;
  List<Organisation>? mainselectedentityList;

  @override
  State<CustomMultipleSelectionListTexts> createState() =>
      CustomMultipleSelectionListTextsState();
}

class CustomMultipleSelectionListTextsState
    extends State<CustomMultipleSelectionListTexts> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;
  var selectedListindexes = [];

  List<Organisation> entityList = [];
  List<Organisation> selectentityList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // employeeDepartments = widget.duplicateemployeeDepartments ?? [];
    if (widget.mainselectedentityList != null &&
        (widget.mainselectedentityList ?? []).isNotEmpty) {
      selectentityList = widget.mainselectedentityList ?? [];
      itemsIdentify();
    }
  }

  itemsIdentify() async {
    await getdata();
  }

  getdata() {
    for (int i = 0; i < (widget.duplicateentityList ?? []).length; i++) {
      Organisation articleItem = widget.duplicateentityList![i];
      if (widget.mainselectedentityList!.contains(articleItem)) {
        selectedListindexes.add(i);
      }
    }
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
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: () {
                        widget.onLeftButtonTap != null
                            ? widget.onLeftButtonTap!()
                            : null;
                      },
                      child: SvgPicture.asset(
                        widget.leftimagename ?? '',
                        colorFilter: const ColorFilter.mode(
                          AppColors.textGreyThemeColor,
                          BlendMode.srcIn,
                        ),
                      ) //Icon(Icons.cancel)
                      ),
                ]),
            GestureDetector(
              onTap: () {
                //lawenforcementValidations(context, globalState);
                widget.onTap!(selectentityList);
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.send,
                color: AppColors.navigationSkyBlueColor,
              ),
            ),
          ]),
      backgroundColor: AppColors.backgroundWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Builder(builder: (context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SizedBox(
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
    if (widget.duplicateentityList != null) {
      entityList.clear();
      if (text.isEmpty) {
        setState(() {});
        return;
      }

      for (var userDetail in widget.duplicateentityList!) {
        if (userDetail.name!.toLowerCase().contains(text.toLowerCase())) {
          entityList.add(userDetail);
        }
      }
    }

    setState(() {});
  }

  Widget setupAlertDialoadContainer(double height, double width) {
    if ((widget.duplicateentityList != null &&
            widget.duplicateentityList!.isEmpty) ||
        (widget.duplicateentityList != null &&
            _searchCtrl.text.isNotEmpty &&
            entityList.isEmpty)) {
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
        //padding: const EdgeInsets.all(20),
        // height: height / 1.6, // Change as per your requirement
        // width: width- 50, // Change as per your requirement
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.duplicateentityList != null
              ? (_searchCtrl.text.isNotEmpty && entityList.isNotEmpty)
                  ? entityList.length
                  : widget.duplicateentityList?.length
              : widget.duplicateentityList?.length,
          itemBuilder: (BuildContext context, int index) {
            if (widget.duplicateentityList != null) {
              Organisation? articleItem;
              if ((_searchCtrl.text.isNotEmpty && entityList.isNotEmpty)) {
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

                      Organisation? articleItem1 =
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
                  visualDensity: const VisualDensity(vertical: 0),
                  // to expand
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
                                ? AppColors.navigationSkyBlueColor
                                : AppColors.textGreyThemeColor)),
                  ));
            }
            return null;
          },
        ),
      );
    }
  }
}
