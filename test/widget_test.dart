import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meu_app/main.dart';
import 'package:meu_app/screens/alerts_screen.dart';
import 'package:meu_app/screens/home_screen.dart';
import 'package:meu_app/screens/main_navigation_screen.dart';
import 'package:meu_app/screens/map_screen.dart';

void main() {
  testWidgets('navega da Splash Screen para o Login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sinaliza.Ai'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Criar conta'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.text('Entrar na sua conta'), findsOneWidget);
    expect(find.text('Entrar'), findsOneWidget);
  });

  testWidgets('valida os campos obrigatórios do Login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Informe sua senha.'), findsOneWidget);
  });

  testWidgets('entra na Home quando o Login é válido', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'julia@email.com');
    await tester.enterText(fields.at(1), 'senha123');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    expect(find.text('Login realizado com sucesso!'), findsOneWidget);
    expect(find.text('Olá, Julia! 👋'), findsOneWidget);
    expect(find.text('Alertas da sua região'), findsOneWidget);
  });

  testWidgets('navega para Cadastro e exige aceite dos termos', (
    WidgetTester tester,
  ) async {
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

  testWidgets('exibe os cards e a navegação da Home', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Olá, Julia! 👋'), findsOneWidget);
    expect(find.text('Trânsito'), findsNothing);
    expect(find.text('Acessibilidade'), findsOneWidget);
    expect(find.text('Abrigos'), findsAtLeastNWidgets(1));
    expect(find.text('Alertas'), findsAtLeastNWidgets(1));
    expect(find.text('Mapa'), findsAtLeastNWidgets(1));
    expect(find.text('Alertas da sua região'), findsOneWidget);
    expect(find.text('Início'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.map_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Buscar endereço'), findsOneWidget);
  });

  testWidgets('busca e seleciona um ponto mockado no Mapa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MapScreen()));

    expect(find.text('Semáforo Av. Paulista'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Rua Augusta');
    await tester.pump();

    expect(find.text('Semáforo Rua Augusta'), findsOneWidget);
    await tester.tap(find.text('Semáforo Rua Augusta'));
    await tester.pump();

    expect(find.text('Semáforo Rua Augusta'), findsOneWidget);
  });

  testWidgets('filtra os alertas por categoria', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AlertsScreen()));

    expect(find.text('Risco de enchente'), findsOneWidget);
    expect(find.text('Trânsito intenso'), findsOneWidget);
    expect(find.text('Manutenção'), findsOneWidget);

    await tester.tap(find.text('Enchentes'));
    await tester.pump();

    expect(find.text('Risco de enchente'), findsOneWidget);
    expect(find.text('Trânsito intenso'), findsNothing);
    expect(find.text('Manutenção'), findsNothing);

    await tester.tap(find.text('Todos'));
    await tester.pump();

    expect(find.text('Trânsito intenso'), findsOneWidget);
    expect(find.text('Manutenção'), findsOneWidget);
  });

  testWidgets('mantém as cinco telas principais no host de navegação', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigationScreen()));

    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Mapa'), findsNWidgets(2));
    expect(find.text('Abrigos'), findsNWidgets(2));
    expect(find.text('Alertas'), findsNWidgets(2));
    expect(find.text('Perfil'), findsOneWidget);

    await tester.tap(find.text('Mapa').last);
    await tester.pump();
    expect(find.text('Buscar endereço'), findsOneWidget);

    await tester.tap(find.text('Abrigos').last);
    await tester.pump();
    expect(find.text('Próximos'), findsOneWidget);

    await tester.tap(find.text('Alertas').last);
    await tester.pump();
    expect(find.text('Todos'), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pump();
    expect(find.text('Meu perfil'), findsOneWidget);

    await tester.tap(find.text('Início'));
    await tester.pump();
    expect(find.text('Olá, Julia! 👋'), findsOneWidget);
  });

  testWidgets('abre detalhes a partir do marcador e preserva o mapa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigationScreen()));

    await tester.tap(find.text('Mapa').last);
    await tester.pump();
    await tester.tap(find.byIcon(Icons.location_on).first);
    await tester.pumpAndSettle();

    expect(find.text('Semáforo'), findsOneWidget);
    expect(find.text('Av. Paulista, 1573'), findsOneWidget);
    expect(find.text('Status atual'), findsOneWidget);

    await tester.tap(find.byTooltip('Voltar'));
    await tester.pumpAndSettle();
    expect(find.text('Buscar endereço'), findsOneWidget);
    expect(find.text('Semáforos'), findsOneWidget);
  });
}
