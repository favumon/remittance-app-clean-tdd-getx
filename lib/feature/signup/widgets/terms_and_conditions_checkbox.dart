import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsCheckbox extends StatefulWidget {
  final void Function(bool?) onChanged;

  const TermsAndConditionsCheckbox(this.onChanged);

  @override
  _TermsAndConditionsCheckboxState createState() =>
      _TermsAndConditionsCheckboxState();
}

class _TermsAndConditionsCheckboxState
    extends State<TermsAndConditionsCheckbox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (value) {
            setState(() {
              this.value = value ?? false;
              widget.onChanged(value);
            });
          },
          value: value,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'i_accept_terms_and_conditions'.tr,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
