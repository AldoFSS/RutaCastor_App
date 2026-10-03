import '../../../user/domain/entities/usuario.dart';

enum AuthStatus {
  inicial,
  cargando,
  autenticado,
  invitado,
  noAutenticado,
  passwordActualizada,
  error,
}

class AuthState {
  final AuthStatus status;
  final Usuario? usuario;
  final String? mensajeError;

  const AuthState({
    this.status = AuthStatus.inicial,
    this.usuario,
    this.mensajeError,
  });

  AuthState copyWith({
    AuthStatus? status,
    Usuario? usuario,
    String? mensajeError,
  }) {
    return AuthState(
      status: status ?? this.status,
      usuario: usuario ?? this.usuario,
      mensajeError: mensajeError,
    );
  }
}
