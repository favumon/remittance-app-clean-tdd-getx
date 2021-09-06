import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationDetailsHeader extends StatelessWidget {
  final String imagePath;

  final String statusText;

  final String statusTextInDetail;

  const NotificationDetailsHeader({
    required this.imagePath,
    required this.statusText,
    required this.statusTextInDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            imagePath,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            statusText,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            statusTextInDetail,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
          )
        ],
      ),
    );
  }
}
