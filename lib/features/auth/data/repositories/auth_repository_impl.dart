import '../../../../core/services/secure_storage_service.dart';
import '../../../user/data/models/usuario_model.dart';
import '../../../user/domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Decide de dónde vienen y a dónde van los datos de autenticación:
/// habla con Firebase a través de [AuthRemoteDataSource] y persiste la
/// sesión localmente con el singleton [SecureStorageService]. La capa de
/// presentación nunca sabe de estos detalles.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorageService storageService;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storageService,
  });

  @override
  String? get uidActual => remoteDataSource.uidActual;

  @override
  Future<Usuario?> obtenerUsuarioActual() =>
      remoteDataSource.obtenerUsuarioActual();

  @override
  Future<Usuario> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) async {
    final UsuarioModel usuario = await remoteDataSource.registrar(
      nombre: nombre,
      apellido: apellido,
      correo: correo,
      password: password,
      matricula: matricula,
      telefono: telefono,
    );
    await storageService.guardarSesion(
      uid: usuario.id,
      rol: RolMapper.tipoToString(usuario.rol),
    );
    return usuario;
  }

  @override
  Future<Usuario> login({
    required String correo,
    required String password,
  }) async {
    final UsuarioModel usuario = await remoteDataSource.login(
      correo: correo,
      password: password,
    );
    await storageService.guardarSesion(
      uid: usuario.id,
      rol: RolMapper.tipoToString(usuario.rol),
    );
    return usuario;
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await storageService.limpiarSesion();
  }

  @override
  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  }) {
    return remoteDataSource.cambiarPassword(
      passwordActual: passwordActual,
      passwordNueva: passwordNueva,
    );
  }

  @override
  Future<void> enviarCorreoRecuperacion(String correo) {
    return remoteDataSource.enviarCorreoRecuperacion(correo);
  }

  @override
  Future<bool> haySesionGuardada() => storageService.haySesionGuardada();
}
