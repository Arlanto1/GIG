import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_settings/app_settings.dart';
import 'package:db_atom/src/common_widgets/app_bar.dart';
import 'package:db_atom/src/common_widgets/basic_reusable_widgets.dart';
import 'package:db_atom/src/common_widgets/cubits.dart';
import 'package:db_atom/src/common_widgets/custom_pop_menu.dart';
import 'package:db_atom/src/common_widgets/mulltipart_image_upload.dart';
import 'package:db_atom/src/common_widgets/new_search_textfield.dart';
import 'package:db_atom/src/common_widgets/pop_button.dart';
import 'package:db_atom/src/constants/app_icon.dart';
import 'package:db_atom/src/constants/constants.dart';
import 'package:db_atom/src/features/createfound/controllers/create_found_state.dart';
import 'package:db_atom/src/features/createfound/models/attachment_model.dart';
import 'package:db_atom/src/features/createfound/models/create_found_request.dart';
import 'package:db_atom/src/features/createfound/models/get_user_model.dart';
import 'package:db_atom/src/features/createfound/views/create_found_attachment.dart';
import 'package:db_atom/src/features/lawenforcement/controllers/law_enforcement_state.dart';
import 'package:db_atom/src/features/material_movement/material_movement_details/cubits/inward_cubit.dart';
import 'package:db_atom/src/features/passmanagement/daypassmgmt/createpassmgmt/controllers/create_pass_mgmt_state.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:db_atom/src/utils/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

enum FileDocumnets { Photo, Camera, Documents }

class UploadAttachment extends StatefulWidget {
  UploadAttachment({super.key, this.userdetails, this.getFiles,this.lawstate,this.createoundstate,this.createpassmgmtstate, this.isPhotoType, this.inwardState});
  GetUserDetails? userdetails;
  List<CreateImage>? getFiles;
  LawEnforcementState? lawstate;
  CreateFoundState? createoundstate;
  CreatePassMgmtState? createpassmgmtstate;
  bool? isPhotoType;
  InwardState? inwardState;

  @override
  State<UploadAttachment> createState() => UploadAttachmentState();
}

class UploadAttachmentState extends State<UploadAttachment>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  
  PermissionStatus _status = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showImagePicker(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // This block of code is used in the event that the user
  // has denied the permission forever. Detects if the permission
  // has been granted when the user returns from the
  // permission system screen.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container();
  }

  _getFromCamera() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      print(imageFile);
      

      getpath(imageFile);
    }
  }

  _getFromGallery() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      print(imageFile);
      getpath(imageFile);
    }
  }

  _getDocumentFileslist() async {
    //FilePickerResult? result = await FilePicker.platform.pickFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
     
      PlatformFile platformfile = result.files.first;

      print(platformfile.name);
      print(platformfile.bytes);
      print(platformfile.size);
      print(platformfile.extension);
      print(platformfile.path);

     // Uint8List? imgbytes = platformfile.bytes;
     Uint8List imgbytes = Uint8List.fromList(File(platformfile.path ?? '' ).readAsBytesSync());
      String fileName = platformfile.name;
      String bs4str = base64Encode(imgbytes);
      String? contentype = lookupMimeType(platformfile.path ?? '');
      CreateImage image = CreateImage(
          ownerName: widget.userdetails?.name ?? '',
          contentType: contentype,
          imageContent: bs4str,
          title: fileName,
          fileSize: platformfile.size);
      String username = await SharedPrefs.getUsername();
      print(username);
      int id = await SharedPrefs.getFoundId();
      print(id);
      // var res = await ImagesMultiPart().uploadImage(
      //     "/uploadFoundImage?id=$id&userEmail=$username", file?.path ?? '');
      // print(res);
      await _sendDataBack(image);
    } else {
      // User canceled the picker2
      // print(result);
      // File files = File(result.files.single.path);
    }
  }

  getpath(File result) async {
    // FilePickerResult result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['png'],
    // );

    if (result != null) {
      imageupload(result);
    } else {
      // User canceled the picker
    }
  }

  imageupload(File result) async {
    String fileName = result.path.split('/').last;
    Uint8List imgbytes = result.readAsBytesSync();
    String bs4str = base64Encode(imgbytes);
    String? contentype = lookupMimeType(result.path);
    // 'image/jpeg'
    // AttachmentModel model =
    //     AttachmentModel(fullpath: result.path, name: fileName);
    CreateImage image = CreateImage(
        ownerName: widget.userdetails?.name ?? '',
        contentType: contentype,
        imageContent: bs4str,
        title: fileName,
        fileSize: result.lengthSync());
    String username = await SharedPrefs.getUsername();
    print(username);
    int id = await SharedPrefs.getFoundId();
    print(id);
    // var res = await ImagesMultiPart().uploadImage(
    //     "/uploadFoundImage?id=$id&userEmail=$username", result.path);
    // print(res);
    await _sendDataBack(image);
  }

  // get the text in the TextField and send it back to the FirstScreen
  Future<void> _sendDataBack(CreateImage data) async {
    widget.getFiles?.add(data);
    print(widget.getFiles ?? []);
    if (widget.lawstate != null)
    {
      lawenforcementCubit.addAttchment(widget.getFiles ?? []);
    }
    else if (widget.createoundstate != null)
    {
      createFoundArticleCubit.addAttchment(widget.getFiles ?? []);
    }
    else if (widget.createpassmgmtstate != null)
    {
      if (widget.isPhotoType ?? false)
      {
      createpassmgmtCubit.photoAttchment(widget.getFiles ?? []);
      }
      else
      {

      createpassmgmtCubit.addAttchment(widget.getFiles ?? []);
      }

    } else if (widget.inwardState != null) {

    }
  
    //Navigator.pop(context, textToSendBack);
  }

  Future<void> _askPermission(FileDocumnets documnets) async {
    if (documnets == FileDocumnets.Camera) {
      _askCameraPermission();
    } else if (documnets == FileDocumnets.Photo) {
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
    if (await Permission.mediaLibrary.request().isGranted ||
        await Permission.photos.request().isGranted ||
        await Permission.photosAddOnly.request().isGranted) {
      _status = await Permission.photos.status;
      _getFromGallery();
    } else {
      _updateStatus(await Permission.photos.status);
    }
  }

  _updateStatus(PermissionStatus value) {
    print(value);
    if (value != _status) {
      setState(() {
        _status = value;
      });
    }
    if (value == PermissionStatus.denied ||
        value == PermissionStatus.permanentlyDenied) {
      AppSettings.openNotificationSettings();
    }
  }

  showImagePicker(BuildContext context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Card(
               child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:150,
                  margin: const EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(
                      left: 12, top: 0, right: 12, bottom: 12),
               
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, top: 5, right: 10, bottom: 10),
                          alignment: Alignment.topLeft,
                          child: const Text(
                            Constants.caotureorupload,
                            style: Styles.textStyleRegularGrey16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: const ShapeDecoration(
                                    color: AppColors.lightgreyBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                          bottom: Radius.circular(20.0)),
                                    )),
                                child: InkWell(
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcon.galleryIcon,
                                        width: 36,
                                        height: 36,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _askPermission(FileDocumnets.Photo);
                                    Navigator.pop(context);
                                  },
                                ),
                              )),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: const ShapeDecoration(
                                    color: AppColors.lightgreyBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                          bottom: Radius.circular(20.0)),
                                    )),
                                child: InkWell(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcon.cameraIcon,
                                          width: 36,
                                          height: 36,
                                        ),
                                        //  ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _askPermission(FileDocumnets.Camera);
                                    Navigator.pop(context);
                                  },
                                ),
                              )),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(20.0),
                                decoration: const ShapeDecoration(
                                    color: AppColors.lightgreyBackground,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0),
                                          bottom: Radius.circular(20.0)),
                                    )),
                                child: InkWell(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcon.documentsIcon,
                                          width: 36,
                                          height: 36,
                                        ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    _getDocumentFileslist();
                                    Navigator.pop(context);
                                  },
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )));
        }).then((value) {
      Navigator.pop(context);
    });
  }
}
