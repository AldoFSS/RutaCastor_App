import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/usuario.dart';
import '../../domain/usecases/cambiar_estado_activo_usecase.dart';
import '../../domain/usecases/observar_usuarios_usecase.dart';
import 'lista_usuarios_state.dart';

/// Solo se usa desde la pantalla de administración de usuarios,
/// accesible únicamente para el rol admin (ver nota en la pantalla).
class ListaUsuariosCubit extends Cubit<ListaUsuariosState> {
  final ObservarUsuariosUseCase observarUsuariosUseCase;
  final CambiarEstadoActivoUseCase cambiarEstadoActivoUseCase;

  /// Si viene distinto de null (modo invitado), se muestra esta lista fija
  /// en vez de conectarse a Firestore, y los cambios quedan solo en memoria.
  final List<Usuario>? datosDemo;

  StreamSubscription? _subscription;

  ListaUsuariosCubit({
    required this.observarUsuariosUseCase,
    required this.cambiarEstadoActivoUseCase,
    this.datosDemo,
  }) : super(const ListaUsuariosState());

  void observar() {
    if (datosDemo != null) {
      emit(state.copyWith(
          status: ListaUsuariosStatus.listo, usuarios: datosDemo));
      return;
    }
    _subscription?.cancel();
    _subscription = observarUsuariosUseCase().listen(
      (usuarios) => emit(state.copyWith(
        status: ListaUsuariosStatus.listo,
        usuarios: usuarios,
      )),
      onError: (error) => emit(state.copyWith(
        status: ListaUsuariosStatus.error,
        mensajeError: 'Error: $error',
      )),
    );
  }

  Future<void> cambiarEstadoActivo(String id, bool activo) async {
    if (datosDemo != null) {
      final actualizados = state.usuarios
          .map((u) => u.id == id ? u.copyWith(activo: activo) : u)
          .toList();
      emit(state.copyWith(usuarios: actualizados));
      return;
    }
    try {
      await cambiarEstadoActivoUseCase(id, activo);
    } catch (_) {
      emit(state.copyWith(
        status: ListaUsuariosStatus.error,
        mensajeError: 'No se pudo cambiar el estado del usuario.',
      ));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
