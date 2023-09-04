import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_icon.dart';
import '../../constants/constants.dart';
import '../../features/createfound/models/create_found_request.dart';
import '../../features/createfound/views/upload_attachment.dart';
import '../../models/entry_security.dart';
import '../../utils/app_themes/colors/app_color.dart';
import '../../utils/app_themes/styles/app_styles.dart';
import '../../utils/helpers/keys/keys.dart';

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

}