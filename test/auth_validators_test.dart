import 'package:flutter_test/flutter_test.dart';
import 'package:sinaliza_ai/core/validation/auth_validators.dart';

void main() {
  group('AuthValidators.email', () {
    test('aceita um e-mail válido', () {
      expect(AuthValidators.email(' pessoa@email.com '), isNull);
    });

    test('rejeita valores vazios e formatos inválidos', () {
      expect(AuthValidators.email(''), 'Informe seu e-mail.');
      expect(AuthValidators.email('pessoa@'), 'Informe um e-mail válido.');
    });
  });

  group('AuthValidators.newPassword', () {
    test('exige pelo menos oito caracteres', () {
      expect(
        AuthValidators.newPassword('1234567'),
        'Sua senha precisa ter pelo menos 8 caracteres.',
      );
      expect(AuthValidators.newPassword('12345678'), isNull);
    });
  });

  test('confirmação deve ser igual à senha', () {
    expect(
      AuthValidators.passwordConfirmation('outra', 'senha123'),
      'As senhas não são iguais. Tente novamente.',
    );
    expect(
      AuthValidators.passwordConfirmation('senha123', 'senha123'),
      isNull,
    );
  });
}
