// lib/screens/otp_screen.dart
import 'package:e_commerce/auth/widgets/success_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_commerce/constants/colors.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  int _resendTimer = 30; // Timer in seconds
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
        _startResendTimer();
      } else {
        setState(() {
          _isTimerActive = false;
        });
      }
    });
  }

  void _resendCode() {
    setState(() {
      _resendTimer = 30;
      _isTimerActive = true;
    });
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // OTP Image
            Image.asset(
              'assets/OTP.png', // Replace with your OTP image path
              width: 120,
              height: 120,
            ),
            SizedBox(height: 24),

            // Title
            Text(
              'Verification Code',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: AppColors.title,
              ),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              'We have sent the code verification to you\nEmail: ${widget.email}',
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 32),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  width: 60,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Resend Timer or Resend Button
            _isTimerActive
                ? Text(
                  'Resend code in $_resendTimer seconds',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textColor,
                  ),
                )
                : TextButton(
                  onPressed: _resendCode,
                  child: Text(
                    'Resend Code',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            SizedBox(height: 32),

            // Continue Button
            ElevatedButton(
              onPressed: () {
                // Validate OTP and show success modal
                final otp = _otpControllers.map((c) => c.text).join();
                if (otp.length == 4) {
                  // Simulate OTP validation
                  if (otp == "1234") {
                    // Replace with actual OTP validation logic
                    showSuccessModal(context); // Show success modal
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Invalid OTP')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid OTP')),
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
          ],
        ),
      ),
    );
  }
}
