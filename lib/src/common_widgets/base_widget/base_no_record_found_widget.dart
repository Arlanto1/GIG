import 'package:flutter/material.dart';

class NoRecordFoundWidget extends StatelessWidget {
  const NoRecordFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Records Found.'),
    );
  }
}