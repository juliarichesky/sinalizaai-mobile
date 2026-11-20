import 'package:flutter_test/flutter_test.dart';
import 'package:sinaliza_ai/services/local_auth_service.dart';

void main() {
  final auth = LocalAuthService.instance;

  setUp(() {
    auth.resetForTesting();
  });

  test('cadastra uma conta e autentica somente com a senha correta', () async {
    final user = await auth.register(
      fullName: 'Ana Souza',
      email: ' ANA@EXEMPLO.COM ',
      password: 'senha-segura',
    );

    expect(user.email, 'ana@exemplo.com');

    final loggedIn = await auth.login(
      email: 'ana@exemplo.com',
      password: 'senha-segura',
    );
    expect(loggedIn.fullName, 'Ana Souza');

    expect(
      () => auth.login(email: 'ana@exemplo.com', password: 'senha-incorreta'),
      throwsA(isA<LocalAuthException>()),
    );
  });

  test('impede cadastro duplicado normalizando o e-mail', () async {
    await auth.register(
      fullName: 'Ana Souza',
      email: 'ana@exemplo.com',
      password: 'senha-segura',
    );

    expect(
      () => auth.register(
        fullName: 'Outra Pessoa',
        email: ' ANA@EXEMPLO.COM ',
        password: 'outra-senha',
      ),
      throwsA(isA<LocalAuthException>()),
    );
  });

  test('restaura a sessão e o logout preserva a conta', () async {
    await auth.register(
      fullName: 'Bruno Lima',
      email: 'bruno@exemplo.com',
      password: 'senha-segura',
    );
    await auth.login(email: 'bruno@exemplo.com', password: 'senha-segura');

    final restored = await auth.restoreSession();
    expect(restored?.email, 'bruno@exemplo.com');

    await auth.logout();
    expect(await auth.restoreSession(), isNull);

    final loggedInAgain = await auth.login(
      email: 'bruno@exemplo.com',
      password: 'senha-segura',
    );
    expect(loggedInAgain.email, 'bruno@exemplo.com');
  });
}
