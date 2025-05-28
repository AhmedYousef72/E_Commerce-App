// lib/constants/text_styles.dart
import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle get onboardingTitle => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600, // Weight 600
    fontSize: 28, // Size 28
    color: AppColors.title, // Use the color from AppColors
  );

  static TextStyle get onboardingDescription => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400, // Weight 400
    fontSize: 14, // Size 14
    color: AppColors.textColor,
    // Use the color from AppColors
  );
  static TextStyle get title => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.125,
    color: AppColors.textColor,
  );

  static TextStyle get body => GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textColor,
  );

  // Input styles
  static final TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.darkGray,
  );

  static final TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.inputGray,
  );

  static final TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.mediumGray,
  );
  static TextStyle heading1 = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.125, // Line height 36px / 32px = 1.125
  );

  // Body text
  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  // Labels
  static TextStyle labelMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Links
  static TextStyle link = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static TextStyle linkBold = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Button text
  static TextStyle buttonText = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static TextStyle socialButtonText = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
