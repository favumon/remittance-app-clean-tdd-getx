import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleObscureButton extends StatelessWidget {
  const ToggleObscureButton(this.isTextObscured);

  final RxBool isTextObscured;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: CupertinoButton(
          onPressed: () => isTextObscured.value = !isTextObscured.value,
          child: Text(isTextObscured.value ? 'show'.tr : 'hide'.tr,
              style: TextStyle(
                  color: Color(0xFF0091FF),
                  fontSize: Theme.of(context).textTheme.bodyText1?.fontSize))),
    );
  }
}
