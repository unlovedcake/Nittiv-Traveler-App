import 'package:flutter/material.dart';

abstract class NittivColors {
  static const background = Color(0xffffffff);

  static const primaryGreen = MaterialColor(_primaryGreenValue, _primaryGreen);
  static const primaryBlue = MaterialColor(_primaryBlueValue, _primaryBlue);
  static const secondaryGreen = MaterialColor(_secondaryGreenValue, _secondaryGreen);
  static const secondaryBlue = MaterialColor(_secondaryBlueValue, _secondaryBlue);
  static const base = MaterialColor(_baseValue, _base);

  static const _primaryGreenValue = 0xff008575;
  static const Map<int, Color> _primaryGreen = <int, Color>{
    50: Color(0xffE0F0EE),
    100: Color(0xff66B6AC),
    200: Color(0xff4DAA9E),
    300: Color(0xff339D91),
    400: Color(0xff1A9183),
    500: Color(_primaryGreenValue),
    600: Color(0xff007869),
    700: Color(0xff006A5E),
    800: Color(0xff005D52),
    900: Color(0xff005046),
  };

  static const _primaryBlueValue = 0xff00C9D6;
  static const Map<int, Color> _primaryBlue = <int, Color>{
    50: Color(0xffE0F9FA),
    100: Color(0xff66DFE6),
    200: Color(0xff4DD9E2),
    300: Color(0xff33D4DE),
    400: Color(0xff1ACEDA),
    500: Color(_primaryBlueValue),
    600: Color(0xff00B5C1),
    700: Color(0xff00A1AB),
    800: Color(0xff008D96),
    900: Color(0xff007980),
  };
  static const _secondaryGreenValue = 0xff00B38C;
  static const Map<int, Color> _secondaryGreen = <int, Color>{
    50: Color(0xffE0F6F1),
    100: Color(0xff66D1BA),
    200: Color(0xff4DCAAF),
    300: Color(0xff33C2A3),
    400: Color(0xff1ABB98),
    500: Color(_secondaryGreenValue),
    600: Color(0xff00A17E),
    700: Color(0xff008F70),
    800: Color(0xff007D62),
    900: Color(0xff006B54),
  };
  static const _secondaryBlueValue = 0xff00A9B4;
  static const Map<int, Color> _secondaryBlue = <int, Color>{
    50: Color(0xffE0F5F6),
    100: Color(0xff66CBD2),
    200: Color(0xff4DC3CB),
    300: Color(0xff33BAC3),
    400: Color(0xff1AB2BC),
    500: Color(_secondaryBlueValue),
    600: Color(0xff0098A2),
    700: Color(0xff008790),
    800: Color(0xff00767E),
    900: Color(0xff00656C),
  };

  static const _baseValue = 0xffAAAAAA;
  static const Map<int, Color> _base = <int, Color>{
    50: Color(0xffF5F5F5),
    100: Color(0xffFFFFFF),
    200: Color(0xffF8F8FA),
    300: Color(0xffF0F0F0),
    400: Color(0xffD0D0D0),
    500: Color(_baseValue),
    600: Color(0xff646464),
    700: Color(0xff3B3B3B),
    800: Color(0xff141514),
    900: Color(0xff000000),
  };

  static const _tertiaryBlueValue = 0xff95A3FF;
  static const tertiaryBlue = Color(_tertiaryBlueValue);

  static const _tertiaryRedValue = 0xffFF95A3;
  static const tertiaryRed = Color(_tertiaryRedValue);

  static const _tertiaryYellowValue = 0xffFFF195;
  static const tertiaryYellow = Color(_tertiaryYellowValue);

  static const _tertiaryGreenValue = 0xffA3FF95;
  static const tertiaryGreen = Color(_tertiaryGreenValue);

  static const _tertiaryOrangeValue = 0xffFFBC95;
  static const tertiaryOrange = Color(_tertiaryOrangeValue);

  static const _tertiaryPurpleValue = 0xffBC95FF;
  static const tertiaryPurple = Color(_tertiaryPurpleValue);
}
