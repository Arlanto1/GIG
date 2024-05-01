import 'package:flutter/material.dart';

class RecordLockedWidget extends StatelessWidget {
  const RecordLockedWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.red),
      )),
    );
  }
}
