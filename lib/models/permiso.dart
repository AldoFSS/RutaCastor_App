class Permiso {
  final String id;
  final String nombre;
  final String descripcion;

  const Permiso({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Permiso.fromMap(Map<String, dynamic> map, String id) {
    return Permiso(
      id: id,
      nombre: map['nombre'] ?? '',
      descripcion: map['descripcion'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
