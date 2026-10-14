
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/guarding_operations/guarding_master_data/guarding_master_data_details/cubits/guarding_master_data_details_cubit.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/material_movement_details_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/models/image_content.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/user.dart';

enum FileDocumnets { photo, camera, documents }

class UploadAttachment extends StatefulWidget {
  UploadAttachment({
    super.key,
    this.userdetails,
    this.getFiles,
    this.lawstate,
    this.createoundstate,
    this.createpassmgmtstate,
    this.isPhotoType,
    this.inwardState,
    this.onImageSelected,
  });

  User? userdetails;
  List<ImageContent>? getFiles;
  LawEnforcementState? lawstate;
  CreateFoundState? createoundstate;
  CreatePassMgmtState? createpassmgmtstate;
  bool? isPhotoType;
  MaterialMovementDetailsState? inwardState;
  GuardingMasterDataDetailsState? dataState;
  Function? onImageSelected;

  @override
  State<UploadAttachment> createState() => UploadAttachmentState();
}

class UploadAttachmentState extends State<UploadAttachment>
    with WidgetsBindingObserver {
  PermissionStatus _status = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showImagePicker(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> _getFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      log("Picked image from camera: ${pickedFile.path}");
      await cropAndUploadImage(File(pickedFile.path));
    }
  }

  Future<void> _getFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      log("Picked image from gallery: ${pickedFile.path}");
      await cropAndUploadImage(File(pickedFile.path));
    }
  }

  Future<void> cropAndUploadImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // uiSettings: [
      //   AndroidUiSettings(
      //     toolbarTitle: 'Edit Image',
      //     toolbarColor: Colors.blue,
      //     toolbarWidgetColor: Colors.white,
      //     initAspectRatio: CropAspectRatioPreset.original,
      //     lockAspectRatio: false,
      //   ),
      //   IOSUiSettings(title: 'Edit Image'),
      // ],
    );

    if (croppedFile != null) {
      log("Cropped file path: ${croppedFile.path}");
      await imageupload(File(croppedFile.path));
    } else {
      log("Cropping cancelled.");
    }
  }

  Future<void> _getDocumentFileslist() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile platformfile = result.files.first;
      Uint8List imgbytes = File(platformfile.path!).readAsBytesSync();
      String bs4str = base64Encode(imgbytes);
      String? contentType = lookupMimeType(platformfile.path!);

      ImageContent image = ImageContent(
        ownerName: widget.userdetails?.name ?? '',
        contentType: contentType,
        imageContent: bs4str,
        title: platformfile.name,
        fileSize: platformfile.size,
      );

      log("Document selected: ${image.title}");
      await _sendDataBack(image);
    } else {
      log("No document selected.");
    }
  }

  Future<void> imageupload(File result) async {
    String fileName = result.path.split('/').last;
    Uint8List imgbytes = result.readAsBytesSync();
    String bs4str = base64Encode(imgbytes);
    String? contentType = lookupMimeType(result.path);

    ImageContent image = ImageContent(
      ownerName: widget.userdetails?.name ?? '',
      contentType: contentType,
      imageContent: bs4str,
      title: fileName,
      fileSize: result.lengthSync(),
    );

    log("Uploading image: ${image.title}, size: ${image.fileSize}");
    await _sendDataBack(image);
  }

  Future<void> _sendDataBack(ImageContent data) async {
    log("UploadAttachment → _sendDataBack called");
    log("ImageContent: ${data.toJson()}");

    if (widget.lawstate != null) {
      log("Sending to lawEnforcementCubit");
      widget.getFiles?.add(data);
      lawEnforcementCubit.addAttchment(widget.getFiles ?? []);
    } else if (widget.createoundstate != null) {
      log("Sending to createFoundArticleCubit");
      widget.getFiles?.add(data);
      createFoundArticleCubit.addAttachment(widget.getFiles ?? []);
    } else if (widget.createpassmgmtstate != null) {
      log("Sending to createPassMgmtCubit");
      widget.getFiles?.add(data);
      if (widget.isPhotoType ?? false) {
        createPassMgmtCubit.photoAttchment(widget.getFiles ?? []);
      }
      if (widget.isPhotoType == true &&
          widget.getFiles != null &&
          widget.getFiles!.isNotEmpty) {
        widget.getFiles!.clear();
        widget.getFiles?.add(data);
      } else {
        createPassMgmtCubit.addAttchment(widget.getFiles ?? []);
      }
    } else if (widget.inwardState != null) {
      log("Calling onImageSelected for inwardState");
      await widget.onImageSelected?.call(data);
      return;
    } else if (widget.onImageSelected != null) {
      log("Calling onImageSelected fallback");
      await widget.onImageSelected?.call(data);
      return;
    } else {
      log("⚠️ No handler defined for uploaded image.");
    }
  }

  Future<void> _askPermission(FileDocumnets docType) async {
    if (docType == FileDocumnets.camera) {
      _askCameraPermission();
    } else if (docType == FileDocumnets.photo) {
      _askPhotoPermission();
    }
  }

  void _askCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      _status = await Permission.camera.status;
      _getFromCamera();
    } else {
      _updateStatus(await Permission.camera.status);
    }
  }

  void _askPhotoPermission() async {
    if (await Permission.photos.request().isGranted ||
        await Permission.mediaLibrary.request().isGranted ||
        await Permission.photosAddOnly.request().isGranted) {
      _status = await Permission.photos.status;
      _getFromGallery();
    } else {
      _updateStatus(await Permission.photos.status);
    }
  }

  void _updateStatus(PermissionStatus value) {
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }

    if (value == PermissionStatus.denied ||
        value == PermissionStatus.permanentlyDenied) {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (builder) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                border: Border(
                  top: BorderSide(color: Colors.white.withValues(alpha:0.20), width: 0.8),
                  left: BorderSide(color: Colors.white.withValues(alpha:0.20), width: 0.8),
                  right: BorderSide(color: Colors.white.withValues(alpha:0.20), width: 0.8),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const Text(
                    Constants.captureOrUpload,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      _pickerButton(
                        icon: AppIcon.galleryIcon,
                        label: Constants.gallery,
                        onTap: () {
                          Navigator.pop(context);
                          _askPermission(FileDocumnets.photo);
                        },
                      ),
                      _pickerButton(
                        icon: AppIcon.cameraIcon,
                        label: Constants.camera,
                        onTap: () {
                          Navigator.pop(context);
                          _askPermission(FileDocumnets.camera);
                        },
                      ),
                      _pickerButton(
                        icon: AppIcon.documentsIcon,
                        label: Constants.document,
                        onTap: () {
                          Navigator.pop(context);
                          _getDocumentFileslist();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) => Navigator.pop(context));
  }

  Widget _pickerButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 0.8,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}