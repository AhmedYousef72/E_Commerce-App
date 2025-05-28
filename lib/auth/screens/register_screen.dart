import 'package:e_commerce/auth/bloc/auth_bloc.dart';
import 'package:e_commerce/auth/bloc/auth_event.dart';
import 'package:e_commerce/auth/screens/login_screen.dart';
import 'package:e_commerce/auth/widgets/forget_password_popup.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              SizedBox(height: 64),
              Text(
                'Create your new\n account',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  height: 1.125,
                  color: AppColors.title,
                ),
              ),
              SizedBox(height: 32),

              // Email Text Field
              CustomTextField(
                hintText: 'Email address',
                controller: emailController,
              ),
              SizedBox(height: 16),

              // Password Text Field with Eye Icon
              TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.textColor,
                    ),
                    onPressed: () {
                      isPasswordVisible = !isPasswordVisible;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Confirm Password Text Field with Eye Icon
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !isConfirmPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColors.textColor,
                    ),
                    onPressed: () {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    showForgetPasswordPopup(context);
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Register Button
              CustomButton(
                text: 'Register',
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    context.read<AuthBloc>().add(
                      RegisterEvent(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                },
                backgroundColor: AppColors.button,
                textColor: Colors.white,
              ),
              SizedBox(height: 18),

              // "or continue with"
              Center(
                child: Text(
                  "or continue with",
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Google Button
              CustomButton(
                text: "Continue with Google",
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: AppColors.primaryColor,
                borderRadius: 30,
                icon: Image.asset("assets/google.png", width: 24, height: 24),
              ),
              SizedBox(height: 10),

              // Facebook Button
              CustomButton(
                text: 'Continue with Facebook',
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: AppColors.primaryColor,
                borderRadius: 30,
                icon: Icon(Icons.facebook, color: Colors.blue, size: 28),
              ),
              SizedBox(height: 12),

              // "Already have an account? Login"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
