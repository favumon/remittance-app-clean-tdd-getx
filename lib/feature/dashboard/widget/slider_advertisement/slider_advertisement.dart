import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/widget/slider_advertisement/controllers/slider_advertisement_controller.dart';

class SliderAdvertisement extends StatefulWidget {
  @override
  _SliderAdvertisementState createState() => _SliderAdvertisementState();
}

class _SliderAdvertisementState extends State<SliderAdvertisement> {
  final _controller = Get.put(getIt<SliderAdvertisementController>());

  // List bannerList = [
  //   image.AssetImages.bannerDashboard,
  //   image.AssetImages.bannerDashboard,
  //   image.AssetImages.bannerDashboard
  // ];

  List<T> map<T>(List list, Function handle) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handle(i, list[i]));
    }
    return result;
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: true,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xFFE5E6E9)),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index, _) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      height: 130.0,
                      viewportFraction: 1.0,
                      //  aspectRatio: 2.0,
                      enlargeCenterPage: false,
                      autoPlay: true,
                    ),
                    // height: 130.0,
                    // initialPage: 0,
                    // enlargeCenterPage: false,
                    // autoPlay: true,
                    // reverse: false,
                    // viewportFraction: 1.0,
                    // enableInfiniteScroll: true,
                    // autoPlayInterval: Duration(seconds: 20),
                    // autoPlayAnimationDuration: Duration(milliseconds: 1500),
                    // pauseAutoPlayOnTouch: Duration(seconds: 10),
                    // scrollDirection: Axis.horizontal,
                    // onPageChanged: (index) {
                    //   setState(() {
                    //     _currentIndex = index;
                    //   });
                    // },
                    items: _controller.silderList.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () => _controller.openAd(item),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(item.imageUrl,
                                  fit: BoxFit.fill),
                            ),
                          );
                        },
                      );
                    }).toList()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 110.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(_controller.silderList, (index, url) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color(0xFFEF6336)
                          : Color(0xFFE5E6E9),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
