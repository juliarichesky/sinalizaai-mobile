import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/validation/auth_validators.dart';
import '../services/local_auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snackbar.dart';
import 'register/register_sections.dart';
import 'register/register_text_field.dart';

part 'register/register_content.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _termsRecognizer = TapGestureRecognizer();
  final _privacyRecognizer = TapGestureRecognizer();

  bool _hasSubmitted = false;
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;
  bool _acceptedTerms = false;
  bool _termsError = false;

  @override
  void initState() {
    super.initState();
    _termsRecognizer.onTap = () =>
        _showMessage('Os Termos de Uso ainda não estão disponíveis.');
    _privacyRecognizer.onTap = () =>
        _showMessage('A Política de Privacidade ainda não está disponível.');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    return AuthValidators.fullName(value);
  }

  String? _validateEmail(String? value) {
    return AuthValidators.email(value, includeExample: true);
  }

  String? _validatePassword(String? value) {
    return AuthValidators.newPassword(value);
  }

  String? _validateConfirmation(String? value) {
    return AuthValidators.passwordConfirmation(
      value,
      _passwordController.text,
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _hasSubmitted = true;
      _termsError = !_acceptedTerms;
    });

    if (!isValid || !_acceptedTerms) {
      return;
    }

    try {
      await LocalAuthService.instance.register(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on LocalAuthException catch (error) {
      if (!mounted) return;
      _showMessage(error.message);
      return;
    }
    if (!mounted) return;
    _showMessage('Cadastro realizado com sucesso!');
    Navigator.of(context).pop();
  }

  void _validateAfterEdit(String _) {
    if (_hasSubmitted) {
      _formKey.currentState?.validate();
    }
  }

  void _showMessage(String message) {
    AppSnackBar.show(context, message);
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleConfirmationVisibility() {
    setState(() => _obscureConfirmation = !_obscureConfirmation);
  }

  void _updateTermsAcceptance(bool value) {
    setState(() {
      _acceptedTerms = value;
      if (_acceptedTerms) {
        _termsError = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) => _buildContent(context);
}
