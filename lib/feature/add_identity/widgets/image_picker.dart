import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';

class ImagePicker extends StatelessWidget {
  final ReactiveFormFieldState<IdImage, IdImage> field;

  final void Function()? onTap;

  final String placeHolderText;
  const ImagePicker(
      {this.onTap, required this.field, required this.placeHolderText});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: (field.touched && field.errorText != null)
                      ? Colors.red
                      : (Theme.of(context).primaryColor as MaterialColor)
                          .shade100)),
          child: Row(
            children: [
              SvgPicture.asset(AssetImages.imageUpload),
              SizedBox(
                width: 10,
              ),
              Text(field.value?.toString() ?? placeHolderText),
            ],
          ),
        ),
      ),
    );
  }
}
