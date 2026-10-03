import '../repositories/usuario_repository.dart';

/// Caso de uso: eliminar un usuario definitivamente.
class EliminarUsuarioUseCase {
  final UsuarioRepository repository;
  EliminarUsuarioUseCase(this.repository);

  Future<void> call(String id) => repository.eliminar(id);
}
