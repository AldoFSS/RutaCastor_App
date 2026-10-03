import '../../domain/entities/usuario.dart';

enum PerfilStatus { cargando, listo, sinSesion, error }

class PerfilState {
  final PerfilStatus status;
  final Usuario? usuario;
  final String? mensajeError;

  const PerfilState({
    this.status = PerfilStatus.cargando,
    this.usuario,
    this.mensajeError,
  });

  PerfilState copyWith({
    PerfilStatus? status,
    Usuario? usuario,
    String? mensajeError,
  }) {
    return PerfilState(
      status: status ?? this.status,
      usuario: usuario ?? this.usuario,
      mensajeError: mensajeError,
    );
  }
}
