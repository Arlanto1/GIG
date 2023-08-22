import 'package:flutter/material.dart';
import 'package:db_atom/src/constants/constants.dart';
import '../../routing/router.dart';
import '../../utils/app_themes/styles/app_styles.dart';

class GuardingRectangle extends StatefulWidget {
  const GuardingRectangle({Key? key}) : super(key: key);

  @override
  State<GuardingRectangle> createState() => _GuardingRectangleState();
}

class _GuardingRectangleState extends State<GuardingRectangle> {
  @override
  Widget build(BuildContext context) {
    return buildTwoColumnLayout();
  }

  Widget buildTwoColumnLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, guardingRatesGRIRoute,
                    arguments: {
                      "title": Constants.createGuardingRatingCards,

                    });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/dollar.png',
                text: Constants.guardingRatingInformation,
                bottomPadding: 8,
              ),
            ),
            const SizedBox(width: 19),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, guardingRatesSSRoute,
                    arguments: {
                      "title": Constants.createSecurityGuard,

                    });
              },
              child: buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Guard',
                bottomPadding: 22,
              ),
            ),
          ],
        ),
        const SizedBox(height: 19), // Add spacing between the columns
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, guardingRatesSSRoute,
                arguments: {
                  "title": Constants.createGuardingRatingCards,

                });
          },
          child: Row(
            children: [
              buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Supervisor',
                // Add the text
                bottomPadding: 22,
              ),
              const SizedBox(width: 19), // Add some spacing between the boxes
              buildRectangleBox(
                imageAsset: 'assets/images/security.png',
                text: 'Security Officer',
                bottomPadding: 22,
              ),
            ],
          ),
        ),
        const SizedBox(height: 19),
        Row(
          children: [
            buildRectangleBox(
              imageAsset: 'assets/images/security.png',
              text: 'Security Facilitator',
              bottomPadding: 22,
            ),
            const SizedBox(width: 19), // Add some spacing between the boxes
            buildRectangleBox(
              imageAsset: 'assets/images/securityGunMan.png',
              text: 'Gun Man',
              bottomPadding: 22,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRectangleBox({
    required String imageAsset,
    required String text,
    required double bottomPadding,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.42,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            spreadRadius: 1.0,
            blurRadius: 4.0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              imageAsset,
              width: 69,
              height: 110,
            ),
          ),
          Positioned(
            bottom: bottomPadding, // Use the provided bottom padding
            left: 0,
            right: 0,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Styles.styleHeaderGreyText16,
            ),
          ),
        ],
      ),
    );
  }
}
