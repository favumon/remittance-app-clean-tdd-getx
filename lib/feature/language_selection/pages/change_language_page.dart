import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/feature/language_selection/controllers/change_language_page_controller.dart';

import '../../../di_injection/injection_container.dart';

class ChangeLanguagePage extends StatelessWidget {
  final ChangeLanguagePageController _controller =
      Get.put(getIt<ChangeLanguagePageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.dark,
      ),
      body:
          // GetBuilder<ChangeLanguagePageController>(
          //   init: Get.put(getIt()),
          //   initState: (state) {
          //     _controller.getSelectionList();
          //   },
          //   builder: (controller) {
          //     return Container(
          //       height: double.infinity,
          //       color: Colors.white,
          //       child:

          languageSelectionList(_controller),
      //     );
      //   },
      // ),
    );
  }

  Widget languageSelectionList(ChangeLanguagePageController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [languageIcon(), languageTitle(), languageItem(controller)],
      ),
    );
  }

  Widget languageItem(ChangeLanguagePageController controller) {
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
                      Obx(() => _controller.p.value ==
                              _controller.selectionModelList[index]
                          ? Align(
                              alignment: Alignment.center,
                              child:
                                  Icon(Icons.check, color: Color(0xFFE14F47)))
                          : Container())
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
                'language'.tr,
                style: TextStyle(
                    color: Color(0xFF505054),
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                    fontSize: 22),
              )),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              'select_your_language_from_the_list_of_below'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFF505054),
                  decoration: TextDecoration.none,
                  fontSize: 18),
            )),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Align(
        //       child: Text(
        //     'the list of below',
        //     style: TextStyle(
        //         color: Color(0xFF505054),
        //         decoration: TextDecoration.none,
        //         fontSize: 18),
        //   )),
        // )
      ],
    );
  }
}
