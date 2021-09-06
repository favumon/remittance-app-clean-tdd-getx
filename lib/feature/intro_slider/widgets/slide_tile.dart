import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:domain/feature/intro_slider/entites/slider_item.dart';

class SlideTile extends StatelessWidget {
  final SliderItem sliderItem;

  SlideTile(this.sliderItem);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 8),
            SvgPicture.asset(sliderItem.imagePath),
            SizedBox(
              height: 40,
            ),
            Text(
              sliderItem.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w700, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              sliderItem.desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black,
                    height: 1.6,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
