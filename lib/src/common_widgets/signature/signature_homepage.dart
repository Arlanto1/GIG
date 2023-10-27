import 'package:db_atom/src/common_widgets/signature/signature_controller.dart';
import 'package:db_atom/src/common_widgets/signature/signature_func.dart';
import 'package:db_atom/src/common_widgets/signature/signature_signaturePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';
import '../base_widget/base_app_bar.dart';

class SignatureHomePage extends StatefulWidget {
  const SignatureHomePage({Key? key}) : super(key: key);

  @override
  State<SignatureHomePage> createState() => _SignatureHomePageState();
}

class _SignatureHomePageState extends State<SignatureHomePage> {
  SignatureController? controller;

  @override
  void initState() {
    // we initialize the signature controller
    controller = SignatureController(penStrokeWidth: 5, penColor: Colors.white);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.signatureTitle,
        showPopUp: false,
        showSaveButton: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: controller!,
              backgroundColor: Colors.black,
            ),
          ),
          buttonWidgets(context)!,
          buildSwapOrientation(context)!,
        ],
      ),
    );
  }

  Widget? buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        controller!.clear();

        setOrientation(newOrientation);
      },
      child: Container(
        color: const Color(0xFF2CAAE0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 0,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              '',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget? buttonWidgets(BuildContext context) => Container(
        color: const Color(0xFF2CAAE0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () async {
                  if (controller!.isNotEmpty) {
                    final signature = await exportSignature();

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) =>
                            ReviewSignaturePage(signature: signature!)),
                      ),
                    );

                    controller!.clear();
                  }
                },
                iconSize: 40,
                color: Colors.white,
                icon: const Icon(Icons.check)),
            IconButton(
              onPressed: () {
                controller!.clear();
              },
              iconSize: 40,
              color: Colors.red,
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black,
      points: controller!.points,
    );

    final signature = exportController.toPngBytes();

    //clean up the memory
    exportController.dispose();

    return signature;
  }
}
