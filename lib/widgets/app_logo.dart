import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Image.asset(
          'assets/splashIcon.png',
          width: size * 0.6,
          height: size * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}
