import 'package:app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('debe mostrar el botón "Iniciar Sesión"', (
      WidgetTester tester,
    ) async {
      // ARRANGE (Preparación):
      // Preparamos una app mínima con LoginScreen como pantalla inicial.
      const Widget appConLoginScreen = MaterialApp(home: LoginScreen());

      // ACT (Acción):
      // Montamos el widget y renderizamos el primer frame.
      await tester.pumpWidget(appConLoginScreen);

      // ASSERT (Afirmación):
      // Verificamos que exista exactamente un botón con el texto "Iniciar Sesión".
      expect(
        find.text('Iniciar Sesión'),
        findsOneWidget,
        reason: 'La pantalla de login debe mostrar el botón "Iniciar Sesión"',
      );
    });
  });
}
