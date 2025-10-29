import 'package:app/consts/app_const.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Archivo de constantes AppConst', () {
    test('las etiquetas no deben estar vacías', () {
      // ARRANGE (Preparación):
      // Preparamos referencias explícitas a cada etiqueta para hacer
      // más claro qué se está validando.
      final String idTokenLabel = AppConst.idTokenLabel;
      final String emailLabel = AppConst.emailLabel;
      final String nameLabel = AppConst.nameLabel;
      final String photoUrlLabel = AppConst.photoUrlLabel;

      // ACT (Acción):
      // Evaluamos la condición de “no vacío” para cada etiqueta.
      final bool isIdTokenLabelNotEmpty = idTokenLabel.isNotEmpty;
      final bool isEmailLabelNotEmpty = emailLabel.isNotEmpty;
      final bool isNameLabelNotEmpty = nameLabel.isNotEmpty;
      final bool isPhotoUrlLabelNotEmpty = photoUrlLabel.isNotEmpty;

      // ASSERT (Afirmación):
      // Comprobamos que todas las etiquetas sean no vacías.
      expect(
        isIdTokenLabelNotEmpty,
        isTrue,
        reason: 'idTokenLabel no debe estar vacío',
      );
      expect(
        isEmailLabelNotEmpty,
        isTrue,
        reason: 'emailLabel no debe estar vacío',
      );
      expect(
        isNameLabelNotEmpty,
        isTrue,
        reason: 'nameLabel no debe estar vacío',
      );
      expect(
        isPhotoUrlLabelNotEmpty,
        isTrue,
        reason: 'photoUrlLabel no debe estar vacío',
      );
    });
  });
}
