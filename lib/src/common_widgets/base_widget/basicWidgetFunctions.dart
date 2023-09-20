import 'dart:developer';

import 'package:flutter/material.dart';

import '../../utils/app_themes/colors/app_color.dart';

class BasicWidgetFunctions {
  Widget getStringText({
    required List<String> strings,
    void Function()? onDeleteTap,
    bool? showDeleteIcon = false,
  }) {
    List<Widget> widgets = [];

    for (String email in strings) {
      widgets.add(Row(
        children: [
          Text(
            email,
            textAlign: TextAlign.start,
          ),
          if (showDeleteIcon!) ...[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDeleteTap,
            ),
          ],
        ],
      ));
      widgets.add(const SizedBox(height: 2));
    }

    return widgets.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              color: AppColors.lightgreyBackground,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              ),
            ),
          )
        : Container();
  }
}
