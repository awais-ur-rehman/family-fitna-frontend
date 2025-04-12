import 'package:flutter/material.dart';
import '../../../config/theme.dart';

enum LoadingSize { small, medium, large }

class AppLoadingIndicator extends StatelessWidget {
  final LoadingSize size;
  final Color? color;

  const AppLoadingIndicator({
    Key? key,
    this.size = LoadingSize.medium,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeValue;
    switch (size) {
      case LoadingSize.small:
        sizeValue = 16.0;
        break;
      case LoadingSize.medium:
        sizeValue = 24.0;
        break;
      case LoadingSize.large:
        sizeValue = 40.0;
        break;
    }

    return Center(
      child: SizedBox(
        height: sizeValue,
        width: sizeValue,
        child: CircularProgressIndicator(
          strokeWidth: size == LoadingSize.small ? 2.0 : 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}