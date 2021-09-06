import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';

class AddSignature extends StatelessWidget {
  final String placeHolderText;
  final ReactiveFormFieldState<SignatureImage, SignatureImage> field;

  final void Function()? onTap;
  const AddSignature(
      {this.onTap, required this.placeHolderText, required this.field});

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
              SvgPicture.asset(AssetImages.addSignature),
              SizedBox(
                width: 10,
              ),
              Text(field.value != null ? 'Signature' : placeHolderText),
            ],
          ),
        ),
      ),
    );
  }
}
