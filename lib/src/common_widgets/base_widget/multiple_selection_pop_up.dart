import 'dart:ui';

import 'package:db_atom/index.dart';


class CustomMultipleSelectionListTexts extends StatefulWidget {
  final List<Organisation> allItems;
  final List<Organisation> selectedValues;
  final Function(List<Organisation>) onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;
  final List<Organisation>? searchEntity;

  const CustomMultipleSelectionListTexts({
    super.key,
    required this.allItems,
    required this.onTap,
    required this.selectedValues,
    this.onLeftButtonTap,
    this.leftImageName,
    this.searchEntity,
  });

  @override
  State<CustomMultipleSelectionListTexts> createState() =>
      CustomMultipleSelectionListTextsState();
}

class CustomMultipleSelectionListTextsState
    extends State<CustomMultipleSelectionListTexts> {
  final TextEditingController _searchCtrl = TextEditingController();
  Color borderColor = Colors.grey;
  List<Organisation> entityList = [];

  @override
  void initState() {
    super.initState();

    entityList = List.from(widget.allItems);
    _initializeSelection();
  }

  void _initializeSelection() {
    for (final selectedEntity in widget.selectedValues) {
      final index =
          entityList.indexWhere((entity) => entity.id == selectedEntity.id);
      if (index != -1) {
        entityList[index].isSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white
                      .withValues(alpha: 0.2),
                  Colors.transparent,
                  Colors.white
                      .withValues(alpha: 0.2),
                  // Color(0xFF6474C6).withOpacity(0.14)
                ],
                stops: const [0.02, 0.35, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius:
              BorderRadius.circular(27),
              border: Border.all(
                color: Colors.white
                    .withValues(alpha: 0.80),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                  const Color(0xFF6474C6)
                      .withValues(
                      alpha: 0.09),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),

            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --------- ICON ROW (RIGHT) ---------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(AppIcon.closeIcon,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            )),
                      ),
                    ],
                  ),

                  // const SizedBox(height: ),

                  // --------- CONTENT AREA ---------
                  SizedBox(
                    height: MediaQuery.of(context).size.height/2,
                    // height: 400,
                    // width: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        _buildSearchWidget(),
                        _buildEntityList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --------- CONFIRM BUTTON ---------
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:const Color(0xFF071130),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if ((_searchCtrl.text.isNotEmpty)) {
                        entityList = List.from(widget.selectedValues);
                      } else {
                        entityList = List.from(widget.allItems);
                      }
                      final selectedEntities = entityList
                          .where((entity) => entity.isSelected ?? false)
                          .toList();
                      widget.onTap(selectedEntities);
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  Widget _buildSearchWidget() {
    return SearchWidget(
      controller: _searchCtrl,
      hintText: 'Search',
      leadingIcon: AppIcon.searchIcon,
      border: borderColor,
      isEnabled: false,
      // suffixIcon: _searchCtrl.text.length >  0 ? Conatiner()  :SizedBox(width: 0,),
      onChange: (String txt) {
        _filterEntities('');
        // _searchCtrl.clear();
        if (widget.searchEntity != null) {
          entityList.clear();
          if (txt.isEmpty) {
            setState(() {});
            return;
          }

          for (var userDetail in widget.searchEntity!) {
            if (userDetail.name!.toLowerCase().contains(txt.toLowerCase())) {
              entityList.add(userDetail);
            }
          }
        }
      },
      onSubmit: () {
        _filterEntities;
      },
    );
  }

  void _filterEntities(String text) {
    setState(
      () {
        entityList = widget.allItems
            .where((entity) =>
                entity.name!.toLowerCase().contains(text.toLowerCase()))
            .toList();
      },
    );
  }

  Widget _buildEntityList() {
    return Expanded(
      child: ListView.builder(
        itemCount: entityList.length,
        itemBuilder: (BuildContext context, int index) {
          Organisation entity = entityList[index];

          entity.isSelected ??= false;
          return ListTile(
            title: Text(
              entity.name ?? '',
              style: const TextStyle(color: Colors.white),
            ),
            leading: Checkbox(
              side: const BorderSide(
                color: Colors.white,   // <-- WHITE BORDER
                width: 2,              // optional: make border thicker
              ),
              checkColor: AppColors.black,
              activeColor: AppColors.white,
              value: entity.isSelected,
              onChanged: (value) {
                setState(() {
                  entity.isSelected = value ?? false;
                });
              },
            ),


          );
        },
      ),
    );
  }
}
