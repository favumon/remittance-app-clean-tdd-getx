import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CommonDatePickerField extends StatelessWidget {
  final dynamic validationMessages;

  final String? controlName;

  final void Function()? onSubmitted;

  final String? placeHolderText;

  final TextInputAction? textInputAction;

  final String? prefixText;

  final bool isReadOnly;

  final Widget? suffix;
  final String dateFormat;

  final void Function()? onTap;

  final DateTime firstDate;
  final DateTime lastDate;

  const CommonDatePickerField(
      {this.validationMessages,
      this.controlName,
      this.onSubmitted,
      this.placeHolderText,
      this.textInputAction = TextInputAction.next,
      this.prefixText,
      this.isReadOnly = false,
      this.suffix,
      this.onTap,
      this.dateFormat = 'dd MMM yyyy',
      required this.firstDate,
      required this.lastDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.yellow,
      child: ReactiveTextField<DateTime>(
          formControlName: controlName,
          validationMessages: validationMessages,
          onSubmitted: onSubmitted,
          onTap: onTap,
          textInputAction: textInputAction,
          readOnly: isReadOnly,
          valueAccessor: DateTimeValueAccessor(
            dateTimeFormat: DateFormat(dateFormat),
          ),
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
          decoration: InputDecoration(
            suffixIcon: ReactiveDatePicker(
              firstDate: firstDate,
              lastDate: lastDate,
              initialDatePickerMode: DatePickerMode.year,
              formControlName: controlName,
              builder: (context, picker, child) => IconButton(
                onPressed: picker.showPicker,
                icon: Icon(
                  Icons.date_range,
                  color: (Theme.of(context).primaryColor as MaterialColor),
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(top: 25, bottom: 5),
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
