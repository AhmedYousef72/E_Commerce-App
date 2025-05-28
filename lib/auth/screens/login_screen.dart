import 'package:e_commerce/auth/bloc/auth_bloc.dart';
import 'package:e_commerce/auth/bloc/auth_event.dart';
import 'package:e_commerce/auth/screens/register_screen.dart';
import 'package:e_commerce/auth/widgets/forget_password_popup.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

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
                'Login to your\n account.',
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

              // Forgot Password Text
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
              SizedBox(height: 16),

              // Login Button
              CustomButton(
                text: 'Login',
                onPressed: () {
                  context.read<AuthBloc>().add(
                    LoginEvent(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                backgroundColor: AppColors.button,
                textColor: Colors.white,
              ),
              SizedBox(height: 18),
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
              SizedBox(height: 18),

              // Google Button
              CustomButton(
                text: "Continue with Google",
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: AppColors.primaryColor,
                borderRadius: 30,
                icon: Image.asset("assets/google.png", width: 24, height: 24),
              ),
              SizedBox(width: 16),

              // Facebook Button
              CustomButton(
                text: 'Continue with Facebook',
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: AppColors.primaryColor,
                borderRadius: 30,
                icon: Icon(Icons.facebook, color: Colors.blue, size: 28),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
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
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
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
