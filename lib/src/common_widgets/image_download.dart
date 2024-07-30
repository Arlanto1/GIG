import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/show_image.dart';
import 'package:http/http.dart' as http;

class DownloadImage {
  Future<void> saveImage({
    required BuildContext context,
    required int id,
    required String name,
    required String moduleCode,
    bool? viewOnly, // Show attached/uploaded Image and PDF
  }) async {
    if (id == 1) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    log('--saveImage--');
    final endpoint = Environment().config.apiHost;
    // final url = Uri.parse('$endpoint/downloadImage/$id');
    // print('url123123 $url');
    // downloadData(context, name, url);
    final url = "$endpoint/downloadImage/$id?module=$moduleCode";
    // final response = await BaseApiService().getRequest(
    //   url: url,
    // );
    log('--sss-response-$url-');
    final uri = Uri.parse(url);
    downloadData(context, name, uri, viewOnly: viewOnly ?? false);
  }

  Future<void> exportPdf(
    BuildContext context,
    String name,
    String path, {
    String? customParameter,
  }) async {
    final endpoint = Environment().config.apiHost;
    String url = '$endpoint$path';
    if (!customParameter.isEmptyOrNull) {
      url = '$url&${customParameter!}';
    }
    log('url: $url');

    final uri = Uri.parse(url);
    downloadData(context, name, uri, viewOnly: true);
  }

  Future<void> exportExcel(
    BuildContext context,
    String name,
    String path, {
    String? customParameter,
  }) async {
    final endpoint = Environment().config.apiHost;
    String url = '$endpoint$path';
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
    // final response = await BaseApiService().getRequest(
    //   url: url,
    // );
    final uri = Uri.parse(url);

    return downloadData(context, name, uri, viewOnly: true);
  }

  Future<void> passexportExcel(BuildContext context, int id, String name,
      int passtype, int isList, String path) async {
    final endpoint = Environment().config.apiHost;
    // final url =
    //     Uri.parse('$endpoint$path?userId=$id&passType=$passtype&isList=$isList');
    // print(url);
    // downloadData(context, name, url);
    final url = '$endpoint$path?userId=$id&passType=$passtype&isList=$isList';
    // final response = await BaseApiService().getRequest(
    //   url: url,
    // );
    final uri = Uri.parse(url);

    return downloadData(context, name, uri);
  }

  Future<void> downloadData(
    BuildContext context,
    String name,
    Uri url, {
    bool? viewOnly,
  }) async {
    showLoadingDialog(context);
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

      log("Status Code: ${response.statusCode}");
      if (response.statusCode == 400) {
        final responseBody = json.decode(response.body);
        throw GenericResponse.fromJson(responseBody);
      }

      // Get temporary directory
      final dir = await getTemporaryDirectory();
      // Create a file name
      var filename = '${dir.path}/$name';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      log('--file.path-----${file.path}----');

      if (viewOnly ?? false) {
        dismissLoadingDialog(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => filename.toLowerCase().contains('.pdf')
                ? ShowPdf(
                    filePath: file.path,
                  )
                : ShowImage(
                    filePath: file.path,
                  ),
          ),
        );
        return;
      }

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
        backgroundColor: AppColors.navigationSkyBlueColor,
      ));
    }
  }
}
