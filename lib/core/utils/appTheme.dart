import 'package:flutter/material.dart';

class AppTheme {
  static bool isLightTheme = true;
  static Color primaryColor = HexColor("#5d5b6a");
  static Color primaryColorLight = HexColor("#cfb495");
  static Color primaryColorDark = HexColor("#5d5b6a");

  static Color primaryTextColor = HexColor("#5d5b6a");

  static Color secondaryColor = HexColor("#5d5b6a");
  static Color secondaryColorLight = HexColor("#2d4163");
  static Color secondaryTextColor = HexColor("#5d5b6a");

  static Color borderColor = HexColor("#D3D3D3");

  static TextTheme _buildTextTheme(TextTheme base) {
    var fontName = "Gilroy"; // define in asssets

    return base.copyWith(
      headline6: base.headline6
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      headline5: base.headline5
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      headline4: base.headline4
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      headline3: base.headline3
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      headline2: base.headline2
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      headline1: base.headline1
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      bodyText2: base.bodyText2
          ?.copyWith(color: primaryTextColor, fontFamily: fontName),
      bodyText1: base.bodyText1
          ?.copyWith(color: primaryTextColor, fontFamily: fontName),
      subtitle2: base.subtitle2?.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1
          ?.copyWith(color: primaryTextColor, fontFamily: fontName),
      button: base.headline6
          ?.copyWith(color: secondaryTextColor, fontFamily: fontName),
      caption: base.headline6
          ?.copyWith(color: primaryTextColor, fontFamily: fontName),
      overline: base.headline6
          ?.copyWith(color: primaryTextColor, fontFamily: fontName),
    );
  }

  static ThemeData getTheme() {
    if (isLightTheme) {
      return newLightTheme();
    } else {
      return newDarkTheme();
    }
  }

  static ThemeData newLightTheme() {
    // Color color1 = primaryColor;
    // Color color2 = secondaryColor;
    // final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    //   primary: color1,
    //   secondary: color2,
    // );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      // colorScheme: colorScheme,

      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      accentColor: secondaryColor,

      cursorColor: secondaryTextColor,
      buttonColor: secondaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,

      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFF7F9FC),
      iconTheme: IconThemeData(color: secondaryColor),
      scaffoldBackgroundColor: Color(0xfff5f5f5),
      errorColor: Colors.red,
      sliderTheme: SliderThemeData(
        activeTrackColor: AppTheme.primaryColorDark,
        inactiveTrackColor: AppTheme.primaryColorDark.withOpacity(0.2),
        thumbColor:AppTheme.primaryColorDark

      ),
      buttonTheme: ButtonThemeData(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
    );
  }

  static ThemeData newDarkTheme() {
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: primaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      buttonColor: secondaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.accent,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
