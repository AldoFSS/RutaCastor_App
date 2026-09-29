import '../../domain/entities/rol.dart';
import '../../domain/entities/usuario.dart';

/// Traduce entre el documento de Firestore (`Map<String, dynamic>`) y la
/// entidad de dominio [Usuario]. Es la única parte de la app que conoce
/// los nombres de campo usados en la colección `usuarios`.
class UsuarioModel extends Usuario {
  const UsuarioModel({
    required super.id,
    required super.nombre,
    required super.apellido,
    required super.correo,
    required super.matricula,
    required super.telefono,
    super.rol,
    super.activo,
  });

  factory UsuarioModel.fromMap(Map<String, dynamic> map, String id) {
    return UsuarioModel(
      id: id,
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      correo: map['correo'] ?? '',
      matricula: map['matricula'] ?? '',
      telefono: map['telefono'] ?? '',
      rol: RolMapper.tipoFromString(map['rol'] ?? 'alumno'),
      activo: map['activo'] ?? true,
    );
  }

  factory UsuarioModel.fromEntity(Usuario usuario) {
    return UsuarioModel(
      id: usuario.id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      correo: usuario.correo,
      matricula: usuario.matricula,
      telefono: usuario.telefono,
      rol: usuario.rol,
      activo: usuario.activo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'matricula': matricula,
      'telefono': telefono,
      'rol': RolMapper.tipoToString(rol),
      'activo': activo,
    };
  }
}

/// Conversión entre [TipoRol] y el string que se guarda en Firestore.
class RolMapper {
  RolMapper._();

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
