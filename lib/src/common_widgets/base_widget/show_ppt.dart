// import 'dart:developer';
//
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:open_file/open_file.dart';
//
// import '../../../index.dart';
//
// class ShowPptx extends StatefulWidget {
//   final String filePath;
//   const ShowPptx({super.key, required this.filePath});
//
//   @override
//   State<ShowPptx> createState() => _ShowPptxState();
// }
//
// class _ShowPptxState extends State<ShowPptx> {
//   @override
//   void initState() {
//     super.initState();
//     _openFile();
//   }
//
//   Future<void> _openFile() async {
//     try {
//       final result = await OpenFile.open(widget.filePath);
//       log('OpenFile result: ${result.message}');
//
//       // ✅ Fallback if open_file fails
//       if (result.type != ResultType.done) {
//         final intent = AndroidIntent(
//           action: 'action_view',
//           data: Uri.file(widget.filePath).toString(),
//           type: 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
//         );
//         await intent.launch();
//       }
//     } catch (e) {
//       log('Open file error: $e');
//       // ✅ Last resort fallback
//       final intent = AndroidIntent(
//         action: 'action_view',
//         data: Uri.file(widget.filePath).toString(),
//         type: 'application/vnd.openxmlformats-officedocument.presentationml.presentation',
//       );
//       await intent.launch();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar().buildAppHeader(
//         context: context,
//         title: 'Presentation',
//         showPopUp: false,
//         showSaveButton: false,
//         showSubmitButton: false,
//         showDisLikeButton: false,
//         showLikeButton: false,
//         showCustomIcon: true,
//         customIcon: Icons.download,
//         color: Colors.black,
//         titleColor: Colors.black,
//         onTapCustomIcon: () async {
//           final params = SaveFileDialogParams(sourceFilePath: widget.filePath);
//           await FlutterFileDialog.saveFile(params: params);
//         },
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.slideshow, size: 64, color: Colors.orange),
//             SizedBox(height: 16),
//             Text('Opening presentation...'),
//           ],
//         ),
//       ),
//     );
//   }
// }