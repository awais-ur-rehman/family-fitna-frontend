import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme.dart';
import '../../../config/routes.dart';
import '../../../core/utils/validators.dart';
import '../../blocs/auth/register_cubit.dart';
import '../../blocs/auth/register_state.dart';
import '../../widgets/common/app_button.dart';
import '../../widgets/common/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
      _nameError = Validators.validateName(_nameController.text);
      _emailError = Validators.validateEmail(_emailController.text);
      _passwordError = Validators.validatePassword(_passwordController.text);

      if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match';
      } else {
        _confirmPasswordError = null;
      }
    });

    if (_nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      _register();
    }
  }

  void _register() {
    FocusScope.of(context).unfocus();
    context.read<RegisterCubit>().register(
      _nameController.text.trim(),
      _emailController.text.trim(),
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
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.of(context).pushNamed(
              AppRouter.otpVerification,
              arguments: {'email': _emailController.text.trim()},
            );
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Create Account',
                      style: AppTheme.heading1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join the Family Fitna community',
                      style: AppTheme.bodyText2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // Name input
                    AppTextField(
                      label: 'Name',
                      hint: 'Enter your full name',
                      errorText: _nameError,
                      controller: _nameController,
                      onChanged: (_) => setState(() => _nameError = null),
                    ),

                    // Email input
                    AppTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      errorText: _emailError,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) => setState(() => _emailError = null),
                    ),

                    // Password input
                    AppTextField(
                      label: 'Password',
                      hint: 'Create a password',
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
                      hint: 'Confirm your password',
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

                    // Register button
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return AppButton(
                          text: 'Register',
                          isLoading: state is RegisterLoading,
                          onPressed: _validateInputs,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: AppTheme.bodyText2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}