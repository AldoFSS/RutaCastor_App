import '../entities/rol.dart';
import '../entities/usuario.dart';

/// Contrato del repositorio de usuarios. Decide si los datos se sirven
/// desde Firestore, una caché local u otra fuente, sin que la capa de
/// presentación lo sepa: la pantalla solo recibe entidades [Usuario].
abstract class UsuarioRepository {
  Future<Usuario?> obtenerPorId(String id);

  Stream<List<Usuario>> observarTodos();

  Future<void> actualizar(Usuario usuario);

  Future<void> actualizarRol(String id, TipoRol rol);

  Future<void> cambiarEstadoActivo(String id, bool activo);

  Future<void> eliminar(String id);
}
