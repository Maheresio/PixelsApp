import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData get theme => ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),

  scaffoldBackgroundColor: AppColors.kBackgroundColor,
  colorScheme: ColorScheme.light(
    primary: AppColors.kPrimary,
    error: AppColors.kErrorColor,
    onPrimary: AppColors.kLightBlack,
    secondary: AppColors.kGrey,
    onSecondary: AppColors.kwhite,
    onTertiary: AppColors.kSuccessColor,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.kwhite,

    border: OutlineInputBorder(borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kPrimary),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kErrorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.kErrorColor),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      ),

      foregroundColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.pressed)
            ? AppColors.kPrimary
            : AppColors.kBlack;
      }),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.kPrimary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      foregroundColor: WidgetStatePropertyAll(AppColors.kwhite),
      overlayColor: WidgetStatePropertyAll(Colors.redAccent),
    ),
  ),

  dividerTheme: DividerThemeData(color: AppColors.kPrimary),
);
