// lib/widgets/forget_password_popup.dart
import 'package:e_commerce/auth/screens/otp_screen.dart';
import 'package:e_commerce/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/constants/colors.dart';

void showForgetPasswordPopup(BuildContext context) {
  final TextEditingController emailController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Forget Password',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: AppColors.title,
              ),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              'Select which contact details should we use to reset your password',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 16),

            // Email Section
            Text(
              'Send via Email',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 8),

            // Email Text Field
            CustomTextField(
              suffixIcon: Icon(Icons.email_outlined),
              hintText: 'Enter your email',
              controller: emailController,
            ),
            SizedBox(height: 24),

            // Send Button
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isNotEmpty) {
                  Navigator.pop(context); // Close the bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpScreen(email: email),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid email')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 56), // Full-width button
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
