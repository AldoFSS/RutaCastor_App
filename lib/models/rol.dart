/// Roles disponibles dentro de RutaCastor.
enum TipoRol { admin, alumno, staff }

class Rol {
  final String id;
  final String nombre;
  final String descripcion;

  const Rol({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });

  factory Rol.fromMap(Map<String, dynamic> map, String id) {
    return Rol(
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

  static TipoRol tipoFromString(String value) {
    switch (value) {
      case 'admin':
        return TipoRol.admin;
      case 'staff':
        return TipoRol.staff;
      case 'alumno':
      default:
        return TipoRol.alumno;
    }
  }

  static String tipoToString(TipoRol tipo) => tipo.name;
}
