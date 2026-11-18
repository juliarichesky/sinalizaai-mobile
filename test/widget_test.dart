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
}
