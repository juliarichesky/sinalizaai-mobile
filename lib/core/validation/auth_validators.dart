abstract final class AuthValidators {
  static final RegExp _emailPattern = RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  );

  static String? fullName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Informe seu nome completo.';
    }
    return null;
  }

  static String? email(String? value, {bool includeExample = false}) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Informe seu e-mail.';
    }
    if (_emailPattern.hasMatch(email)) {
      return null;
    }
    return includeExample
        ? 'Digite um e-mail válido. Exemplo: nome@email.com.'
        : 'Informe um e-mail válido.';
  }

  static String? loginPassword(String? value) {
    return value == null || value.isEmpty ? 'Informe sua senha.' : null;
  }

  static String? newPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Crie uma senha.';
    }
    return value.length < 8
        ? 'Sua senha precisa ter pelo menos 8 caracteres.'
        : null;
  }

  static String? passwordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirme sua senha.';
    }
    return value == password
        ? null
        : 'As senhas não são iguais. Tente novamente.';
  }
}
