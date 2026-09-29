import '../../../user/domain/entities/usuario.dart';

/// Contrato del repositorio de autenticación. La capa de presentación
/// solo conoce esta abstracción; nunca los detalles de Firebase.
abstract class AuthRepository {
  /// Uid del usuario con sesión activa en Firebase Auth, si existe.
  String? get uidActual;

  Future<Usuario?> obtenerUsuarioActual();

  Future<Usuario> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  });

  Future<Usuario> login({
    required String correo,
    required String password,
  });

  Future<void> logout();

  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  });

  Future<void> enviarCorreoRecuperacion(String correo);

  /// Indica si hay una sesión guardada localmente (usada en el splash
  /// para decidir si se navega a Home o a Login).
  Future<bool> haySesionGuardada();
}
