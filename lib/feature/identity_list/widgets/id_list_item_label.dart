import 'package:flutter/material.dart';

class IdListItemLabel extends StatelessWidget {
  final String placeHolder;

  final String text;

  const IdListItemLabel(this.placeHolder, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(placeHolder),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
