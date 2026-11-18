import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meu_app/main.dart';

void main() {
  testWidgets('exibe a Splash Screen e encerra o carregamento',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Sinaliza.Ai'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Mobilidade inteligente, cidades mais seguras.'),
        findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
