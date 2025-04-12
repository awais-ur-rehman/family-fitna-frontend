import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme.dart';
import '../../../config/routes.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/auth/reset_password_cubit.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';


class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _validateInputs() {
    setState(() {
      _passwordError = Validators.validatePassword(_passwordController.text);

      if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });

    if (_passwordError == null && _confirmPasswordError == null) {
      _resetPassword();
    }
  }

  void _resetPassword() {
    FocusScope.of(context).unfocus();
    context.read<ResetPasswordCubit>().resetPassword(
      widget.token,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset successful')),
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.login,
                  (route) => false,
            );
          } else if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Reset Password',
                  style: AppTheme.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create a new password for your account',
                  style: AppTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Password input
                AppTextField(
                  label: 'New Password',
                  hint: 'Enter your new password',
                  errorText: _passwordError,
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: (_) => setState(() => _passwordError = null),
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppTheme.textSecondaryColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),

                // Confirm Password input
                AppTextField(
                  label: 'Confirm Password',
                  hint: 'Confirm your new password',
                  errorText: _confirmPasswordError,
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  onChanged: (_) => setState(() => _confirmPasswordError = null),
                  suffix: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppTheme.textSecondaryColor,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 32),

                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  builder: (context, state) {
                    return AppButton(
                      text: 'Reset Password',
                      isLoading: state is ResetPasswordLoading,
                      onPressed: _validateInputs,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}