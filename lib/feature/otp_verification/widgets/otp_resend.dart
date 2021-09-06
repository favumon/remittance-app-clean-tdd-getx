import 'package:flutter/material.dart';

class OtpResend extends StatelessWidget {
  final Function() onResendOtp;

  const OtpResend(this.onResendOtp);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
      tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
      duration: Duration(minutes: 1),
      builder: (context, value, child) {
        return Container(
          child: value == Duration.zero
              ? TextButton(onPressed: onResendOtp, child: Text('Resend Code'))
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(_timerString(value),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black54))),
        );
      },
    );
  }

  String _timerString(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}s';
  }
}
