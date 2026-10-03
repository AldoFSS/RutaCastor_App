import '../repositories/auth_repository.dart';
import '../../../user/domain/entities/usuario.dart';

/// Caso de uso: verificar si hay una sesión guardada localmente
/// (usado por el splash para decidir a dónde navegar).
class VerificarSesionUseCase {
  final AuthRepository repository;
  VerificarSesionUseCase(this.repository);

  Future<bool> call() => repository.haySesionGuardada();

  Future<Usuario?> obtenerUsuarioActual() => repository.obtenerUsuarioActual();
}
