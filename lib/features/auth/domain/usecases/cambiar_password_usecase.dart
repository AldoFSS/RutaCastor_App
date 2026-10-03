import '../repositories/auth_repository.dart';

/// Caso de uso: cambiar la contraseña del usuario autenticado.
class CambiarPasswordUseCase {
  final AuthRepository repository;
  CambiarPasswordUseCase(this.repository);

  Future<void> call({
    required String passwordActual,
    required String passwordNueva,
  }) {
    return repository.cambiarPassword(
      passwordActual: passwordActual,
      passwordNueva: passwordNueva,
    );
  }
}
