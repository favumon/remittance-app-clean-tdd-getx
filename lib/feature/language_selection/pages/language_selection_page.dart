import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;

import '../../../di_injection/injection_container.dart';
import '../controllers/language_selection_page_controller.dart';

class LanguageSelectionPage extends StatelessWidget {
  final LanguageSelectionPageController _controller =
      Get.put(getIt<LanguageSelectionPageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LanguageSelectionPageController>(
            init: Get.put(getIt()),
            initState: (state) {
              _controller.getSelectionList();
            },
            builder: (controller) {
              return Container(
                  height: double.infinity,
                  color: Colors.white,
                  child: languageSelectionList(controller));
            }));
  }

  Widget languageSelectionList(LanguageSelectionPageController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [languageIcon(), languageTitle(), languageItem(controller)],
      ),
    );
  }

  Widget languageItem(LanguageSelectionPageController controller) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.selectionModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              controller
                  .onLanguageSelected(controller.selectionModelList[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFFFAFAFB),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.selectionModelList[index],
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                    color: (Theme.of(context).primaryColor
                                            as MaterialColor)
                                        .shade400),
                          )),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Icon(Icons.check, color: Color(0xFFE14F47)))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget languageIcon() {
    return Padding(
        padding: const EdgeInsets.only(top: 85.0),
        child: SvgPicture.asset(
          image.AssetImages.languaeSelectionIcon,
          width: 100,
          height: 100,
        ));
  }

  Widget languageTitle() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                "Language",
                style: TextStyle(
                    color: Color(0xFF505054),
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    fontSize: 22),
              )),
        ),
        Align(
            child: Text(
          "Select your prefered language from",
          style: TextStyle(
              color: Color(0xFF505054),
              decoration: TextDecoration.none,
              fontSize: 18),
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              child: Text(
            'the list of above',
            style: TextStyle(
                color: Color(0xFF505054),
                decoration: TextDecoration.none,
                fontSize: 18),
          )),
        )
      ],
    );
  }
}
