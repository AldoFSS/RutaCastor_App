import '../repositories/auth_repository.dart';

/// Caso de uso: cerrar sesión y limpiar la sesión guardada localmente.
class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase(this.repository);

  Future<void> call() => repository.logout();
}
