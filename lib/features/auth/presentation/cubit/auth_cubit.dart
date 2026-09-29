import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../../core/mock/mock_usuarios.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/cambiar_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/registrar_usecase.dart';
import '../../domain/usecases/verificar_sesion_usecase.dart';
import 'auth_state.dart';

/// Cubit que controla el estado de autenticación de toda la app:
/// splash, login, registro y cambio de contraseña se apoyan en él.
/// Se registra como singleton en el contenedor de inyección de
/// dependencias para que toda la app comparta el mismo estado de sesión.
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final LoginUseCase loginUseCase;
  final RegistrarUseCase registrarUseCase;
  final LogoutUseCase logoutUseCase;
  final CambiarPasswordUseCase cambiarPasswordUseCase;
  final VerificarSesionUseCase verificarSesionUseCase;

  AuthCubit({
    required this.repository,
    required this.loginUseCase,
    required this.registrarUseCase,
    required this.logoutUseCase,
    required this.cambiarPasswordUseCase,
    required this.verificarSesionUseCase,
  }) : super(const AuthState());

  bool _modoInvitado = false;

  /// Uid del usuario con sesión activa en Firebase Auth, si existe.
  /// En modo invitado no hay sesión real de Firebase, así que es null.
  String? get uidActual => repository.uidActual;

  /// true si se entró con "Entrar como invitado" (sin cuenta real).
  bool get esInvitado => _modoInvitado;

  /// Entra a la app con un usuario de ejemplo, sin llamar a Firebase.
  /// Pensado solo para poder navegar y ver las pantallas rápidamente.
  void entrarComoInvitado() {
    _modoInvitado = true;
    emit(state.copyWith(
        status: AuthStatus.invitado, usuario: MockUsuarios.invitado));
  }

  Future<void> verificarSesionInicial() async {
    try {
      final usuario = await verificarSesionUseCase.obtenerUsuarioActual();
      if (usuario == null || !usuario.activo) {
        await repository.logout();
        emit(const AuthState(status: AuthStatus.noAutenticado));
        return;
      }
      emit(state.copyWith(status: AuthStatus.autenticado, usuario: usuario));
    } catch (_) {
      await repository.logout();
      emit(const AuthState(status: AuthStatus.noAutenticado));
    }
  }

  Future<void> login({required String correo, required String password}) async {
    emit(state.copyWith(status: AuthStatus.cargando, mensajeError: null));
    try {
      final usuario = await loginUseCase(correo: correo, password: password);
      emit(state.copyWith(status: AuthStatus.autenticado, usuario: usuario));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.error, mensajeError: e.mensaje));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.error,
        mensajeError: 'No se pudo iniciar sesión',
      ));
    }
  }

  Future<void> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) async {
    emit(state.copyWith(status: AuthStatus.cargando, mensajeError: null));
    try {
      final usuario = await registrarUseCase(
        nombre: nombre,
        apellido: apellido,
        correo: correo,
        password: password,
        matricula: matricula,
        telefono: telefono,
      );
      emit(state.copyWith(status: AuthStatus.autenticado, usuario: usuario));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.error, mensajeError: e.mensaje));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.error,
        mensajeError: 'No se pudo completar el registro',
      ));
    }
  }

  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  }) async {
    emit(state.copyWith(status: AuthStatus.cargando, mensajeError: null));
    try {
      await cambiarPasswordUseCase(
        passwordActual: passwordActual,
        passwordNueva: passwordNueva,
      );
      emit(state.copyWith(status: AuthStatus.passwordActualizada));
    } on AuthException catch (e) {
      emit(state.copyWith(status: AuthStatus.error, mensajeError: e.mensaje));
    } catch (_) {
      emit(state.copyWith(
        status: AuthStatus.error,
        mensajeError: 'No se pudo cambiar la contraseña',
      ));
    }
  }

  Future<void> logout() async {
    _modoInvitado = false;
    await logoutUseCase();
    emit(const AuthState(status: AuthStatus.noAutenticado));
  }
}
