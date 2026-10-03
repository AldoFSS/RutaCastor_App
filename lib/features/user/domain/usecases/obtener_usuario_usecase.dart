import '../entities/usuario.dart';
import '../repositories/usuario_repository.dart';

/// Caso de uso: obtener un usuario puntual por su id (uid de Firebase).
class ObtenerUsuarioUseCase {
  final UsuarioRepository repository;
  ObtenerUsuarioUseCase(this.repository);

  Future<Usuario?> call(String id) => repository.obtenerPorId(id);
}
