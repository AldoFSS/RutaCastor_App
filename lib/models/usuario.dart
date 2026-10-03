import 'rol.dart';

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

  factory Usuario.fromMap(Map<String, dynamic> map, String id) {
    return Usuario(
      id: id,
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      correo: map['correo'] ?? '',
      matricula: map['matricula'] ?? '',
      telefono: map['telefono'] ?? '',
      rol: Rol.tipoFromString(map['rol'] ?? 'alumno'),
      activo: map['activo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'matricula': matricula,
      'telefono': telefono,
      'rol': Rol.tipoToString(rol),
      'activo': activo,
    };
  }

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
