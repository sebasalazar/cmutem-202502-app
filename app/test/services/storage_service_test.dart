import 'package:app/services/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Requerido para inicializar bindings en pruebas con async/Plugins.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StorageService.getValue', () {
    test('debe retornar el valor cuando la clave existe', () async {
      // ARRANGE (Preparación):
      // Pre-cargamos SharedPreferences con una clave válida.
      SharedPreferences.setMockInitialValues(<String, Object>{"name": "Seba"});
      const String claveBuscada = "name";

      // ACT (Acción):
      // Obtenemos el valor asociado a la clave.
      final String valorObtenido = await StorageService.getValue(claveBuscada);

      // ASSERT (Afirmación):
      // Validamos que el valor retornado sea el esperado.
      expect(
        valorObtenido,
        equals("Seba"),
        reason: 'Debe devolver el contenido almacenado para "name"',
      );
    });

    test('debe retornar cadena vacía cuando la clave no existe', () async {
      // ARRANGE (Preparación):
      // Inicializamos sin la clave requerida.
      SharedPreferences.setMockInitialValues(<String, Object>{});
      const String claveInexistente = "missing";

      // ACT (Acción):
      final String valorObtenido = await StorageService.getValue(
        claveInexistente,
      );

      // ASSERT (Afirmación):
      expect(
        valorObtenido,
        equals(""),
        reason: 'Para claves inexistentes debe retornar ""',
      );
    });

    test('debe retornar cadena vacía cuando la clave es vacía', () async {
      // ARRANGE (Preparación):
      // Aunque existan otros datos, usar clave vacía debe devolver "".
      SharedPreferences.setMockInitialValues(<String, Object>{"x": "y"});
      const String claveVacia = "";

      // ACT (Acción):
      final String valorObtenido = await StorageService.getValue(claveVacia);

      // ASSERT (Afirmación):
      expect(
        valorObtenido,
        equals(""),
        reason: 'Para clave vacía debe retornar ""',
      );
    });
  });
}
