import 'dart:developer';

import 'package:db_atom/src/models/image_content.dart';
import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/createfound/models/user.dart';
import '../../features/createfound/views/upload_attachment.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';
import '../../utils/helpers/keys/keys.dart';
import '../basic_reusable_widgets.dart';
import '../image_download.dart';

class BaseImageUpload {
  Widget uploadWidget({
    required BuildContext context,
    required User loggedInUserDetails,
    required List<ImageContent>? getFiles,
    required Function onImageSelected,
  }) {
    return Container(
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
              backgroundColor: AppColors.navigationSkybluecolor,
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
              //AppIcon.dropdownicon,
              AppIcon.uploadicon,
              //fit: BoxFit.,
              colorFilter: const ColorFilter.mode(
                AppColors.backgroundWhitecolor,
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
    );
  }

  Widget getAttachment({
    required double height,
    List<ImageContent>? files,
    List<ImageContent>? attachments,
    required bool showDownloadIcon,
  }) {
    // log('----attachments-----${attachments?.length}-----------');
    if (attachments != null) {
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.01),
          _attachmentListviews(
            attachmentListviews: files??attachments,
            showDownloadIcon: showDownloadIcon,
          ),
        ],
      );
    }

    return const SizedBox(
      height: 0,
      width: 0,
    );
  }

  Widget _attachmentListviews({
    List<ImageContent>? attachmentListviews,
    required bool showDownloadIcon,
  }) {
    log('--attachmentListviews--${attachmentListviews?.length}-----');
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
        itemCount: attachmentListviews?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          ImageContent? imageData = attachmentListviews?[index];

          return Column(
            children: <Widget>[
              ListTile(
                trailing: showDownloadIcon
                    ? SvgPicture.asset(
                        AppIcon.download,
                        colorFilter: const ColorFilter.mode(
                          AppColors.backgroundWhitecolor,
                          BlendMode.srcIn,
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      ),
                onTap: () {
                  DownloadImage()
                      .saveImage(context, 1230, imageData?.title ?? '');
                },
                title: Text(imageData?.title ?? ''),
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
