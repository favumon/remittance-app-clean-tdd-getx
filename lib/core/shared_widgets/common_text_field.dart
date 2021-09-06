import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CommonTextField extends StatelessWidget {
  final Map<String, String> Function(FormControl<String>)? validationMessages;

  final String? controlName;

  final void Function()? onSubmitted;

  final String? placeHolderText;

  final TextInputAction? textInputAction;

  final String? prefixText;

  final bool isReadOnly;

  final bool isObscure;

  final Widget? suffix;

  final TextInputType? textInputType;

  final String? hintText;
  final TextStyle? style;

  const CommonTextField({
    this.validationMessages,
    this.controlName,
    this.onSubmitted,
    this.placeHolderText,
    this.textInputAction = TextInputAction.next,
    this.prefixText,
    this.isReadOnly = false,
    this.isObscure = false,
    this.suffix,
    this.hintText,
    this.textInputType,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.yellow,
      child: ReactiveTextField<String>(
          formControlName: controlName,
          validationMessages: validationMessages,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          readOnly: isReadOnly,
          obscureText: isObscure,
          keyboardType: textInputType,
          style: style ??
              TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          inputFormatters: textInputType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            suffixIcon: suffix,
            contentPadding: const EdgeInsets.only(top: 25, bottom: 5),
            // suffixIconConstraints: BoxConstraints(),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: (Theme.of(context).primaryColor as MaterialColor)
                        .shade100)),
            focusedBorder: isReadOnly
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: (Theme.of(context).primaryColor as MaterialColor)
                            .shade100))
                : null,
            labelText: placeHolderText,
            hintText: hintText,
            prefixIconConstraints: BoxConstraints(
              minHeight: 0,
            ),
            prefixIcon: prefixText == null
                ? null
                : SizedBox(
                    width: 120,
                    child: Text(
                      prefixText!,
                      style: TextStyle(
                          color:
                              (Theme.of(context).primaryColor as MaterialColor)
                                  .shade200),
                    ),
                  ),
          )),
    );
  }
}
