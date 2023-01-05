import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class AppThemeData {
  static final light = ThemeData(
    backgroundColor: AppColors.bg,

    textTheme: TextTheme (headline1: AppTextStyles.h1),
  );
  static final dark = ThemeData(
    backgroundColor: AppColors.bg.withOpacity(0.5),

    textTheme: TextTheme (headline1: AppTextStyles.h1),
  );
}

