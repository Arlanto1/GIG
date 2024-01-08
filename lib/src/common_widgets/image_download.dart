import 'dart:developer';
import 'dart:io';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../index.dart';

class DownloadImage {
  Future<void> saveImage(
    BuildContext context,
    int id,
    String name,
  ) async {
    final endpoint = Environment().config.apiHost;
    // final url = Uri.parse('$endpoint/downloadImage/$id');
    // print('url123123 $url');
    // downloadData(context, name, url);
    final url = "$endpoint/downloadImage/$id";
    final response = await BaseApiService().getRequest(
      url: url,
    );
    downloadData(context, name, response);
  }

  Future<void> exportPdf(
    BuildContext context,
    int id,
    String name,
    int start,
    int max,
    String path, {
    String? customParameter,
  }) async {
    final endpoint = Environment().config.apiHost;
    String url = '$endpoint$path?startPos=$start&maxResults=$max&userId=$id';
    if (!customParameter.isEmptyOrNull) {
      url = '$url&${customParameter!}';
    }
    log('url: $url');

    final uri = Uri.parse(url);
    downloadData(context, name, uri);
  }

  Future<void> exportExcel(
    BuildContext context,
    int id,
    String name,
    int start,
    int max,
    String path, {
    String? customParameter,
  }) async {
    final endpoint = Environment().config.apiHost;
    String url = '$endpoint$path?startPos=$start&maxResults=$max&userId=$id';
    if (!customParameter.isEmptyOrNull) {
      url = '$url&${customParameter!}';
    }
    log('url: $url');

    final uri = Uri.parse(url);
    downloadData(context, name, uri);
  }

  Future<void> passexportPdf(BuildContext context, int id, String name,
      int passtype, int isList, String path) async {
    final endpoint = Environment().config.apiHost;
    //  final url =
    //     Uri.parse('$endpoint$path?userId=$id&passType=$passtype&isList=$isList');
    // print(url);
    // downloadData(context, name, url);
    final url = '$endpoint$path?userId=$id&passType=$passtype&isList=$isList';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return downloadData(context, name, response);
  }

  Future<void> passexportExcel(BuildContext context, int id, String name,
      int passtype, int isList, String path) async {
    final endpoint = Environment().config.apiHost;
    // final url =
    //     Uri.parse('$endpoint$path?userId=$id&passType=$passtype&isList=$isList');
    // print(url);
    // downloadData(context, name, url);
    final url = '$endpoint$path?userId=$id&passType=$passtype&isList=$isList';
    final response = await BaseApiService().getRequest(
      url: url,
    );
    return downloadData(context, name, response);
  }

  downloadData(BuildContext context, String name, Uri url) async {
    String? message;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      // Download image
      var headers = await BaseApiService().getHeaders(
        isAuthenticated: true,
      );
      var response = await http.get(
        url,
        headers: headers,
      );
      // final http.Response response = await http.get(
      //   url,
      //   headers: headers,
      // );
      log('response---${response.body.toString()}');
      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/$name';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      log('pdf---$file');
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
