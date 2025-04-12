import 'package:flutter/material.dart';
import '../../../config/theme.dart';

enum ButtonType { primary, secondary, tertiary }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonType type;
  final double width;
  final double height;
  final IconData? icon;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.type = ButtonType.primary,
    this.width = double.infinity,
    this.height = 48,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    final isDisabledOrLoading = isDisabled || isLoading;

    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isDisabledOrLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.5),
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.secondary:
        return OutlinedButton(
          onPressed: isDisabledOrLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.primaryColor,
            side: BorderSide(color: isDisabledOrLoading
                ? AppTheme.primaryColor.withOpacity(0.5)
                : AppTheme.primaryColor),
          ),
          child: _buildButtonContent(),
        );
      case ButtonType.tertiary:
        return TextButton(
          onPressed: isDisabledOrLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.primaryColor,
          ),
          child: _buildButtonContent(),
        );
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: 2.0,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}