import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
    required this.label,
  });

  final double height;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blue, // Border color
          width: .7, // Border width
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            offset: Offset(0, 4),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(28.0),
                  child: Icon(Icons.add),
                ),
              ),
            ),
            // CommonWidgets.verticalSpacerWidget(height * 0.01),
            Text(label)
          ],
        ),
      ),
    );
  }
}
