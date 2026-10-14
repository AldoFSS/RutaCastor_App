  import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/user/domain/entities/rol.dart';
import '../../features/user/domain/entities/usuario.dart';
import '../../features/user/domain/repositories/usuario_repository.dart';
import '../error/app_exceptions.dart';
import 'mock_usuarios.dart';

class DemoAuthRepository implements AuthRepository {
  @override
  String? get uidActual => null;

  @override
  Future<Usuario?> obtenerUsuarioActual() async => null;

  @override
  Future<Usuario> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) =>
      _noDisponible();

  @override
  Future<Usuario> login({
    required String correo,
    required String password,
  }) =>
      _noDisponible();

  @override
  Future<void> logout() async {}

  @override
  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  }) =>
      _noDisponible();

  @override
  Future<void> enviarCorreoRecuperacion(String correo) => _noDisponible();

  @override
  Future<bool> haySesionGuardada() async => false;

  Future<T> _noDisponible<T>() => Future.error(
        AuthException('Esta acción requiere configurar Firebase.'),
      );
}

class DemoUsuarioRepository implements UsuarioRepository {
  final Map<String, Usuario> _usuarios = {
    for (final usuario in MockUsuarios.listaDemo) usuario.id: usuario,
  };

  @override
  Future<Usuario?> obtenerPorId(String id) async => _usuarios[id];

  @override
  Stream<List<Usuario>> observarTodos() {
    final usuarios = _usuarios.values.toList()
      ..sort((a, b) => a.nombre.compareTo(b.nombre));
    return Stream.value(usuarios);
  }

  @override
  Future<void> actualizar(Usuario usuario) async {
    _usuarios[usuario.id] = usuario;
  }

  @override
  Future<void> actualizarRol(String id, TipoRol rol) async {
    final usuario = _requerirUsuario(id);
    _usuarios[id] = usuario.copyWith(rol: rol);
  }

  @override
  Future<void> cambiarEstadoActivo(String id, bool activo) async {
    final usuario = _requerirUsuario(id);
    _usuarios[id] = usuario.copyWith(activo: activo);
  }

  @override
  Future<void> eliminar(String id) async {
    _usuarios.remove(id);
  }

  Usuario _requerirUsuario(String id) =>
      _usuarios[id] ??
      (throw DataException('Usuario de demostración no encontrado.'));
}
