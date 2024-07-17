import 'dart:developer';

import 'package:db_atom/index.dart';

class BaseImageUpload {
  Widget uploadWidget({
    required BuildContext context,
    required User loggedInUserDetails,
    required List<ImageContent>? getFiles,
    required Function onImageSelected,
    bool? isDisabled = false,
  }) {
    return Opacity(
      opacity: isDisabled == true ? .5 : 1,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFCACACA),
              width: 1.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(140, 50),
                backgroundColor: AppColors.navigationSkyBlueColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return UploadAttachment(
                        userdetails: loggedInUserDetails,
                        getFiles: getFiles ?? [],
                        onImageSelected: onImageSelected,
                      );
                    });
              },
              icon: SvgPicture.asset(
                AppIcon.uploadicon,
                colorFilter: const ColorFilter.mode(
                  AppColors.backgroundWhiteColor,
                  BlendMode.srcIn,
                ),
                width: 13,
                height: 13,
                key: const Key(Keys.userIcon),
              ),
              label: const Text(
                Constants.clicktoupload,
                style: Styles.textStyleRegularNormalWhite12,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget getAttachment({
    required double height,
    List<ImageContent>? files,
    List<ImageContent>? attachments,
    required String moduleCode,
    bool? showDeleteIcon = true,
    bool isDisabled = false,
  }) {
    log('-isDisabled-$isDisabled--');
    if (isDisabled) {
      showDeleteIcon = false;
    }
    log('-showDeleteIcon-$showDeleteIcon--');
    if (attachments != null) {
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.01),
          AttachmentListView(
            attachmentListviews: files ?? attachments,
            moduleCode: moduleCode,
            showDeleteIcon: showDeleteIcon,
          ),
        ],
      );
    }

    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}

class AttachmentListView extends StatefulWidget {
  final List<ImageContent>? attachmentListviews;
  final String moduleCode;
  final bool? showDeleteIcon;

  const AttachmentListView({
    super.key,
    this.attachmentListviews,
    required this.moduleCode,
    this.showDeleteIcon,
  });

  @override
  AttachmentListViewState createState() => AttachmentListViewState();
}

class AttachmentListViewState extends State<AttachmentListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFCACACA),
          style: BorderStyle.solid,
          width: 1.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.attachmentListviews?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          ImageContent? imageData = widget.attachmentListviews?[index];
          TextEditingController imageNameController = TextEditingController();
          imageNameController.text = imageData?.title ?? '';

          return Column(
            children: <Widget>[
              ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// View Icon
                    if (imageData?.id != null) ...[
                      GestureDetector(
                        onTap: () {
                          // Add your download functionality here
                          DownloadImage().saveImage(
                              context: context,
                              id: imageData?.id ?? 0,
                              name: imageData?.title ?? '',
                              moduleCode: widget.moduleCode,
                              viewOnly: true);
                        },
                        child: BaseIcons().viewIcon(),
                      ),
                      const SizedBox(width: 10),
                    ],

                    // /// Download Icon
                    // GestureDetector(
                    //   onTap: () {
                    //     // Add your download functionality here
                    //     DownloadImage().saveImage(
                    //       context: context,
                    //       id: imageData?.id ?? 0,
                    //       name: imageData?.title ?? '',
                    //       moduleCode: widget.moduleCode,
                    //     );
                    //   },
                    //   child: BaseIcons().downloadIcon(),
                    // ),

                    /// Delete Icon
                    if (widget.showDeleteIcon == true) ...[
                      IconButton(
                        icon: BaseIcons().deleteIcon(),
                        onPressed: () {
                          // Delete logic here
                          if (imageData != null) {
                            setState(() {
                              widget.attachmentListviews!.removeAt(index);
                            });
                          }
                        },
                      )
                    ],
                    // widget.showDeleteIcon == true
                    //     ? IconButton(
                    //   icon: BaseIcons().deleteIcon(),
                    //   onPressed: () {
                    //     // Delete logic here
                    //     if (imageData != null) {
                    //       setState(() {
                    //         widget.attachmentListviews!.removeAt(index);
                    //       });
                    //     }
                    //   },
                    // )
                    //     : const SizedBox(),
                  ],
                ),
                title: FlutterInputField(
                  controller: imageNameController,
                  textFormKey: Keys.claimantEmpIdTextController,
                  hintText: '',
                  isEnable: widget.showDeleteIcon == true? true:false,
                  isDisableColor: false,
                  onChange: (String value) {
                    imageData?.title = imageNameController.text;
                  },
                  validateTextField: (String? user) {},
                ),
                // title: Text(imageData?.title ?? ''),
              ),
              const Divider(
                color: Color(0xFFCACACA),
                thickness: 1,
              ), //
            ],
          );
        },
      ),
    );
  }
}
