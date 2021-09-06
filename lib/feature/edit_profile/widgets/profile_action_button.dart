import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileActionButton extends StatelessWidget {
  final String buttonText;

  final void Function() onTap;

  const ProfileActionButton({required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.only(top: 5),
      child: Text(
        buttonText,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(color: Color(0xFFE32523)),
      ),
      onPressed: onTap,
    );
  }
}
