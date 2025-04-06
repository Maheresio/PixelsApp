import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppStyles {
  static TextStyle base({
    double size = 14,
    FontWeight weight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.montserrat(
      fontSize: size.sp,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle text11Regular = base(size: 11);

  static final TextStyle text14Medium = base(size: 14, weight: FontWeight.w500);

  static final TextStyle text34Bold = base(size: 34, weight: FontWeight.bold);

  // static final TextStyle text10RegularBlack = base(size: 10);
  // static final TextStyle text10SemiBoldBlack = base(size: 10, weight: FontWeight.w600);

  // static final TextStyle text11SemiBoldBlack = base(size: 11, weight: FontWeight.w600);

  // static final TextStyle text14RegularBlack = base(size: 14);
  // static final TextStyle text14SemiBoldBlack = base(size: 14, weight: FontWeight.w600);
  // static final TextStyle text14RegularGrey = base(size: 14, color: AppColors.kGrey);
  // static final TextStyle text14RegularLightBlack = base(size: 14, color: AppColors.kLightBlack);

  // static final TextStyle text15SemiBoldBlack = base(size: 15, weight: FontWeight.w600);

  // static final TextStyle text16RegularBlack = base(size: 16);
  // static final TextStyle text16SemiBoldBlack = base(size: 16, weight: FontWeight.w600);

  // static final TextStyle text18SemiBoldBlack = base(size: 18, weight: FontWeight.w600);

  // static final TextStyle text24SemiBoldBlack = base(size: 24, weight: FontWeight.w600);

  // static final TextStyle text44SemiBoldBlack = base(size: 44, weight: FontWeight.w600);

  // static final TextStyle text48BoldBlack = base(size: 48, weight: FontWeight.bold);
}

//   /// Extra-light.== w200 
//   /// Light. == w300 
//   /// Normal / regular / plain.==== w400 
//   /// Medium.== w500 
//   /// Semi-bold.== w600 
//   /// Bold.== w700 
//   /// Extra-bold.== w800
//   /// Black, the most thick.== w900



// 10 regular /semibold
// 11 regular /semibold
// 14 medium / regular / semibold
// 15 semibold
// 16 semibold / regular
// 18 semibold 
// 24 semibold
// 34 bold
// 44 semibold
// 48 bold





