import 'package:app/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ErrorScreen', () {
    testWidgets('debe renderizar el texto "Error"', (
      WidgetTester tester,
    ) async {
      // ARRANGE (Preparación):
      // Preparamos una app mínima que muestre la pantalla de error.
      const Widget appConPantallaDeError = MaterialApp(home: ErrorScreen());

      // ACT (Acción):
      // Montamos el widget en el árbol y dejamos que se construya el primer frame.
      await tester.pumpWidget(appConPantallaDeError);

      // ASSERT (Afirmación):
      // Verificamos que el texto "Error" esté presente exactamente una vez.
      expect(
        find.text('Error'),
        findsOneWidget,
        reason: 'La pantalla de error debe mostrar el texto "Error"',
      );
    });
  });
}
