import '../../domain/entities/espacio_entity.dart';

class EspacioModel extends EspacioEntity {
  const EspacioModel({
    required super.id,
    required super.nombre,
    required super.tipo,
    required super.edificioId,
    super.piso,
    super.descripcion,
  });

  factory EspacioModel.fromMap(Map<String, dynamic> map, String id) {
    return EspacioModel(
      id: id,
      nombre: map['nombre'] ?? '',
      tipo: TipoEspacio.values.firstWhere(
        (t) => t.name == (map['tipo'] ?? 'otro'),
        orElse: () => TipoEspacio.otro,
      ),
      edificioId: map['edificioId'] ?? '',
      piso: (map['piso'] ?? 1).toInt(),
      descripcion: map['descripcion'] ?? '',
    );
  }
}
