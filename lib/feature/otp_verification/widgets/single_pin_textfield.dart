import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SinglePinTextField extends StatelessWidget {
  SinglePinTextField(
      {required this.focusNode,
      required this.controller,
      required this.onChanged});

  final FocusNode focusNode;
  final TextEditingController controller;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        enableInteractiveSelection: false,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
        ],
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: new BorderSide(
              color: Colors.red,
            ),
          ),
        ),
        onChanged: (value) {
          print(value);
          int val = int.parse(value.trim());
          this.onChanged();
        },
        autocorrect: false,
        enableSuggestions: false,
      ),
    );
  }
}
