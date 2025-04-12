import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/auth/forgot_password_cubit.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _validateInput() {
    setState(() {
      _emailError = Validators.validateEmail(_emailController.text);
    });

    if (_emailError == null) {
      _resetPassword();
    }
  }

  void _resetPassword() {
    FocusScope.of(context).unfocus();
    context.read<ForgotPasswordCubit>().forgotPassword(_emailController.text.trim());
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
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password reset email sent successfully')),
            );
            Navigator.of(context).pop();
          } else if (state is ForgotPasswordError) {
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
                Text(
                  'Forgot Password',
                  style: AppTheme.heading1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your email and we\'ll send you a link to reset your password',
                  style: AppTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                AppTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  errorText: _emailError,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() => _emailError = null),
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 32),

                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return AppButton(
                      text: 'Send Reset Link',
                      isLoading: state is ForgotPasswordLoading,
                      onPressed: _validateInput,
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