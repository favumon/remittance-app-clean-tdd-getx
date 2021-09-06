import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';
import 'package:remittance_app/core/shared_widgets/button_outlined.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/intro_slider/controllers/intro_slider_page_controller.dart';
import 'package:remittance_app/feature/intro_slider/widgets/slide_tile.dart';

class IntroSlider extends StatelessWidget {
  final PageController controller = PageController();
  final IntroSliderPageController _controller =
      Get.put(getIt<IntroSliderPageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    _controller.changeSlider(index);
                  },
                  children: _controller.sliderList
                      .map<Widget>(
                        (item) => SlideTile(item),
                      )
                      .toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _controller.sliderList.length; i++)
                  Obx(
                    () => i == _controller.slideIndex.value
                        ? _buildPageIndicator(true)
                        : _buildPageIndicator(false),
                  )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .4,
                  child: ButtonOutlined(
                    onTapped: () {
                      _controller.navigateToSignIn();
                    },
                    buttonText: 'sign_in'.tr,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .4,
                  child: ButtonNormal(
                    onTapped: () {
                      _controller.navigateToRegister();
                    },
                    buttonText: 'register'.tr,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
