import 'dart:developer';

import 'package:db_atom/src/features/article_found_register_module/foundlist/models/foundlist_model.dart';
import 'package:db_atom/src/features/article_found_register_module/foundlist/services/foundlist_services.dart';
import 'package:flutter/material.dart';

import '../../../../../routing/router.dart';
import '../../../../../utils/app_themes/colors/app_color.dart';
import '../../../../article_found_register_module/foundlist/models/foundlist_article_details.dart';

class ArticleDialog extends StatelessWidget {
  final List<FoundModel> articles;
  final void Function()? leftButtonTap;
  final bool? showLeftButton;

  const ArticleDialog({
    super.key,
    required this.articles,
    required this.leftButtonTap,
    this.showLeftButton,
  });

  @override
  Widget build(BuildContext context) {
    final FoundListServices foundListServices = FoundListServices();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Dialog(
      child: Container(
        height: height / 1.7,
        width: width - 40,
        padding: const EdgeInsets.all(20.0),
        decoration: const ShapeDecoration(
            color: AppColors.backgroundWhitecolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            )),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: showLeftButton ?? false
                  ? IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: leftButtonTap,
                    )
                  : Container(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      articles[index].id.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      NavigatorState nav = Navigator.of(context);
                      FoundListArticleDetails foundArticleDetailsResponse =
                          await foundListServices.getArticleById(
                              articles[index].id!, context);

                      log('-onTap----foundArticleDetailsResponse--${foundArticleDetailsResponse.id}-');
                      nav.pushNamed(createFoundScreenRoute, arguments: {
                        "UserElement": foundArticleDetailsResponse
                      });
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: const Text('Dismiss',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue)),
              onTap: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            )
          ],
        ),
      ),
    );
  }
}
