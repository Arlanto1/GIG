import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../models/entity.dart';
import '../../utils/app_themes/colors/app_color.dart';

class CustomMultipleSelectionListTexts extends StatefulWidget {
  final List<Entity> duplicateEntityList;
  final List<Entity> mainSelectedEntityList;
  final Function(List<Entity>) onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;

  const CustomMultipleSelectionListTexts({
    Key? key,
    required this.duplicateEntityList,
    required this.onTap,
    required this.mainSelectedEntityList,
    this.onLeftButtonTap,
    this.leftImageName,
  }) : super(key: key);

  @override
  State<CustomMultipleSelectionListTexts> createState() =>
      CustomMultipleSelectionListTextsState();
}

class CustomMultipleSelectionListTextsState
    extends State<CustomMultipleSelectionListTexts> {
  final TextEditingController _searchCtrl = TextEditingController();
  Color borderColor = Colors.grey;
  List<Entity> entityList = [];

  @override
  void initState() {
    super.initState();

    entityList = List.from(widget.duplicateEntityList);
    _initializeSelection();
  }

  void _initializeSelection() {
    for (final selectedEntity in widget.mainSelectedEntityList) {
      final index =
      entityList.indexWhere((entity) => entity.id == selectedEntity.id);
      if (index != -1) {
        entityList[index].isSelected = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.onLeftButtonTap != null ? widget.onLeftButtonTap!() : null;
            },
            child: SvgPicture.asset(
              widget.leftImageName ?? '',
              color: AppColors.navigationSkybluecolor,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(AppIcon.closeicon),
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundWhitecolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            _buildSearchWidget(),
            _buildEntityList(),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Collect selected entities
            final selectedEntities =
            entityList.where((entity) => entity.isSelected??false).toList();
            widget.onTap(selectedEntities); // Call the callback
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
      controller: _searchCtrl,
      decoration: InputDecoration(
        hintText: 'Search',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _searchCtrl.clear();
            _filterEntities('');
          },
        ),
      ),
      onChanged: _filterEntities,
    );
  }

  void _filterEntities(String text) {
    setState(() {
      entityList = widget.duplicateEntityList
          .where((entity) =>
          entity.name!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Widget _buildEntityList() {
    return Expanded(
      child: ListView.builder(
        itemCount: entityList.length,
        itemBuilder: (BuildContext context, int index) {
          final entity = entityList[index];

          return ListTile(
            title: Text(entity.name ?? ''),
            leading: Checkbox(
              checkColor: AppColors.white,
              activeColor: AppColors.navigationSkybluecolor,
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
