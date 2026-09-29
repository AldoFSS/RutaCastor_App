import '../entities/usuario.dart';
import '../repositories/usuario_repository.dart';

/// Caso de uso: observar en tiempo real la lista completa de usuarios
/// (usado en la administración de usuarios, solo rol admin).
class ObservarUsuariosUseCase {
  final UsuarioRepository repository;
  ObservarUsuariosUseCase(this.repository);

  Stream<List<Usuario>> call() => repository.observarTodos();
}
