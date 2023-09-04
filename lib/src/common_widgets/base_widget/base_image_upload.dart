import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/article_found_register_module/foundlist/models/foundlist_article_details.dart';
import '../../features/createfound/models/create_found_request.dart';
import '../../features/createfound/views/upload_attachment.dart';
import '../../models/entry_security.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';
import '../../utils/helpers/keys/keys.dart';
import '../basic_reusable_widgets.dart';

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
            style:
            ElevatedButton.styleFrom(fixedSize: const Size(140, 50)),
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


  Widget getSpaceattchment({required double height, List<FoundImage>? getAttachments, List<CreateImage>? guardImages}) {
    return getAttachments != null ||
        guardImages != null ||
        guardImages?.length != 0 ||
        getAttachments?.length != 0
        ? CommonWidgets.verticalSpacerWidget(height * 0.01)
        : Container();
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