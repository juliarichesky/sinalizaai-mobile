part of '../register_screen.dart';

extension on _RegisterScreenState {
  Widget _buildContent(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/home_register_img.png',
              fit: BoxFit.cover,
            ),
            SafeArea(
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
                              RegisterHeader(
                                onBack: () => Navigator.of(context).pop(),
                              ),
                              const SizedBox(height: 18),
                              RegisterTextField(
                                controller: _nameController,
                                focusNode: _nameFocusNode,
                                label: 'Nome completo',
                                icon: Icons.person_outline,
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
                                hasSubmitted: _hasSubmitted,
                                validator: _validateName,
                              ),
                              const SizedBox(height: 10),
                              RegisterTextField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                label: 'E-mail',
                                icon: Icons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                enableSuggestions: false,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) =>
                                    _passwordFocusNode.requestFocus(),
                                onEditingComplete: () =>
                                    _passwordFocusNode.requestFocus(),
                                onChanged: _validateAfterEdit,
                                hasSubmitted: _hasSubmitted,
                                validator: _validateEmail,
                              ),
                              const SizedBox(height: 10),
                              RegisterTextField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                label: 'Senha',
                                icon: Icons.lock_outline,
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
                                hasSubmitted: _hasSubmitted,
                                validator: _validatePassword,
                                onVisibilityPressed: _togglePasswordVisibility,
                              ),
                              const SizedBox(height: 10),
                              RegisterTextField(
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocusNode,
                                label: 'Confirmar senha',
                                icon: Icons.lock_outline,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscureConfirmation,
                                autocorrect: false,
                                enableSuggestions: false,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) => _submit(),
                                onEditingComplete: _submit,
                                onChanged: _validateAfterEdit,
                                hasSubmitted: _hasSubmitted,
                                validator: _validateConfirmation,
                                onVisibilityPressed:
                                    _toggleConfirmationVisibility,
                              ),
                              const SizedBox(height: 14),
                              RegisterTermsAcceptance(
                                accepted: _acceptedTerms,
                                showError: _termsError,
                                termsRecognizer: _termsRecognizer,
                                privacyRecognizer: _privacyRecognizer,
                                onChanged: _updateTermsAcceptance,
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
          ],
        ),
      ),
    );
  }
}
