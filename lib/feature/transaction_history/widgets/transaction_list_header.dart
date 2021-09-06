import 'package:flutter/material.dart';

class TransactionListHeader extends StatelessWidget {
  const TransactionListHeader(this.heading, {Key? key}) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(heading),
      ),
    );
  }
}
