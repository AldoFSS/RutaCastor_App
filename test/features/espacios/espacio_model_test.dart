import 'package:flutter_test/flutter_test.dart';
import 'package:rutacastor/features/espacios/data/models/espacio_model.dart';

void main() {
  group('EspacioModel', () {
    test('serializes the document fields but leaves the document ID out', () {
      const espacio = EspacioModel(
        id: 'aula-101',
        nombre: 'Aula 101',
        descripcion: 'Aula de clases',
        edificioId: 'edif-b',
        categoriaId: 'cat-aula',
      );

      expect(espacio.toMap(), {
        'nombre': 'Aula 101',
        'descripcion': 'Aula de clases',
        'edificioId': 'edif-b',
        'categoriaId': 'cat-aula',
      });
    });

    test('reads the document ID and optional image URL', () {
      final espacio = EspacioModel.fromMap(
        {
          'nombre': 'Laboratorio',
          'descripcion': 'Prácticas',
          'edificioId': 'edif-a',
          'categoriaId': 'cat-laboratorio',
          'imagenUrl': 'https://example.com/lab.jpg',
        },
        'lab-1',
      );

      expect(espacio.id, 'lab-1');
      expect(espacio.imagenUrl, 'https://example.com/lab.jpg');
      expect(espacio.toMap()['imagenUrl'], 'https://example.com/lab.jpg');
    });
  });
}
