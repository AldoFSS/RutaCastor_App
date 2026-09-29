import '../../../user/domain/entities/usuario.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso: crear una cuenta nueva (Firebase Auth + perfil en Firestore).
class RegistrarUseCase {
  final AuthRepository repository;
  RegistrarUseCase(this.repository);

  Future<Usuario> call({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) {
    return repository.registrar(
      nombre: nombre,
      apellido: apellido,
      correo: correo,
      password: password,
      matricula: matricula,
      telefono: telefono,
    );
  }
}
