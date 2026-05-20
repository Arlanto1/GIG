import 'dart:developer';

import 'package:db_atom/index.dart';

class ShowPdf extends StatelessWidget {
  const ShowPdf({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            foregroundColor: Colors.black,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        child:
     Scaffold(
       // appBar: AppBar(
       //   backgroundColor: Colors.black,
       //   iconTheme: const IconThemeData(color: Colors.white),
       // ),
      appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: 'PDF Report',
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          showCustomIcon: true,
          customIcon: Icons.download,
          color: Colors.black,
          titleColor: Colors.black,
          onTapCustomIcon: () async {
            // Ask the user to save it
            final params = SaveFileDialogParams(sourceFilePath: filePath);
            final finalPath = await FlutterFileDialog.saveFile(params: params);

            if (finalPath != null) {
              log('---File saved successfully---');
              // message = 'File saved successfully';
            }
          }),
      body: filePath.isNotEmpty
          ? PDFView(
              filePath: filePath,
            )
          : const Center(child: CircularProgressIndicator()),
    ));
  }
}
