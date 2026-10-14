/// Etiquetas legibles para los IDs de catálogo de espacios.
class EspacioLabels {
  EspacioLabels._();

  static const categorias = {
    'cat-aula': 'Aula',
    'cat-laboratorio': 'Laboratorio',
  };

  static const edificios = {
    'edif-a': 'Rectoría',
    'edif-b': 'Edificio de aulas',
  };

  static String categoria(String id) => categorias[id] ?? id;

  static String edificio(String id) => edificios[id] ?? id;
}
