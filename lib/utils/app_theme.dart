import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();
  static const Duration overlayAnimDuration = Duration(milliseconds: 500);
  static const int _primaryColor = 0xFFFF6300;
  static const MaterialColor primarySwatch =
  MaterialColor(_primaryColor, <int, Color>{
    50: Color(0xFFFFEFE5),
    100: Color(0xFFFFEFE5),
    200: Color(0xFFFFDFCC),
    300: Color(0xFFFFC19A),
    400: Color(0xFFFFC19A),
    500: Color(0xFFFFA265),
    600: Color(0xFFFFA265),
    700: Color(0xFFFF8331),
    800: Color(0xFFFF8331),
    900: Color(_primaryColor),
  });

  static const int _secondaryColor = 0xFF5C0FD9;
  static const MaterialColor secondarySwatch =
  MaterialColor(_secondaryColor, <int, Color>{
    50: Color(0xFFEEE7FA),
    100: Color(0xFFEEE7FA),
    200: Color(0xFFDECFF6),
    300: Color(0xFFBFA0F0),
    400: Color(0xFFBFA0F0),
    500: Color(0XFF9D6FE9),
    600: Color(0XFF9D6FE9),
    700: Color(0xFF7D3EE4),
    800: Color(0xFF7D3EE4),
    900: Color(_secondaryColor),
  });
  static const Color neutralTertiarySuperLightColor = Color(0xFFF0F3F5);
  static const Color redColor = Color(0xFFE40000);
  static const Color themeColor = Color(0xFFE40000);
  static const Color textlight = Color(0xFF707070);
  static const Color camBackColor = Color(0xBA000000);










}
abstract class Dimension {
  Dimension._();

  static const _scaleFactor = 4.0;
  static const d0 = 0.0;
  static const d0_25 = _scaleFactor * 0.25;
  static const d0_50 = _scaleFactor * 0.50;
  static const d0_75 = _scaleFactor * 0.75;
  static const d1 = _scaleFactor * 1;
  static const d1_50 = _scaleFactor * 1.50;
  static const d2 = _scaleFactor * 2;
  static const d2_50 = _scaleFactor * 2.50;
  static const d3 = _scaleFactor * 3;
  static const d4 = _scaleFactor * 4;
  static const d4_50 = _scaleFactor * 4.50;
  static const d5 = _scaleFactor * 5;
  static const d6 = _scaleFactor * 6;
  static const d7 = _scaleFactor * 7;
  static const d8 = _scaleFactor * 8;
  static const d9 = _scaleFactor * 9;
  static const d10 = _scaleFactor * 10;
  static const d11 = _scaleFactor * 11;
  static const d12 = _scaleFactor * 12;
  static const d13 = _scaleFactor * 13;
  static const d14 = _scaleFactor * 14;
  static const d15 = _scaleFactor * 15;
  static const d16 = _scaleFactor * 16;
  static const d17 = _scaleFactor * 17;
  static const d18 = _scaleFactor * 18;
  static const d19 = _scaleFactor * 19;
  static const d20 = _scaleFactor * 20;
  static const d22 = _scaleFactor * 22;
  static const d24 = _scaleFactor * 24;
  static const d26 = _scaleFactor * 26;
  static const d28 = _scaleFactor * 28;
  static const d30 = _scaleFactor * 30;
  static const d32 = _scaleFactor * 32;
  static const d34 = _scaleFactor * 34;
  static const d36 = _scaleFactor * 36;
  static const d38 = _scaleFactor * 38;
  static const d40 = _scaleFactor * 40;
  static const d44 = _scaleFactor * 44;

  static const d48 = _scaleFactor * 48;
  static const d58 = _scaleFactor * 58;
  static const d60 = _scaleFactor * 60;
  static const d64 = _scaleFactor * 64;
  static const d68 = _scaleFactor * 68;
  static const d82 = _scaleFactor * 82;
  static const d88 = _scaleFactor * 88;
  static const d90 = _scaleFactor * 90;
}
