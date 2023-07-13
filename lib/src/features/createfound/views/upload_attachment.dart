import 'dart:io';

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
import 'package:db_atom/src/features/createfound/models/attachment_model.dart';
import 'package:db_atom/src/utils/app_themes/colors/app_color.dart';
import 'package:db_atom/src/utils/app_themes/styles/app_styles.dart';
import 'package:db_atom/src/utils/helpers/keys/keys.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

enum FileDocumnets { Photo, Camera, Documents }

class UploadAttachment extends StatefulWidget {
  const UploadAttachment({super.key});

  @override
  State<UploadAttachment> createState() => UploadAttachmentState();
}

class UploadAttachmentState extends State<UploadAttachment>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  PlatformFile? file;
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

    // Scaffold(
    // appBar: AppHeader(
    //   isTitleCenter: false,
    //   title: Constants.createfound,
    //   backBtn: IconButton(
    //     onPressed: () {
    //       Navigator.pop(context);
    //     },
    //     icon: SvgPicture.asset(AppIcon.backIcon, color: AppColors.backgroundWhitecolor),
    //   ),
    //   action: [
    //     CustomPopmenu(
    //       itemList: const [
    //         // PopMenuItems("Export Excel", AppIcon.exportexcel),
    //         // PopMenuItems("Export PDF", AppIcon.exportpdf),
    //         // PopMenuItems("Export XML", AppIcon.exportxml),
    //         // PopMenuItems("Close", AppIcon.close),
    //       ],
    //       itemTap: (value) {
    //         print(value);
    //       },
    //       popupimagename: AppIcon.createfoundsaveicon,
    //     ),
    //   ],
    // backgroundColor: AppColors.navigationSkybluecolor,
    // leading: IconButton(
    //   icon: const Icon(Icons.arrow_back_ios,
    //       color: AppColors.backgroundWhitecolor),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // ),
    // ),
    // backgroundColor: AppColors.backgroundWhitecolor,
    // body: Container(
    //     color: AppColors.navigationSkybluecolor,
    //     child: SingleChildScrollView(
    //         child: Column(children: [
    //       Container(
    //         height: height * 0.01,
    //         color: AppColors.navigationSkybluecolor,
    //       ),
    //       Container(
    //         padding: const EdgeInsets.all(20.0),
    //         decoration: const ShapeDecoration(
    //             color: AppColors.backgroundWhitecolor,
    //             shape: RoundedRectangleBorder(
    //               borderRadius:
    //                   BorderRadius.vertical(top: Radius.circular(20.0)),
    //             )),
    //         child: Form(
    //             key: _formKey,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.max,
    //               children: [

    //                 Container(
    //                   alignment: Alignment.topLeft,
    //                   child: const Text(
    //                     Constants.uploadfile,
    //                     style: Styles.textStyleBlack16,
    //                   ),
    //                 ),
    //                 _image != null || file != null
    //                     ? Padding(
    //                         padding: const EdgeInsets.only(
    //                             left: 0, top: 20, right: 0),
    //                         child:
    //ClipRRect(
    //borderRadius: BorderRadius.circular(20.0),
    //   DottedBorder(
    // borderType: BorderType.RRect,
    // radius: Radius.circular(20),
    // dashPattern: [5, 5],
    // color: Colors.black,
    // strokeWidth: 1,
    // child: ClipRRect(
    //     borderRadius: BorderRadius.circular(20.0),
    //     child: FittedBox(
    //         fit: BoxFit.fill,
    //         child: Stack(children: [
    //           _image != null
    //               ? Image.file(
    //                   //width: width,
    //                   // height : 150,
    //                   _image!)
    //               : Image.asset(
    //   AppIcon.materialmovement,
    //   width: width - 40,
    //   height: 150,
    // ),

    // Positioned(
    //     top: _image != null ? 20 : 2,
    //     right: _image != null
    //         ? 35
    //         : 5, //give the values according to your requirement
    //     child: GestureDetector(
    //       onTap: () {
    //         print(
    //             "Icon Button clicked");
    //         _image = null;
    //         file = null;
    //         setState(() {});
    //       },
    //       child: Container(
    //         decoration:
    //             const ShapeDecoration(
    //                 color: AppColors
    //                     .backgroundWhitecolor,
    //                 shape:
    //                     RoundedRectangleBorder(
    //               borderRadius: BorderRadius
    //                   .all(Radius
    //                       .circular(
    //                           50.0)),
    //             )),
    //     child: SvgPicture.asset(
    //         AppIcon.closeicon,
    //         width: (_image != null
    //             ? 50
    //             : 25)), //Icon(Icons.cancel,size: (_image != null ? 50 :25),),
    //     // onPressed: () {

    //     // },
    //   ),
    // )),
    //     const  Align(
    //   alignment: Alignment.topRight,
    //   child: Icon(
    //     size:20,
    //     Icons.cancel,
    //     color: Colors.red,
    //   ),
    // ),
    // )
    //child: FlutterLogo(size: 180,),
    //               ]))),
    //     ))
    // :
    //Container(),

    // CommonWidgets.verticalSpacerWidget(height * 0.01),
    // imageDisplay(),
    //CommonWidgets.verticalSpacerWidget(height * 0.01),
    // Container(
    //     height: 60,
    //     decoration: BoxDecoration(
    //         border: Border.all(
    //           color: Color(0xFFCACACA),
    //           width: 1.0,
    //         ),
    //         borderRadius: const BorderRadius.all(
    //             Radius.circular(8))),
    //     child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Padding(
    //             padding:
    //                 const EdgeInsets.only(right: 5.0),
    //             child: ElevatedButton.icon(
    //               style: ElevatedButton.styleFrom(
    //                   fixedSize: const Size(140, 50)),
    //               onPressed: () {
    //_askPermission(Documnets.Photo);
    // showImagePicker(context);
    //       },
    //       icon: SvgPicture.asset(
    //   //AppIcon.dropdownicon,
    //   AppIcon.uploadicon,
    //   //fit: BoxFit.,
    //   color: AppColors.backgroundWhitecolor,
    //   width: 13,
    //   height: 13,
    //   key: const Key(Keys.userIcon),
    // ),
    // const Icon(
    //   // <-- Icon
    //   Icons.upload,
    //   color: AppColors.backgroundWhitecolor,
    //   size: 24.0,
    // ),
    //                         label: const Text(
    //                           Constants.clicktoupload,
    //                           style:
    //                               Styles.textStyleRegularNormalWhite12,
    //                         ), // <--/ <-- Text
    //                             ),
    //                           ),
    //                         ]),
    //                   ),
    //            // CommonWidgets.verticalSpacerWidget(height * 0.03),
    //             //buttonViews(context, width),
    //           ],
    //         )),
    //   ),
    // ]))));
  }

  // Widget buttonViews(BuildContext context, double width) {
  //   return Container(
  //     color: AppColors.backgroundWhitecolor,
  //     child: Row(
  //       //mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[cancelButton(width), saveButton(width)],
  //     ),
  //   );
  // }

  // Widget cancelButton(double width) {
  //   return PopButton(
  //     width: width / 2.5,
  //     key: const Key(Keys.cancelButton),
  //     buttonText: Constants.cancel,
  //     buttonTextKey: Keys.cancelButtonText,
  //     foregroundColor: AppColors.textgreyThemecolor,
  //     textStyle: Styles.styleHeaderGreyText16,
  //     boardercolor: AppColors.textgreyThemecolor,
  //     onTap: () {
  //       //loginFormKey.currentState!.validate();
  //       FocusScope.of(context).unfocus();
  //       try {
  //         // final ValidLoginDetails validLoginDetails =
  //         //     ValidLoginDetails(userName: username, password: password);
  //         // widget.onValidLogin(validLoginDetails);
  //         //Navigator.pushNamed(context, homePageRoute);
  //         Navigator.of(context).pop();
  //       } catch (e) {
  //         // present userwith error message
  //       }
  //     },
  //   );
  // }

  // Widget saveButton(double width) {
  //   return PopButton(
  //     width: width / 2.5,
  //     key: const Key(Keys.saveButton),
  //     buttonText: Constants.save,
  //     buttonTextKey: Keys.saveButtonText,
  //     boardercolor: AppColors.navigationSkybluecolor,
  //     backgroundColor: AppColors.navigationSkybluecolor,
  //     foregroundColor: Colors.white,
  //     textStyle: Styles.textStyleSemiBold16White,
  //     onTap: () {
  //       //loginFormKey.currentState!.validate();
  //       FocusScope.of(context).unfocus();
  //       try {
  //         // final ValidLoginDetails validLoginDetails =
  //         //     ValidLoginDetails(userName: username, password: password);
  //         // widget.onValidLogin(validLoginDetails);
  //         //Navigator.pushNamed(context, homePageRoute);
  //       } catch (e) {
  //         // present userwith error message
  //       }
  //     },
  //   );
  // }

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
      setState(() {
        _image = imageFile;
      });

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
      // setState(() {
      //   _image = imageFile;
      // });

      getpath(imageFile);
    }
  }

  _getDocumentFileslist() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //File files = File(result.files.first);
      file = result.files.first;

      //showLoadingDialog(context);
      print(result.paths);
      print(file?.path ?? '');
      // setState(() {});
      //String fileName = result.paths.sp split('/').last;
      ///String fileName = identifierId + '_' + connectorId.toString() + ".png";
      AttachmentModel model =
          AttachmentModel(fullpath: file?.path ?? '', name: file?.name ?? '');
      _sendDataBack(model);
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
      // PlatformFile file = result.files.first;

      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      //showLoadingDialog(context);
      print(result.path);
      String fileName = result.path.split('/').last;
      //String fileName = identifierId + '_' + connectorId.toString() + ".png";
      //uploadaws(result.path, fileName);
      // _sendDataBack(context, fileName);
      AttachmentModel model =
          AttachmentModel(fullpath: result.path, name: fileName);
      // createFoundArticleCubit.addAttchment(model);
     var res = ImagesMultiPart().uploadImage("https://api.integration.dbatom.arlanto.com/api/atomrestservice/uploadFoundImage?id=14",result.path);
      print(res);
      _sendDataBack(model);
    } else {
      // User canceled the picker
    }
  }

  // get the text in the TextField and send it back to the FirstScreen
  _sendDataBack(AttachmentModel data) {
    createFoundArticleCubit.addAttchment(data);
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
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
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
                  )));
        }).then((value) => Navigator.pop(context));
  }
}
