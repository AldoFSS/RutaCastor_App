import 'package:flutter_test/flutter_test.dart';
import 'package:rutacastor/features/espacios/data/models/espacio_model.dart';
import 'package:rutacastor/features/espacios/data/services/espacio_service.dart';

void main() {
  group('EspacioService demo', () {
    test('filters sample spaces by building and category', () async {
      final service = EspacioService.demo();

      final espacios = await service
          .obtenerEspaciosFiltrados(
            edificioId: 'edif-b',
            categoriaId: 'cat-aula',
          )
          .first;

      expect(espacios.map((espacio) => espacio.id), [
        'esp-aula-101',
        'esp-aula-201',
      ]);
    });

    test('creates, updates and deletes a demo space', () async {
      final service = EspacioService.demo();
      const espacio = EspacioModel(
        id: 'taller-1',
        nombre: 'Taller de prueba',
        descripcion: 'Espacio de prueba',
        edificioId: 'edif-a',
        categoriaId: 'cat-aula',
      );

      await service.crearEspacio(espacio);
      await service.actualizarEspacio(
        espacio.id,
        {'nombre': 'Taller actualizado'},
      );
      var espacios = await service.obtenerEspacios().first;
      expect(
        espacios.singleWhere((item) => item.id == espacio.id).nombre,
        'Taller actualizado',
      );

      await service.eliminarEspacio(espacio.id);
      espacios = await service.obtenerEspacios().first;
      expect(espacios.any((item) => item.id == espacio.id), isFalse);
    });
  });
}
