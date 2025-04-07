import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData get theme => ThemeData(
  textTheme: GoogleFonts.latoTextTheme(),

  scaffoldBackgroundColor: AppColors.kBackgroundColor,
  colorScheme: const ColorScheme.light(
    primary: AppColors.kPrimary,
    error: AppColors.kErrorColor,
    onPrimary: AppColors.kLightBlack,
    secondary: AppColors.kGrey,
    onSecondary: AppColors.kwhite,
    onTertiary: AppColors.kSuccessColor,
  ),

  inputDecorationTheme: const InputDecorationTheme(
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
        const EdgeInsets.symmetric(vertical: 16),
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
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.kPrimary),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      foregroundColor: const WidgetStatePropertyAll(AppColors.kwhite),
      overlayColor: const WidgetStatePropertyAll(Colors.redAccent),
    ),
  ),

  dividerTheme: const DividerThemeData(color: AppColors.kPrimary),
);
