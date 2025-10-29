import 'package:app/model/weather_data.dart';
import 'package:app/model/weather_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherInfo JSON <-> modelo', () {
    test('fromRawJson debe parsear una estructura anidada válida', () {
      // ARRANGE (Preparación):
      // JSON crudo con la respuesta típica del servicio (status + objeto data).
      const String jsonCrudo = '''
      {
        "status": "ok",
        "data": {
          "code": "SCEL",
          "city": "Santiago",
          "updatedAt": "00:00:01",
          "temperature": 25,
          "condition": "Sunny",
          "humidity": 40
        }
      }
      ''';

      // ACT (Acción):
      // Convertimos el JSON crudo a la entidad de dominio WeatherInfo.
      final WeatherInfo weatherInfo = WeatherInfo.fromRawJson(jsonCrudo);

      // ASSERT (Afirmación):
      // Validamos que el status y los campos anidados se hayan mapeado correctamente.
      expect(
        weatherInfo.status,
        equals("ok"),
        reason: 'El status debe ser "ok"',
      );

      expect(
        weatherInfo.data.code,
        equals("SCEL"),
        reason: 'El código IATA debe coincidir',
      );
      expect(
        weatherInfo.data.city,
        equals("Santiago"),
        reason: 'La ciudad debe coincidir',
      );
      expect(
        weatherInfo.data.temperature,
        equals(25),
        reason: 'La temperatura debe coincidir',
      );
      expect(
        weatherInfo.data.condition,
        equals("Sunny"),
        reason: 'La condición debe coincidir',
      );
      expect(
        weatherInfo.data.humidity,
        equals(40),
        reason: 'La humedad debe coincidir',
      );

      // Validación específica de la hora en formato HH:mm:ss.
      expect(
        weatherInfo.data.updatedAt.second,
        equals(1),
        reason: 'El segundo (ss) debe ser 1',
      );
    });

    test('toRawJson / fromRawJson debe mantener los datos (roundtrip)', () {
      // ARRANGE (Preparación):
      // Instancia representativa para probar ida y vuelta de serialización.
      final WeatherInfo infoOriginal = WeatherInfo(
        status: "ok",
        data: WeatherData(
          code: "ABCD",
          city: "Test City",
          updatedAt: DateTime.utc(2032, 3, 4, 9, 10, 11),
          temperature: 33,
          condition: "Hot",
          humidity: 5,
        ),
      );

      // ACT (Acción):
      // Serializamos a JSON crudo y luego deserializamos.
      final String jsonCrudo = infoOriginal.toRawJson();
      final WeatherInfo infoReconstruido = WeatherInfo.fromRawJson(jsonCrudo);

      // ASSERT (Afirmación):
      // Comprobamos que todos los campos se preservan tras el roundtrip.
      expect(
        infoReconstruido.status,
        equals("ok"),
        reason: 'El status debe conservarse',
      );

      expect(
        infoReconstruido.data.code,
        equals("ABCD"),
        reason: 'El código debe conservarse',
      );
      expect(
        infoReconstruido.data.city,
        equals("Test City"),
        reason: 'La ciudad debe conservarse',
      );

      expect(
        infoReconstruido.data.updatedAt.hour,
        equals(9),
        reason: 'La hora (HH) debe conservarse',
      );
      expect(
        infoReconstruido.data.updatedAt.minute,
        equals(10),
        reason: 'El minuto (mm) debe conservarse',
      );
      expect(
        infoReconstruido.data.updatedAt.second,
        equals(11),
        reason: 'El segundo (ss) debe conservarse',
      );

      expect(
        infoReconstruido.data.temperature,
        equals(33),
        reason: 'La temperatura debe conservarse',
      );
      expect(
        infoReconstruido.data.condition,
        equals("Hot"),
        reason: 'La condición debe conservarse',
      );
      expect(
        infoReconstruido.data.humidity,
        equals(5),
        reason: 'La humedad debe conservarse',
      );
    });
  });
}
