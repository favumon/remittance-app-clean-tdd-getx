import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

abstract class Apptheme {
  MaterialColor colorPrimary = const MaterialColor(0xFF23264d, const {
    50: const Color(0xFFe8eaf0),
    100: const Color(0xFFc3c9da),
    200: const Color(0xFF9da6c1),
    300: const Color(0xFF7983a7),
    400: const Color(0xFF5e6995),
    500: const Color(0xFF435086),
    600: const Color(0xFF3d497d),
    700: const Color(0xFF354072),
    800: const Color(0xFF2e3665),
    900: const Color(0xFF23264d)
  });

  get theme => ThemeData(
      primarySwatch: colorPrimary,
      fontFamily: 'Nexa',
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          centerTitle: false,
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
          )),
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 12, height: 1.5),
        bodyText2: TextStyle(fontSize: 15, height: 1.5), //Text
        headline1: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
        headline3: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        headline4: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        overline: TextStyle(fontSize: 10),
        subtitle1: TextStyle(fontSize: 17, height: 1.5), //Textfield
        subtitle2: TextStyle(fontSize: 16, height: 1.5),
      ),
      primaryColor: colorPrimary);
}

//can be generated from https://materialpalettes.com/

@Injectable(as: Apptheme)
class AppThemeImpl extends Apptheme {
  @override
  MaterialColor colorPrimary = const MaterialColor(0xFF23264d, const {
    50: const Color(0xFFe8eaf0),
    100: const Color(0xFFc3c9da),
    200: const Color(0xFF9da6c1),
    300: const Color(0xFF7983a7),
    400: const Color(0xFF5e6995),
    500: const Color(0xFF435086),
    600: const Color(0xFF3d497d),
    700: const Color(0xFF354072),
    800: const Color(0xFF2e3665),
    900: const Color(0xFF23264d)
  });
}
