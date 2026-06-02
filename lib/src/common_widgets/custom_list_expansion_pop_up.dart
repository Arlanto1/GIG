import 'dart:ui';

import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/search_widget.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/constants/ui_geometry_constants.dart';
import 'package:db_atom/src/features/createfound/models/get_locations_model.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  Color borderColor = AppColors.white;

  // Search widget
  Widget searchWidget() {
    return SearchWidget(
      controller: _searchCtrl,
      hintText: Constants.searchHintText,
      textInputFieldKey: Keys.searchInputField,
      leadingIcon: AppIcon.searchIcon,
      border: borderColor,
      isEnabled: false,
      focusChange: (bool focus) {
        borderColor = focus
            ? AppColors.white
            : AppColors.white;
        setState(() {});
      },
      onSubmit: (String txt) {
        _searchCtrl.text = txt;
      },
    );
  }

  // NO Expanded inside this method anymore (important)
  Widget expansionListWidget() {
    final list = widget.locationList;
    if (list == null) {
      return const Center(
        child: Text(
          "No data found",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return MyExpansionTileList(
      locations: list,
      onTap: widget.onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.height / 1.5,
        width: size.width - 50,
        child: ClipRRect(
          borderRadius: circularBorderRadius10,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Material(
              color: Colors.transparent,
              child: Container(

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
                        .withValues(alpha: 0.80),
                    width: 0.8,
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //  HEADER ROW: Title + Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                             "Locations",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

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

                      //  Expanded should wrap only the list
                      Expanded(
                        child: expansionListWidget(),
                      ),
                    ],
                  ),

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ExpansionTile List

class MyExpansionTileList extends StatefulWidget {
  const MyExpansionTileList({
    super.key,
    required this.locations,
    this.onTap,
  });

  final Locations locations;
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
      children: getLocations(context),
    );
  }

  List<Widget> getLocations(BuildContext context) {
    List<Widget> widgets = [];

    for (Region region in widget.locations.regions ?? []) {
      widgets.add(
        _buildRegionTile(region.locations, region.name ?? '', context),
      );
    }

    return widgets;
  }

  Widget _buildRegionTile(
      List<Organisation>? items, String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
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
                    .withValues(alpha: 0.80),
                width: 0.8,
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
            child: ExpansionTile(
              trailing: const SizedBox.shrink(),
              initiallyExpanded: selectedTitle == title,
              onExpansionChanged: (open) {
                if (open) {
                  selectedTitle = title;
                  selectedIndex = -1;
                } else {
                  selectedTitle = '';
                  selectedIndex = -1;
                }
                setState(() {});
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    selectedTitle == title ? Icons.keyboard_arrow_down: Icons.keyboard_arrow_right_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              children: _buildChildLocations(context, items, title),
            ),
          ),
        ),
      ),
    );
  }


  List<Widget> _buildChildLocations(
      BuildContext context, List<Organisation>? items, String stitle) {
    return List.generate(items?.length ?? 0, (i) {
      final item = items![i];
      return ExpansionTile(
        trailing: const SizedBox.shrink(),
        initiallyExpanded: selectedIndex == i,
        onExpansionChanged: (isOpen) {
          selectedIndex = isOpen ? i : -1;
          setState(() {});
        },
        title: ListTile(
          title: Text(
            item.name ?? '',
            style: TextStyle(
              fontSize: 16,
              fontFamily: Constants.customFontSemiBoldFamily,
              fontWeight: FontWeight.w600,
              color: ((i == selectedIndex) && (stitle == selectedTitle))
                  ? AppColors.white
                  : AppColors.white,
            ),
          ),
          onTap: () {
            widget.onTap?.call(item);
            Navigator.of(context).pop();
          },
        ),
        childrenPadding: const EdgeInsets.only(left: 20),
      );
    });
  }
}
