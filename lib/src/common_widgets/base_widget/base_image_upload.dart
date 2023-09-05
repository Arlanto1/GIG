import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/createfound/models/create_found_request.dart';
import '../../features/createfound/views/upload_attachment.dart';
import '../../features/guarding_operations/guarding_master_data/models/guarding_master_data_model.dart';
import '../../models/entry_security.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';
import '../../utils/helpers/keys/keys.dart';
import '../basic_reusable_widgets.dart';
import '../image_download.dart';

class BaseImageUpload {
  Widget uploadWidget({
    required BuildContext context,
    required EntrySecurity loggedInUserDetails,
    required List<CreateImage>? getFiles,
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
            style: ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
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
              color: AppColors.backgroundWhitecolor,
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
    List<CreateImage>? files,
    List<CreateImage>? attachments,
    required bool showDownloadIcon,
  }) {
    if (attachments != null) {
      return Column(
        children: [
          CommonWidgets.verticalSpacerWidget(height * 0.01),
          attachmentListviews(
            attachmentListviews: files,
            showDownloadIcon: showDownloadIcon,
          ),
        ],
      );
    }

    return Container();
  }

  Widget attachmentListviews({
    List<CreateImage>? attachmentListviews,
    required bool showDownloadIcon,
  }) {
    log('----attachmentListviews-----${attachmentListviews?.length}-----------');

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
            CreateImage? imagedata;
            imagedata = attachmentListviews?[index];

            return Column(
              children: <Widget>[
                ListTile(
                  trailing: showDownloadIcon
                      ? SvgPicture.asset(AppIcon.download,
                          color: AppColors.boldgreyBackground)
                      : const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                  onTap: () {
                    DownloadImage()
                        .saveImage(context, 1230, imagedata?.title ?? '');
                  },
                  title: Text(imagedata?.title ?? ''),
                ),

                const Divider(
                  color: Color(0xFFCACACA),
                  thickness: 1,
                ), //
              ],
            );
          }),
    );
  }

// Widget getAttachement(final List<CreateImage>? guardAttachments, double height) {
//   return (guardAttachments == null ||
//       guardAttachments.isEmpty ||
//       widget.guardingMasterData == null)
//       ? state.guardAttachments?.length == 0 || guardImages == null
//       ? Container()
//       : attachmentListviews(guardImages, getAttachments)
//       : attachmentListviews(guardImages, getAttachments);
// }
}
