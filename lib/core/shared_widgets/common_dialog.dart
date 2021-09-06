import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    required this.child,
    this.icon,
  }) : super(key: key);

  final Widget child;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.05, 0.05],
            colors: [Theme.of(context).primaryColor, Colors.white],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -30,
              child: icon == null
                  ? Container()
                  : CircleAvatar(
                      radius: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: icon),
                      ),
                    ),
            ),
            Container(
              margin: icon == null
                  ? EdgeInsets.only(top: 10)
                  : EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(15.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
