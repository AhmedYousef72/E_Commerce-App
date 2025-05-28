// lib/widgets/success_modal.dart
import 'package:e_commerce/onboarding/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/constants/colors.dart';

void showSuccessModal(BuildContext context) {
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
          children: [
            // Success Image
            Image.asset(
              'assets/success.png', // Replace with your success image path
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 24),

            // Title
            Text(
              'Congratulations!',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: AppColors.title,
              ),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              'Your account is ready to use. You will be redirected to the Homepage in a few seconds.',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 32),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the modal
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
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
          ],
        ),
      );
    },
  );
}
