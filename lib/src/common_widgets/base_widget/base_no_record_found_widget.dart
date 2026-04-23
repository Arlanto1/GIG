// import 'package:flutter/material.dart';
//
// class NoRecordFoundWidget extends StatelessWidget {
//   const NoRecordFoundWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'No Records Found.',
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';

class NoRecordFoundWidget extends StatelessWidget {
  const NoRecordFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg2.png',
            fit: BoxFit.cover,
          ),
        ),
        // Blur layer
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
        ),
        // Text
        const Center(
          child: Text(
            'No Records Found.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}