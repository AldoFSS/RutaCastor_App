import '../../domain/entities/rol.dart';
import '../../domain/entities/usuario.dart';

enum DetalleUsuarioStatus { cargando, listo, noEncontrado, guardando, error }

class DetalleUsuarioState {
  final DetalleUsuarioStatus status;
  final Usuario? usuario;
  final TipoRol? rolSeleccionado;
  final String? mensajeError;
  final String? mensajeExito;

  const DetalleUsuarioState({
    this.status = DetalleUsuarioStatus.cargando,
    this.usuario,
    this.rolSeleccionado,
    this.mensajeError,
    this.mensajeExito,
  });

  DetalleUsuarioState copyWith({
    DetalleUsuarioStatus? status,
    Usuario? usuario,
    TipoRol? rolSeleccionado,
    String? mensajeError,
    String? mensajeExito,
  }) {
    return DetalleUsuarioState(
      status: status ?? this.status,
      usuario: usuario ?? this.usuario,
      rolSeleccionado: rolSeleccionado ?? this.rolSeleccionado,
      mensajeError: mensajeError,
      mensajeExito: mensajeExito,
    );
  }
}
