/// Modelo de un espacio físico del campus, almacenado en `espacios`.
///
/// Las relaciones con edificios y categorías se guardan como IDs de
/// documentos; `id` corresponde al ID del documento de Firestore.
class EspacioModel {
  const EspacioModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.edificioId,
    required this.categoriaId,
    this.imagenUrl,
  });

  final String id;
  final String nombre;
  final String descripcion;
  final String edificioId;
  final String categoriaId;
  final String? imagenUrl;

  factory EspacioModel.fromMap(Map<String, dynamic> map, String id) {
    return EspacioModel(
      id: id,
      nombre: map['nombre'] as String? ?? '',
      descripcion: map['descripcion'] as String? ?? '',
      edificioId: map['edificioId'] as String? ?? '',
      categoriaId: map['categoriaId'] as String? ?? '',
      imagenUrl: map['imagenUrl'] as String?,
    );
  }

  /// Serializa solo los campos del documento; el ID se conserva en su ruta.
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'edificioId': edificioId,
      'categoriaId': categoriaId,
      if (imagenUrl != null && imagenUrl!.trim().isNotEmpty)
        'imagenUrl': imagenUrl,
    };
  }
}
