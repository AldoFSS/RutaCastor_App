import '../../../user/domain/entities/usuario.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: iniciar sesión con correo y contraseña.
class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Usuario> call({required String correo, required String password}) {
    return repository.login(correo: correo, password: password);
  }
}
