// onboarding_screen.dart
import 'package:e_commerce/auth/screens/login_screen.dart';
import 'package:e_commerce/onboarding/bloc/onboarding_bloc.dart';
import 'package:e_commerce/onboarding/bloc/onboarding_event.dart';
import 'package:e_commerce/onboarding/bloc/onboarding_state.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/onboarding/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  final int pageIndex;

  const OnboardingScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> onboardingData = [
      {
        'imagePath': 'assets/onboarding1.png',
        'title': 'Find the item you\'ve\n been looking for',
        'description':
            'Here you\'ll see rich varieties of goods,\ncarefully classified for seamless browsing\n experience',
      },
      {
        'imagePath': 'assets/onboarding2.png',
        'title': 'Get those shopping\n bags filled',
        'description':
            'Add any item you want to your cart or save\n it on your wishlist, so you don\'t miss it in\n your future purchase.',
      },
      {
        'imagePath': 'assets/onboarding3.png',
        'title': 'Fast & Secure\npayment',
        'description':
            'There are many payment options available\n to speed up an simplify your payment\n process.',
      },
    ];

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: OnboardingWidget(
                  imagePath: onboardingData[state.pageIndex]['imagePath']!,
                  title: onboardingData[state.pageIndex]['title']!,
                  description: onboardingData[state.pageIndex]['description']!,
                ),
              ),
              // Button under the description
              Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ), // Padding top and bottom
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress indicator
                    SizedBox(
                      width: 84, // Adjusted to match border-radius
                      height: 84, // Adjusted to match border-radius
                      child: CircularProgressIndicator(
                        value:
                            (state.pageIndex + 1) /
                            3, // Progress based on screen index
                        strokeWidth: 2,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.button,
                        ),
                      ),
                    ),
                    // Circular button with icon
                    Container(
                      width: 62, // Button width
                      height: 62, // Button height
                      decoration: BoxDecoration(
                        color: AppColors.button, // Button background color
                        shape: BoxShape.circle, // Circular shape
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward, // Use any icon you prefer
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (state.pageIndex < 2) {
                            context.read<OnboardingBloc>().add(NextPageEvent());
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
