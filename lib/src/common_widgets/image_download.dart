import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:db_atom/index.dart';
import 'package:db_atom/src/common_widgets/show_image.dart';
import 'package:db_atom/src/common_widgets/show_vedio.dart';
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

  // Future<void> downloadData(
  //   BuildContext context,
  //   String name,
  //   Uri url, {
  //   bool? viewOnly,
  // }) async {
  //   showLoadingDialog(context);
  //   String? message;
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   try {
  //     // Download image
  //     var headers = await BaseApiService().getHeaders(
  //       isAuthenticated: true,
  //     );
  //     var response = await http.get(
  //       url,
  //       headers: headers,
  //     );
  //
  //     log("Status Code: ${response.statusCode}");
  //     if (response.statusCode == 400) {
  //       final responseBody = json.decode(response.body);
  //       throw GenericResponse.fromJson(responseBody);
  //     }
  //
  //     // Get temporary directory
  //     final dir = await getTemporaryDirectory();
  //     // Create a file name
  //     var filename = '${dir.path}/$name';
  //
  //     // Save to filesystem
  //     final file = File(filename);
  //     await file.writeAsBytes(response.bodyBytes);
  //
  //     log('--file.path-----${file.path}----');
  //
  //     if (viewOnly ?? false) {
  //       dismissLoadingDialog(context);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => filename.toLowerCase().contains('.pdf')
  //               ? ShowPdf(
  //                   filePath: file.path,
  //                 )
  //               : ShowImage(
  //                   filePath: file.path,
  //                 ),
  //         ),
  //       );
  //       return;
  //     }
  //     dismissLoadingDialog(context);
  //
  //     log('pdf---$file');
  //     // Ask the user to save it
  //     final params = SaveFileDialogParams(sourceFilePath: file.path);
  //     final finalPath = await FlutterFileDialog.saveFile(params: params);
  //
  //     if (finalPath != null) {
  //       message = 'File saved successfully';
  //     }
  //   } catch (e) {
  //     message = 'An error occurred while saving the image';
  //   }
  //
  //   if (message != null) {
  //     scaffoldMessenger.showSnackBar(SnackBar(
  //       content: Text(message),
  //       backgroundColor: AppColors.navigationSkyBlueColor,
  //     ));
  //   }
  // }

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

      final dir = await getTemporaryDirectory();
      var filename = '${dir.path}/$name';

      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      log('--file.path-----${file.path}----');

      if (viewOnly ?? false) {
        dismissLoadingDialog(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) {
            //     final lowerName = filename.toLowerCase();
            //     if (lowerName.contains('.pdf')) {
            //       return ShowPdf(filePath: file.path);
            //     } else if (_getFileExtension == true) {
            //       return ShowVideo(filePath: file.path);
            //     } else {
            //       return ShowImage(filePath: file.path);
            //     }
            //   },
            builder: (context) {
              final ext = _getFileExtension(filename);

              switch (ext) {
                case '.pdf':
                  return ShowPdf(filePath: file.path);
                case '.mp4':
                case '.mov':
                case '.avi':
                case '.mkv':
                case '.webm':
                case '.flv':
                case '.wmv':
                  return ShowVideo(filePath: file.path);
                // case '.doc':
                // case '.docx':
                //   return ShowDoc(filePath: file.path);
                // case '.xls':
                // case '.xlsx':
                // case '.csv':
                //   return ShowExcel(filePath: file.path);
                // case '.ppt':
                // case '.pptx':
                //   return ShowPpt(filePath: file.path);
                default:
                // fallback for images
                  return ShowImage(filePath: file.path);
              }
            },
          ),
        );
        return;
      }
      dismissLoadingDialog(context);

      log('file---$file');
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'File saved successfully';
      }
    } catch (e) {
      dismissLoadingDialog(context); // ✅ dismiss on error too
      log('downloadData error: $e');
      message = 'An error occurred while saving the file';
    }

    if (message != null) {
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppColors.navigationSkyBlueColor,
      ));
    }
  }

  String _getFileExtension(String filename) {
    const videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.flv', '.wmv'];
    const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.svg'];
    const docExtensions = ['.doc', '.docx'];
    const excelExtensions = ['.xls', '.xlsx', '.csv'];
    const pptExtensions = ['.ppt', '.pptx'];
    const pdfExtensions = ['.pdf'];

    final lower = filename.toLowerCase();

    if (videoExtensions.any((ext) => lower.endsWith(ext))) {
      return videoExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (imageExtensions.any((ext) => lower.endsWith(ext))) {
      return imageExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (docExtensions.any((ext) => lower.endsWith(ext))) {
      return docExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (excelExtensions.any((ext) => lower.endsWith(ext))) {
      return excelExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (pptExtensions.any((ext) => lower.endsWith(ext))) {
      return pptExtensions.firstWhere((ext) => lower.endsWith(ext));
    } else if (pdfExtensions.any((ext) => lower.endsWith(ext))) {
      return pdfExtensions.firstWhere((ext) => lower.endsWith(ext));
    }

    // Fallback: extract extension from filename directly
    final dotIndex = filename.lastIndexOf('.');
    return dotIndex != -1 ? filename.substring(dotIndex) : '';
  }
  Future<void> exportMaterialPdf(
      BuildContext context,
      String name,
      String path, {
        String? customParameter,
      }) async {
    final endpoint = Environment().config.apiHost1;
    String url = '$endpoint$path';
    if (!customParameter.isEmptyOrNull) {
      url = '$url&${customParameter!}';
    }
    log('url: $url');

    final uri = Uri.parse(url);
    downloadData(context, name, uri, viewOnly: true);
  }

  Future<void> exportMaterialExcel(
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

}
