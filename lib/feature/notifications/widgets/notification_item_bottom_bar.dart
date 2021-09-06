import 'package:flutter/material.dart';
import 'package:remittance_app/feature/notifications/widgets/transaction_status_container.dart';

class NotificationItemBottomBar extends StatelessWidget {
  const NotificationItemBottomBar(
      {Key? key,
      required this.date,
      required this.colors,
      required this.statusText})
      : super(key: key);

  final String date;
  final Map<String, dynamic> colors;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Color(0xFFE5E6E9),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          TransactionStatusContainer(
            text: statusText,
            backgroundColor: colors['bgColor'],
            textColor: colors['textColor'],
          ),
        ],
      ),
    );
  }
}
