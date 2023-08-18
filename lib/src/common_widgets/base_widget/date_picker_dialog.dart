// import 'package:flutter/material.dart';
//
// class BaseDatePickerDialog {
//   void datePickerDialog(BuildContext context, TextEditingController textfield) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           width: 70,
//           height: 100,
//           child: AlertDialog(
//
//             title: const Text('Select a Date'),
//             content: SizedBox(
//               height: 200,
//               child: CalendarDatePicker(
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime(2100),
//                 onDateChanged: (DateTime selectedDate) {
//                   textfield.text = selectedDate.toString();
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
