import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final bool isOutlined;
  final bool isFullWidth;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.buttonBackground,
    this.textColor = Colors.white,
    this.height = 56,
    this.borderRadius = 28,
    this.icon,
    this.isOutlined = false,
    this.isFullWidth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle =
        isOutlined
            ? OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              minimumSize: Size(isFullWidth ? double.infinity : 0, height),
            )
            : ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              minimumSize: Size(isFullWidth ? double.infinity : 0, height),
            );

    final textStyle = AppTextStyles.buttonText.copyWith(
      color: isOutlined ? AppColors.textPrimary : textColor,
    );

    final buttonChild = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 12)],
        Text(text, style: textStyle),
      ],
    );

    return isOutlined
        ? OutlinedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: buttonChild,
        )
        : ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: buttonChild,
        );
  }
}
