import 'rol.dart';

/// Entidad de dominio: representa a un usuario dentro de RutaCastor,
/// sin conocer nada sobre Firestore ni sobre cómo se serializa.
class Usuario {
  final String id;
  final String nombre;
  final String apellido;
  final String correo;
  final String matricula;
  final String telefono;
  final TipoRol rol;
  final bool activo;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.matricula,
    required this.telefono,
    this.rol = TipoRol.alumno,
    this.activo = true,
  });

  String get nombreCompleto => '$nombre $apellido';

  Usuario copyWith({
    String? nombre,
    String? apellido,
    String? correo,
    String? matricula,
    String? telefono,
    TipoRol? rol,
    bool? activo,
  }) {
    return Usuario(
      id: id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      correo: correo ?? this.correo,
      matricula: matricula ?? this.matricula,
      telefono: telefono ?? this.telefono,
      rol: rol ?? this.rol,
      activo: activo ?? this.activo,
    );
  }
}
