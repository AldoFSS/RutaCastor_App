import '../repositories/usuario_repository.dart';

/// Caso de uso: activar o desactivar la cuenta de un usuario.
class CambiarEstadoActivoUseCase {
  final UsuarioRepository repository;
  CambiarEstadoActivoUseCase(this.repository);

  Future<void> call(String id, bool activo) => repository.cambiarEstadoActivo(id, activo);
}
