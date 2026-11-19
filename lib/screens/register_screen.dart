import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../widgets/app_button.dart';

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
    if (value?.trim().isEmpty ?? true) {
      return 'Informe seu nome completo.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }

    final isValid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return isValid ? null : 'Digite um e-mail válido. Exemplo: nome@email.com.';
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Crie uma senha.';
    }
    return value.length < 8
        ? 'Sua senha precisa ter pelo menos 8 caracteres.'
        : null;
  }

  String? _validateConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha.';
    }
    return value == _passwordController.text
        ? null
        : 'As senhas não são iguais. Tente novamente.';
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    setState(() {
      _hasSubmitted = true;
      _termsError = !_acceptedTerms;
    });

    if (!isValid || !_acceptedTerms) {
      return;
    }

    _showMessage('Cadastro pronto para integração.');
  }

  void _validateAfterEdit(String _) {
    if (_hasSubmitted) {
      _formKey.currentState?.validate();
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.lavenderVeil),
    );

    return InputDecoration(
      labelText: label,
      labelStyle: AppTypography.caption,
      prefixIcon: Icon(icon, size: 18, color: AppColors.darkAmethyst),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.45),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      border: border,
      enabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.hotRose, width: 2),
      ),
      errorBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.nightBordeaux),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: const BorderSide(color: AppColors.nightBordeaux, width: 2),
      ),
      errorStyle: AppTypography.caption.copyWith(
        color: AppColors.nightBordeaux,
      ),
    );
  }

  Widget _passwordVisibilityButton({
    required bool obscureText,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      tooltip: obscureText ? 'Mostrar senha' : 'Ocultar senha',
      onPressed: onPressed,
      icon: Icon(
        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 18,
        color: AppColors.darkAmethyst,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.softBackground,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.softBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.softBackground,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 32,
                  ),
                  child: FocusTraversalGroup(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              tooltip: 'Voltar',
                              onPressed: () => Navigator.of(context).pop(),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                minWidth: 48,
                                minHeight: 48,
                              ),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: AppColors.darkAmethyst,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            'Criar conta',
                            style: AppTypography.heading.copyWith(fontSize: 22),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Preencha seus dados para começar a usar o Sinaliza.Ai.',
                            style: AppTypography.caption.copyWith(fontSize: 13),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            controller: _nameController,
                            focusNode: _nameFocusNode,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: true,
                            enableSuggestions: true,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                _emailFocusNode.requestFocus(),
                            onEditingComplete: () =>
                                _emailFocusNode.requestFocus(),
                            onChanged: _validateAfterEdit,
                            autovalidateMode: _hasSubmitted
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: _validateName,
                            style: AppTypography.body.copyWith(fontSize: 14),
                            decoration: _inputDecoration(
                              label: 'Nome completo',
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            readOnly: false,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                _passwordFocusNode.requestFocus(),
                            onEditingComplete: () =>
                                _passwordFocusNode.requestFocus(),
                            onChanged: _validateAfterEdit,
                            autovalidateMode: _hasSubmitted
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: _validateEmail,
                            style: AppTypography.body.copyWith(fontSize: 14),
                            decoration: _inputDecoration(
                              label: 'E-mail',
                              icon: Icons.mail_outline,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            readOnly: false,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscurePassword,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) =>
                                _confirmPasswordFocusNode.requestFocus(),
                            onEditingComplete: () =>
                                _confirmPasswordFocusNode.requestFocus(),
                            onChanged: _validateAfterEdit,
                            autovalidateMode: _hasSubmitted
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: _validatePassword,
                            style: AppTypography.body.copyWith(fontSize: 14),
                            decoration: _inputDecoration(
                              label: 'Senha',
                              icon: Icons.lock_outline,
                              suffixIcon: _passwordVisibilityButton(
                                obscureText: _obscurePassword,
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocusNode,
                            readOnly: false,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureConfirmation,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            onEditingComplete: _submit,
                            onChanged: _validateAfterEdit,
                            autovalidateMode: _hasSubmitted
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            validator: _validateConfirmation,
                            style: AppTypography.body.copyWith(fontSize: 14),
                            decoration: _inputDecoration(
                              label: 'Confirmar senha',
                              icon: Icons.lock_outline,
                              suffixIcon: _passwordVisibilityButton(
                                obscureText: _obscureConfirmation,
                                onPressed: () => setState(
                                  () => _obscureConfirmation =
                                      !_obscureConfirmation,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: _acceptedTerms,
                                activeColor: AppColors.hotRose,
                                onChanged: (value) => setState(() {
                                  _acceptedTerms = value ?? false;
                                  if (_acceptedTerms) {
                                    _termsError = false;
                                  }
                                }),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Aceito os ',
                                      style: AppTypography.caption,
                                      children: [
                                        TextSpan(
                                          text: 'Termos de Uso',
                                          style: AppTypography.caption.copyWith(
                                            color: AppColors.hotRose,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          recognizer: _termsRecognizer,
                                        ),
                                        const TextSpan(text: ' e a '),
                                        TextSpan(
                                          text: 'Política de Privacidade',
                                          style: AppTypography.caption.copyWith(
                                            color: AppColors.hotRose,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          recognizer: _privacyRecognizer,
                                        ),
                                        const TextSpan(text: '.'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (_termsError)
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 2),
                              child: Text(
                                'Você precisa aceitar os Termos de Uso e a '
                                'Política de Privacidade para continuar.',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.nightBordeaux,
                                ),
                              ),
                            ),
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            child: AppButton(
                              text: 'Cadastrar',
                              onPressed: _submit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
