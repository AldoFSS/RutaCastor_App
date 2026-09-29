import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/rol.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/usecases/actualizar_rol_usecase.dart';
import '../../domain/usecases/cambiar_estado_activo_usecase.dart';
import '../../domain/usecases/eliminar_usuario_usecase.dart';
import '../../domain/usecases/obtener_usuario_usecase.dart';
import 'detalle_usuario_state.dart';

/// Detalle de un usuario específico, solo para admin.
class DetalleUsuarioCubit extends Cubit<DetalleUsuarioState> {
  final ObtenerUsuarioUseCase obtenerUsuarioUseCase;
  final ActualizarRolUseCase actualizarRolUseCase;
  final CambiarEstadoActivoUseCase cambiarEstadoActivoUseCase;
  final EliminarUsuarioUseCase eliminarUsuarioUseCase;
  final String uid;

  /// Si viene distinto de null (modo invitado), se muestra directo y los
  /// cambios quedan solo en memoria, sin tocar Firestore.
  final Usuario? usuarioDemo;

  DetalleUsuarioCubit({
    required this.obtenerUsuarioUseCase,
    required this.actualizarRolUseCase,
    required this.cambiarEstadoActivoUseCase,
    required this.eliminarUsuarioUseCase,
    required this.uid,
    this.usuarioDemo,
  }) : super(const DetalleUsuarioState());

  bool get _esDemo => usuarioDemo != null;

  Future<void> cargar() async {
    if (_esDemo) {
      emit(state.copyWith(
        status: DetalleUsuarioStatus.listo,
        usuario: usuarioDemo,
        rolSeleccionado: usuarioDemo!.rol,
      ));
      return;
    }
    final usuario = await obtenerUsuarioUseCase(uid);
    emit(state.copyWith(
      status: usuario == null ? DetalleUsuarioStatus.noEncontrado : DetalleUsuarioStatus.listo,
      usuario: usuario,
      rolSeleccionado: usuario?.rol,
    ));
  }

  void seleccionarRol(TipoRol rol) {
    emit(state.copyWith(rolSeleccionado: rol));
  }

  Future<void> guardarCambios() async {
    if (state.usuario == null || state.rolSeleccionado == null) return;
    emit(state.copyWith(status: DetalleUsuarioStatus.guardando));
    if (_esDemo) {
      emit(state.copyWith(
        status: DetalleUsuarioStatus.listo,
        usuario: state.usuario!.copyWith(rol: state.rolSeleccionado),
        mensajeExito: 'Usuario actualizado (demo)',
      ));
      return;
    }
    try {
      await actualizarRolUseCase(state.usuario!.id, state.rolSeleccionado!);
      emit(state.copyWith(
        status: DetalleUsuarioStatus.listo,
        mensajeExito: 'Usuario actualizado',
      ));
    } catch (_) {
      emit(state.copyWith(
        status: DetalleUsuarioStatus.error,
        mensajeError: 'No se pudo actualizar el usuario',
      ));
    }
  }

  Future<void> cambiarEstadoActivo(bool activo) async {
    if (state.usuario == null) return;
    if (_esDemo) {
      emit(state.copyWith(usuario: state.usuario!.copyWith(activo: activo)));
      return;
    }
    await cambiarEstadoActivoUseCase(state.usuario!.id, activo);
    emit(state.copyWith(usuario: state.usuario!.copyWith(activo: activo)));
  }

  Future<void> eliminar() async {
    if (state.usuario == null || _esDemo) return;
    await eliminarUsuarioUseCase(state.usuario!.id);
  }
}
