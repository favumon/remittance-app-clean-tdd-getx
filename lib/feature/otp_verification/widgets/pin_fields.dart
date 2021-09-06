import 'package:flutter/material.dart';
import 'package:remittance_app/feature/otp_verification/widgets/single_pin_textfield.dart';

class PinFields extends StatefulWidget {
  final void Function(String value) onSubmit;

  PinFields({required this.onSubmit});

  @override
  _PinFieldsState createState() => _PinFieldsState();
}

class _PinFieldsState extends State<PinFields> {
  List<FocusNode> foucsNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
    foucsNodes[0].requestFocus();
  }

  @override
  dispose() {
    super.dispose();
  }

  requestOrRemoveFocus(int index) {
    if (controllers[index].text.isNotEmpty) {
      foucsNodes[index].nextFocus();
    } else {
      foucsNodes[index].previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SinglePinTextField(
          focusNode: foucsNodes[0],
          controller: controllers[0],
          onChanged: () => requestOrRemoveFocus(0),
        ),
        SinglePinTextField(
          focusNode: foucsNodes[1],
          controller: controllers[1],
          onChanged: () => requestOrRemoveFocus(1),
        ),
        SinglePinTextField(
          focusNode: foucsNodes[2],
          controller: controllers[2],
          onChanged: () => requestOrRemoveFocus(2),
        ),
        SinglePinTextField(
          focusNode: foucsNodes[3],
          controller: controllers[3],
          onChanged: () => requestOrRemoveFocus(3),
        ),
        SinglePinTextField(
          focusNode: foucsNodes[4],
          controller: controllers[4],
          onChanged: () => requestOrRemoveFocus(4),
        ),
        SinglePinTextField(
          focusNode: foucsNodes[5],
          controller: controllers[5],
          onChanged: () => requestOrRemoveFocus(5),
        ),
      ],
    );
  }
}
