import 'package:flutter/material.dart';

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
              style: const TextStyle(color: Colors.white)
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
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.white, width: 0.2),
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
