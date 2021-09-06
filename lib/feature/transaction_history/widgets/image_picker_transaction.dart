import 'package:flutter/material.dart';

import 'package:reactive_forms/reactive_forms.dart';

import 'package:domain/feature/transaction_history/entities/reference_image.dart';

class ImagePickerTransaction extends StatelessWidget {
  final ReactiveFormFieldState<ReferenceImage, ReferenceImage> field;

  final void Function()? onTap;

  final String placeHolderText;
  const ImagePickerTransaction(
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
              Icon(Icons.attach_file_sharp),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  field.value?.imageName ?? placeHolderText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
