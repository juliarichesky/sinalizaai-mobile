import 'package:flutter_test/flutter_test.dart';

import 'package:meu_app/main.dart';

void main() {
  testWidgets('navega da Splash Screen para o Login',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sinaliza.Ai'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Entrar na sua conta'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('valida os campos obrigatórios do Login',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
  });

  testWidgets('navega para Cadastro e exige aceite dos termos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cadastre-se'));
    await tester.pumpAndSettle();

    expect(find.text('Criar conta'), findsOneWidget);

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    expect(find.text('Informe seu nome completo.'), findsOneWidget);
    expect(
      find.text(
        'Você precisa aceitar os Termos de Uso e a '
        'Política de Privacidade para continuar.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();

    expect(find.text('Entrar na sua conta'), findsOneWidget);
  });
}
