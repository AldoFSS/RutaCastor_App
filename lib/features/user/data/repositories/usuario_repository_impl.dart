import '../../domain/entities/rol.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/usuario_repository.dart';
import '../datasources/usuario_remote_datasource.dart';
import '../models/usuario_model.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioRemoteDataSource remoteDataSource;

  UsuarioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Usuario?> obtenerPorId(String id) => remoteDataSource.obtenerPorId(id);

  @override
  Stream<List<Usuario>> observarTodos() => remoteDataSource.observarTodos();

  @override
  Future<void> actualizar(Usuario usuario) {
    return remoteDataSource.actualizar(UsuarioModel.fromEntity(usuario));
  }

  @override
  Future<void> actualizarRol(String id, TipoRol rol) {
    return remoteDataSource.actualizarCampos(
      id,
      {'rol': RolMapper.tipoToString(rol)},
    );
  }

  @override
  Future<void> cambiarEstadoActivo(String id, bool activo) {
    return remoteDataSource.cambiarEstadoActivo(id, activo);
  }

  @override
  Future<void> eliminar(String id) => remoteDataSource.eliminar(id);
}
