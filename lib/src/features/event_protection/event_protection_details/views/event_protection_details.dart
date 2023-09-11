import 'package:flutter/material.dart';

import '../../../../common_widgets/base_widget/base_app_bar.dart';
import '../../../../common_widgets/base_widget/base_tile.dart';
import '../../../../constants/constants.dart';
import '../../../../routing/router.dart';
import '../../../../utils/app_themes/colors/app_color.dart';

class EventProtectionDetails extends StatefulWidget {
  const EventProtectionDetails({super.key});

  @override
  State<EventProtectionDetails> createState() => _EventProtectionDetailsState();
}

class _EventProtectionDetailsState extends State<EventProtectionDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    return Scaffold(
      backgroundColor: AppColors.cardBgColor,
      appBar: BaseAppBar().buildAppHeader(
        context: context,
        title: Constants.eventProtectionTitle,
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
                  onTap: (){
                    Navigator.pushNamed(context, generalInfoTilesViewRoute);
                  },
                  child: Tile(
                    label: 'General Info',
                    height: height,
                  ),
                ),
                Tile(
                  label: 'Before the Event Information',
                  height: height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
