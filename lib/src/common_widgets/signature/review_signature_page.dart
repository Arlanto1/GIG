import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

class ReviewSignaturePage extends StatelessWidget {
  final Uint8List signature;

  const ReviewSignaturePage({super.key, required this.signature});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF2CAAE0),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2CAAE0),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            IconButton(
              onPressed: () => saveSignature(context),
              icon: const Icon(Icons.save),
            ),
          ],
          centerTitle: true,
          title: const Text('Save Signature'),
        ),
        body: Center(
          child: Image.memory(signature),
        ));
  }

  Future? saveSignature(BuildContext context) async {
    var nav = Navigator.of(context);
    final status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }

    //making signature name unique
    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time';
    log(name);

    // final result = await ImageGallerySaver.saveImage(signature, name: name);

    final result = await SaverGallery.saveImage(
      signature,
      // quality: 60,
      fileName: name,
      // androidRelativePath: "Pictures/appName/xx",
      skipIfExists: false,
    );
    _toastInfo("$result");

    // final isSuccessful = result['isSuccess'];

    // if (isSuccessful) {
    //   nav.pop();
    //   Get.snackbar('Success', 'Signature saved to device',
    //       backgroundColor: Colors.white, colorText: Colors.green);
    // } else {
    //   Get.snackbar('Success', 'Signature saved to device',
    //       backgroundColor: Colors.red, colorText: Colors.white);
    // }
  }

  _toastInfo(String info) {
    Get.snackbar('Success', 'Signature saved to device',
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
