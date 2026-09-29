import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/usuario.dart';
import '../../domain/usecases/obtener_usuario_usecase.dart';
import 'perfil_state.dart';

/// Carga los datos del usuario con sesión activa para mostrarlos en
/// la pantalla de perfil.
class PerfilCubit extends Cubit<PerfilState> {
  final ObtenerUsuarioUseCase obtenerUsuarioUseCase;
  final String? uid;

  /// Si viene distinto de null (modo invitado), se muestra directo sin
  /// consultar Firestore.
  final Usuario? usuarioInvitado;

  PerfilCubit({
    required this.obtenerUsuarioUseCase,
    required this.uid,
    this.usuarioInvitado,
  }) : super(const PerfilState());

  Future<void> cargar() async {
    if (usuarioInvitado != null) {
      emit(state.copyWith(status: PerfilStatus.listo, usuario: usuarioInvitado));
      return;
    }
    if (uid == null) {
      emit(state.copyWith(status: PerfilStatus.sinSesion));
      return;
    }
    emit(state.copyWith(status: PerfilStatus.cargando));
    try {
      final usuario = await obtenerUsuarioUseCase(uid!);
      if (usuario == null) {
        emit(state.copyWith(
          status: PerfilStatus.error,
          mensajeError: 'No se pudo cargar el perfil',
        ));
        return;
      }
      emit(state.copyWith(status: PerfilStatus.listo, usuario: usuario));
    } catch (_) {
      emit(state.copyWith(
        status: PerfilStatus.error,
        mensajeError: 'No se pudo cargar el perfil',
      ));
    }
  }
}
