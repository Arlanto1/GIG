import 'dart:developer';

import 'package:db_atom/index.dart';
import 'package:photo_view/photo_view.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({super.key, required this.filePath});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar().buildAppHeader(
          context: context,
          title: 'View Image',
          showPopUp: false,
          showSaveButton: false,
          showSubmitButton: false,
          showDisLikeButton: false,
          showLikeButton: false,
          showCustomIcon: true,
          customIcon: Icons.download,
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
          ? PhotoView(
          imageProvider:  AssetImage(filePath),
                      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
