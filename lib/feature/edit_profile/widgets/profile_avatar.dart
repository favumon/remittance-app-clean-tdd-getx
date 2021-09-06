import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=250&w=760'),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 25,
                width: double.infinity,
                color: Colors.black.withOpacity(.85),
                alignment: Alignment.center,
                child: Text(
                  'edit'.tr,
                  style: TextStyle(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ))),
      ),
    );
  }
}
