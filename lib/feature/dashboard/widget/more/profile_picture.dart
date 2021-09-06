import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    required this.size,
    this.imagePath,
    this.changeProfilePicture = false,
    this.borderColor = Colors.white,
    this.iconColor = Colors.white,
  });

  final Color borderColor, iconColor;
  final double size;
  final String? imagePath;
  final bool changeProfilePicture;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: InkWell(
        onTap: changeProfilePicture
            ? () {
                print('change profile');
              }
            : null,
        child: Stack(
          children: [
            imagePath != null
                ? Container(
                    height: size,
                    width: size,
                    child: Image.network(
                      imagePath ?? '',
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: 1),
                    ),
                    child: Icon(
                      Icons.person,
                      color: iconColor,
                      size: size * .88,
                    ),
                  ),
            if (changeProfilePicture)
              Positioned(
                bottom: 0.0,
                left: 0,
                right: 0,
                child: Container(
                  height: 20,
                  color: Colors.transparent.withOpacity(.4),
                  child: Text(
                    'edit'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
