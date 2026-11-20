import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/validation/auth_validators.dart';
import '../widgets/app_snackbar.dart';
import '../widgets/auth_input_decoration.dart';
import 'main_navigation_screen.dart';
import 'register_screen.dart';
import '../widgets/app_button.dart';
import '../services/local_auth_service.dart';

part 'login/login_content.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    return AuthValidators.email(value);
  }

  String? _validatePassword(String? value) {
    return AuthValidators.loginPassword(value);
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      await LocalAuthService.instance.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on LocalAuthException catch (error) {
      if (!mounted) return;
      AppSnackBar.show(context, error.message, type: AppSnackBarType.error);
      return;
    }
    if (!mounted) return;
    AppSnackBar.show(
      context,
      'Login realizado com sucesso!',
      type: AppSnackBarType.success,
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const MainNavigationScreen()),
    );
  }

  void _openRegister() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterScreen()));
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  @override
  Widget build(BuildContext context) => _buildContent(context);
}
