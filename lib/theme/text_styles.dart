import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppTextStyles {
  static final h1 = GoogleFonts.montserrat(
    color: AppColors.dark,
    fontSize: 24,
  );
  static final hed = GoogleFonts.montserrat(
    color: AppColors.bg,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );
  static final nohed = GoogleFonts.montserrat(
    color: AppColors.bg,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static final buttom1 = GoogleFonts.montserrat(
    color: Color(0x019AF6),
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static final buttom2 = GoogleFonts.montserrat(
    color: AppColors.bg,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}