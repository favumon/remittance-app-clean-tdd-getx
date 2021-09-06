import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitThreeBounce(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
