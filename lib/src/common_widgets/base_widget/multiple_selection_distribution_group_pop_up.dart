import 'package:db_atom/src/features/lawenforcement/models/law_enforement_request.dart';
import 'package:db_atom/src/models/organisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../utils/app_themes/colors/app_color.dart';

class CustomMultipleSelectionDistributionGroupListTexts extends StatefulWidget {
  final List<MailList> allItems;
  final List<MailList> selectedValues;
  final Function(List<MailList>) onTap;
  final Function? onLeftButtonTap;
  final String? leftImageName;

  const CustomMultipleSelectionDistributionGroupListTexts({
    Key? key,
    required this.allItems,
    required this.onTap,
    required this.selectedValues,
    this.onLeftButtonTap,
    this.leftImageName,
  }) : super(key: key);

  @override
  State<CustomMultipleSelectionDistributionGroupListTexts> createState() =>
      CustomMultipleSelectionDistributionGroupListTextsState();
}

class CustomMultipleSelectionDistributionGroupListTextsState
    extends State<CustomMultipleSelectionDistributionGroupListTexts> {
  final TextEditingController _searchCtrl = TextEditingController();
  Color borderColor = Colors.grey;
  List<MailList> entityList = [];

  @override
  void initState() {
    super.initState();

    entityList = List.from(widget.allItems);
    _initializeSelection();
  }

  void _initializeSelection() {
    for (final selectedEntity in widget.selectedValues) {
      final index =
          entityList.indexWhere((entity) => entity.groupId == selectedEntity.groupId);
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
      content: SizedBox(
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
            final selectedEntities = entityList
                .where((entity) => entity.isSelected ?? false)
                .toList();
            widget.onTap(selectedEntities); // Call the callback
          },
          child: const Text('Confirm'),
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
          icon: const Icon(Icons.clear),
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
          MailList entity = entityList[index];

          entity.isSelected ??= false;
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
