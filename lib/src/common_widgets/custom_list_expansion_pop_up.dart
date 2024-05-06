import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';

class CustomExpansionListTexts extends StatefulWidget {
  const CustomExpansionListTexts({
    super.key,
    this.locationList,
    this.onTap,
  });

  final Locations? locationList;
  final Function? onTap;

  @override
  State<CustomExpansionListTexts> createState() =>
      CustomExpansionListTextsState();
}

class CustomExpansionListTextsState extends State<CustomExpansionListTexts> {
  final _searchCtrl = TextEditingController();
  Color borderColor = AppColors.searchBarBorder;

  @override
  void initState() {
    super.initState();
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
          borderColor = AppColors.navigationSkyBlueColor;
        } else {
          borderColor = AppColors.textGreyThemeColor;
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

  Widget expansionListWidget() {
    if (widget.locationList != null) {
      return Expanded(
          child: MyExpansionTileList(widget.locationList, widget.onTap));
    } else {
      return const Expanded(
        child: Center(
          child: Text(
            Constants.nodata,
            style: Styles.textStyleRegularGrey16,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Center(
      child: SizedBox(
        height: height / 1.5,
        width: width - 50,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.searchBarBorder, width: 1),
            borderRadius: circularBorderRadius10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                            AppIcon.closeicon) //Icon(Icons.cancel)
                        ),
                  ),
                ),
                expansionListWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyExpansionTileList extends StatefulWidget {
  const MyExpansionTileList(this.locations, this.onTap, {super.key});

  final Locations? locations;
  final Function? onTap;

  @override
  State<MyExpansionTileList> createState() => MyExpansionTileListState();
}

class MyExpansionTileListState extends State<MyExpansionTileList> {
  int selectedIndex = -1;
  String selectedTitle = '';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (widget.locations!.central != null) ...[
          _buildPlayerModelList(widget.locations!.central, 'Central', context),
        ],
        if (widget.locations!.mumbai != null) ...[
          _buildPlayerModelList(widget.locations!.mumbai, 'Mumbai', context),
        ],
        if (widget.locations!.northEast != null) ...[
          _buildPlayerModelList(
              widget.locations!.northEast, 'North East', context),
        ],
        if (widget.locations!.south != null) ...[
          _buildPlayerModelList(widget.locations!.south, 'South', context),
        ],
        if (widget.locations!.west != null) ...[
          _buildPlayerModelList(widget.locations!.west, 'West', context),
        ],
      ],
    );
  }

  Widget _buildPlayerModelList(
      List<Organisation>? items, String title, BuildContext context) {
    return ExpansionTile(
      trailing: const SizedBox.shrink(),
      key: GlobalKey(),
      initiallyExpanded: selectedTitle == title,
      onExpansionChanged: (value) {
        if (value == true) {
          selectedTitle = title;
          selectedIndex = -1;
          setState(() {});
        } else {
          selectedTitle = '';
          selectedIndex = -1;
          setState(() {});
        }
      },
      title: Text(
        title,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
      ),
      children: _buildOperationsFromSecurity(context, items, title),
    );
  }

  List<Widget> _buildOperationsFromSecurity(
      BuildContext context, List<Organisation>? items, String stitle) {
    List<Widget> children = [];

    for (int i = 0; i < items!.length; i++) {
      Organisation drawerItem = items[i];
      children.add(
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            key: Key(i.toString()),
            initiallyExpanded: selectedIndex == i,
            onExpansionChanged: (value) {
              if (value == true) {
                selectedIndex = i;
                setState(() {});
              } else {
                selectedIndex = -1;
                setState(() {});
              }
            },
            //col: Colors.transparent,
            expandedAlignment: Alignment.centerLeft,
            trailing: const SizedBox.shrink(),
            title: ListTile(
              title: Text(
                drawerItem.name ?? '',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Constants.customFontSemiBoldFamily,
                    fontWeight: FontWeight.w600,
                    color: ((i == selectedIndex) && (stitle == selectedTitle))
                        ? AppColors.navigationSkyBlueColor
                        : AppColors.textGreyThemeColor),
                // style: Styles.textStyleBlack16,
              ),
              onTap: () => _onExpansionSelectItem(i, context, items),
            ),

            childrenPadding: const EdgeInsets.only(left: 20), //children padding
          ),
        ),
      );
    }

    return children;
  }

  _onExpansionSelectItem(
      int index, BuildContext context, List<Organisation>? items) async {
    selectedIndex = index;
    Organisation? drawerItem = items?[index];
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } else if (index == 3) {
    } else if (index == 4) {
    } else if (index == 5) {}
    widget.onTap!(drawerItem);
    Navigator.of(context).pop();

    setState(() {});
  }
}
