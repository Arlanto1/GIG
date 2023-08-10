import 'dart:io';

import 'package:db_atom/src/configurations/environment_config.dart';
import 'package:db_atom/src/configurations/main_config.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadImage {
  Future<void> saveImage(
    BuildContext context,
    int id,
    String name,
  ) async {
    final endpoint = Environment().config.apiHost;
    final url = Uri.parse('$endpoint/downloadImage/$id');
    print(url);
    downloadData(context, name, url);
  }

  Future<void> exportPdf(BuildContext context, int id, String name, int start,
      int max, String path) async {
    final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('$endpoint$path?startPos=$start&maxResults=$max&userId=$id');
    print(url);
    downloadData(context, name, url);
  }

  Future<void> exportExcel(BuildContext context, int id, String name, int start,
      int max, String path) async {
    final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('$endpoint$path?startPos=$start&maxResults=$max&userId=$id');
    print(url);
    downloadData(context, name, url);
  }

  Future<void> passexportPdf(BuildContext context, int id, String name,int passtype, int isList,
       String path) async {
    final endpoint = Environment().config.apiHost;
     final url =
        Uri.parse('$endpoint$path?userId=$id&passType=$passtype&isList=$isList');
    print(url);
    downloadData(context, name, url);
  }

  Future<void> passexportExcel(BuildContext context, int id, String name,int passtype, int isList,
       String path) async {
    final endpoint = Environment().config.apiHost;
    final url =
        Uri.parse('$endpoint$path?userId=$id&passType=$passtype&isList=$isList');
    print(url);
    downloadData(context, name, url);
  }

  downloadData(BuildContext context, String name, Uri url) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      // Download image
      final http.Response response = await http.get(url);

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/$name';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'File saved successfully';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppColors.navigationSkybluecolor,
      ));
    }
  }
}
