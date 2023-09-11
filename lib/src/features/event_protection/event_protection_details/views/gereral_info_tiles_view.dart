import 'package:flutter/material.dart';

import '../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../common_widgets/base_widget/base_tile.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/router.dart';
import '../../../../utils/app_themes/colors/app_color.dart';

class GeneralInfoTilesView extends StatefulWidget {
  const GeneralInfoTilesView({super.key});

  @override
  State<GeneralInfoTilesView> createState() => _GeneralInfoTilesViewState();
}

class _GeneralInfoTilesViewState extends State<GeneralInfoTilesView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.generalInformation,
        showPopUp: true,
        showSaveButton: false,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, generalInfoGIRoute);
                  },
                  child: Tile(
                    label: 'Info',
                    height: height,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, generalInfoCIRoute);
                  },
                  child: Tile(
                    label: 'Contact Info',
                    height: height,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
