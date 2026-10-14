import '../../features/espacios/data/models/espacio_model.dart';

/// Espacios de ejemplo usados en modo demo, sin acceder a Firestore.
class MockEspacios {
  MockEspacios._();

  static const listaDemo = [
    EspacioModel(
      id: 'esp-aula-101',
      nombre: 'Aula 101',
      descripcion:
          'Aula de clases ubicada en la planta baja del edificio de aulas.',
      edificioId: 'edif-b',
      categoriaId: 'cat-aula',
    ),
    EspacioModel(
      id: 'esp-aula-201',
      nombre: 'Aula 201',
      descripcion:
          'Aula de clases ubicada en el segundo nivel del edificio de aulas.',
      edificioId: 'edif-b',
      categoriaId: 'cat-aula',
    ),
    EspacioModel(
      id: 'esp-lab-sistemas',
      nombre: 'Laboratorio de Sistemas',
      descripcion:
          'Laboratorio destinado a prácticas de desarrollo y sistemas.',
      edificioId: 'edif-a',
      categoriaId: 'cat-laboratorio',
    ),
  ];
}
