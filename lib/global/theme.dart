import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GlobalThemData {
  // const colors
  static Color lightFocusColor = Colors.black.withOpacity(0.12);
  static Color textFieldFillColor = const Color(0xffdadada);

  static ColorScheme lightColorScheme = const ColorScheme(
    primary: Color(0xffe43e3a),
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    error: Color(0xffe43e3a),
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.light,
  );

  static ThemeData themeData(
      BuildContext context, ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      useMaterial3: true,
      dropdownMenuTheme: const DropdownMenuThemeData(
        textStyle: TextStyle(color: Colors.black),
      ),
      textTheme: GoogleFonts.inriaSansTextTheme(
        TextTheme(
          // body medium text
          bodyMedium: TextStyle(
            color: const Color(0xff1B1B1B),
            fontSize: 15.sp,
          ),

          // body large text
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 21.sp,
            fontFamily: "Segoe UI",
            fontWeight: FontWeight.bold,
          ),

          titleMedium: TextStyle(
            color: const Color(0xff272A2E),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),

          // title large text
          titleLarge: TextStyle(
            color: const Color(0xffe43e3a),
            fontSize: 22.sp,
            fontFamily: "Segoe UI",
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
