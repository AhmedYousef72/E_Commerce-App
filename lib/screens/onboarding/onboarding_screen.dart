import 'package:e_commerce/cubits/onboarding/onboarding_cubit.dart';
import 'package:e_commerce/models/onboarding_content.dart';
import 'package:e_commerce/screens/auth/login_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/onboarding1.png',
      title: 'Find the item you\'ve been looking for',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel odio en urna ultricies.',
    ),
    OnboardingContent(
      image: 'assets/onboarding2.png',
      title: 'Get those shopping bags filled',
      description:
          'Explore what you want to buy and add to your shopping cart.',
    ),
    OnboardingContent(
      image: 'assets/onboarding3.png',
      title: 'Fast & Secure payment',
      description: 'Proceed to payment with secure payment methods.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    context.read<OnboardingCubit>().goToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(content: _contents[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return PageIndicator(
                        count: _contents.length,
                        currentIndex: state.currentPage,
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      final isLastPage =
                          state.currentPage == _contents.length - 1;
                      return CustomButton(
                        text: isLastPage ? 'Get Started' : 'Next',
                        onPressed: () {
                          if (isLastPage) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(content.image, height: 240),
          const SizedBox(height: 40),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            content.description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
