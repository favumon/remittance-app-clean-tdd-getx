import 'package:flutter/material.dart';

class TransactionStatusContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;

  const TransactionStatusContainer(
      {required this.backgroundColor,
      required this.textColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5)),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
