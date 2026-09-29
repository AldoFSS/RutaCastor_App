import '../entities/rol.dart';
import '../repositories/usuario_repository.dart';

/// Caso de uso: actualizar únicamente el rol de un usuario.
class ActualizarRolUseCase {
  final UsuarioRepository repository;
  ActualizarRolUseCase(this.repository);

  Future<void> call(String id, TipoRol rol) => repository.actualizarRol(id, rol);
}
