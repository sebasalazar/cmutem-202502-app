import 'package:app/model/weather_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherData JSON <-> modelo', () {
    test('fromJson debe parsear un mapa válido', () {
      // ARRANGE (Preparación):
      // Definimos un mapa JSON válido con todos los campos esperados.
      const Map<String, dynamic> jsonValido = <String, dynamic>{
        "code": "SCEL",
        "city": "Santiago",
        "updatedAt": "12:34:56",
        "temperature": 22,
        "condition": "Clear",
        "humidity": 55,
      };

      // ACT (Acción):
      // Parseamos el JSON a la entidad de dominio WeatherData.
      final WeatherData weatherData = WeatherData.fromJson(jsonValido);

      // ASSERT (Afirmación):
      // Verificamos que todos los campos hayan sido mapeados correctamente.
      expect(
        weatherData.code,
        equals("SCEL"),
        reason: 'El código IATA debe coincidir',
      );
      expect(
        weatherData.city,
        equals("Santiago"),
        reason: 'La ciudad debe coincidir',
      );
      expect(
        weatherData.temperature,
        equals(22),
        reason: 'La temperatura debe coincidir',
      );
      expect(
        weatherData.condition,
        equals("Clear"),
        reason: 'La condición debe coincidir',
      );
      expect(
        weatherData.humidity,
        equals(55),
        reason: 'La humedad debe coincidir',
      );

      // Validación específica de la hora en formato HH:mm:ss.
      expect(
        weatherData.updatedAt.hour,
        equals(12),
        reason: 'Hora (HH) debe ser 12',
      );
      expect(
        weatherData.updatedAt.minute,
        equals(34),
        reason: 'Minuto (mm) debe ser 34',
      );
      expect(
        weatherData.updatedAt.second,
        equals(56),
        reason: 'Segundo (ss) debe ser 56',
      );
    });

    test('toJson debe retornar un mapa serializable', () {
      // ARRANGE (Preparación):
      // Creamos una instancia representativa de WeatherData.
      final WeatherData muestra = WeatherData(
        code: "SCEL",
        city: "Santiago",
        updatedAt: DateTime.utc(2030, 1, 2, 7, 8, 9),
        temperature: 10,
        condition: "Cloudy",
        humidity: 80,
      );

      // ACT (Acción):
      // Convertimos la entidad a un mapa JSON serializable.
      final Map<String, dynamic> mapaSerializado = muestra.toJson();

      // ASSERT (Afirmación):
      // Verificamos que el contenido del mapa sea el esperado.
      expect(
        mapaSerializado["code"],
        equals("SCEL"),
        reason: 'El código debe ser "SCEL"',
      );
      expect(
        mapaSerializado["city"],
        equals("Santiago"),
        reason: 'La ciudad debe ser "Santiago"',
      );

      // Confirmamos el formato de hora "HH:mm:ss".
      expect(
        mapaSerializado["updated_at"],
        equals("07:08:09"),
        reason: 'La hora debe serializarse en formato HH:mm:ss',
      );

      expect(
        mapaSerializado["temperature"],
        equals(10),
        reason: 'La temperatura debe ser 10',
      );
      expect(
        mapaSerializado["condition"],
        equals("Cloudy"),
        reason: 'La condición debe ser "Cloudy"',
      );
      expect(
        mapaSerializado["humidity"],
        equals(80),
        reason: 'La humedad debe ser 80',
      );
    });

    test('fromRawJson / toRawJson debe mantener los datos (roundtrip)', () {
      // ARRANGE (Preparación):
      // Instancia original que usaremos para la ida y vuelta (roundtrip).
      final WeatherData original = WeatherData(
        code: "XXXX",
        city: "Nowhere",
        updatedAt: DateTime.utc(2031, 2, 3, 1, 2, 3),
        temperature: -3,
        condition: "Snow",
        humidity: 10,
      );

      // ACT (Acción):
      // Serializamos a raw JSON y luego deserializamos nuevamente.
      final String rawJson = original.toRawJson();
      final WeatherData reconstruido = WeatherData.fromRawJson(rawJson);

      // ASSERT (Afirmación):
      // Comprobamos que todos los campos se preservan tras el roundtrip.
      expect(
        reconstruido.code,
        equals(original.code),
        reason: 'El código debe conservarse',
      );
      expect(
        reconstruido.city,
        equals(original.city),
        reason: 'La ciudad debe conservarse',
      );

      expect(
        reconstruido.updatedAt.hour,
        equals(original.updatedAt.hour),
        reason: 'La hora (HH) debe conservarse',
      );
      expect(
        reconstruido.updatedAt.minute,
        equals(original.updatedAt.minute),
        reason: 'El minuto (mm) debe conservarse',
      );
      expect(
        reconstruido.updatedAt.second,
        equals(original.updatedAt.second),
        reason: 'El segundo (ss) debe conservarse',
      );

      expect(
        reconstruido.temperature,
        equals(original.temperature),
        reason: 'La temperatura debe conservarse',
      );
      expect(
        reconstruido.condition,
        equals(original.condition),
        reason: 'La condición debe conservarse',
      );
      expect(
        reconstruido.humidity,
        equals(original.humidity),
        reason: 'La humedad debe conservarse',
      );
    });
  });
}
