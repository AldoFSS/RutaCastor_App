import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../services/secure_storage_service.dart';

import '../../features/user/domain/entities/usuario.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/cambiar_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/registrar_usecase.dart';
import '../../features/auth/domain/usecases/verificar_sesion_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

import '../../features/user/data/datasources/usuario_remote_datasource.dart';
import '../../features/user/data/repositories/usuario_repository_impl.dart';
import '../../features/user/domain/repositories/usuario_repository.dart';
import '../../features/user/domain/usecases/actualizar_rol_usecase.dart';
import '../../features/user/domain/usecases/cambiar_estado_activo_usecase.dart';
import '../../features/user/domain/usecases/eliminar_usuario_usecase.dart';
import '../../features/user/domain/usecases/obtener_usuario_usecase.dart';
import '../../features/user/domain/usecases/observar_usuarios_usecase.dart';
import '../../features/user/presentation/cubit/detalle_usuario_cubit.dart';
import '../../features/user/presentation/cubit/lista_usuarios_cubit.dart';
import '../../features/user/presentation/cubit/perfil_cubit.dart';

/// Contenedor de inyección de dependencias (patrón Service Locator con
/// get_it).
///
/// Registra como **singleton** los servicios, fuentes de datos y
/// repositorios que deben existir una sola vez en toda la app (conexión
/// a Firebase, almacenamiento local seguro, repositorios, el AuthCubit
/// que guarda el estado global de sesión); y como **factory** los Cubits
/// de pantalla, que se crean nuevos cada vez que la pantalla los pide.
final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  // ---- Externos / infraestructura ----
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService.instance,
  );

  // ---- Feature: Auth ----
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), storageService: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegistrarUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => CambiarPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerificarSesionUseCase(sl()));
  // Singleton: toda la app comparte el mismo estado de sesión.
  sl.registerLazySingleton(
    () => AuthCubit(
      repository: sl(),
      loginUseCase: sl(),
      registrarUseCase: sl(),
      logoutUseCase: sl(),
      cambiarPasswordUseCase: sl(),
      verificarSesionUseCase: sl(),
    ),
  );

  // ---- Feature: Usuario ----
  sl.registerLazySingleton<UsuarioRemoteDataSource>(
    () => UsuarioRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<UsuarioRepository>(
    () => UsuarioRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => ObtenerUsuarioUseCase(sl()));
  sl.registerLazySingleton(() => ObservarUsuariosUseCase(sl()));
  sl.registerLazySingleton(() => ActualizarRolUseCase(sl()));
  sl.registerLazySingleton(() => CambiarEstadoActivoUseCase(sl()));
  sl.registerLazySingleton(() => EliminarUsuarioUseCase(sl()));

  // Factories con parámetro: cada pantalla crea su propia instancia,
  // ligada al uid del usuario (o a datos de ejemplo en modo invitado).
  sl.registerFactoryParam<PerfilCubit, String?, Usuario?>(
    (uid, usuarioInvitado) => PerfilCubit(
      obtenerUsuarioUseCase: sl(),
      uid: uid,
      usuarioInvitado: usuarioInvitado,
    ),
  );
  sl.registerFactoryParam<ListaUsuariosCubit, List<Usuario>?, void>(
    (datosDemo, _) => ListaUsuariosCubit(
      observarUsuariosUseCase: sl(),
      cambiarEstadoActivoUseCase: sl(),
      datosDemo: datosDemo,
    ),
  );
  sl.registerFactoryParam<DetalleUsuarioCubit, String, Usuario?>(
    (uid, usuarioDemo) => DetalleUsuarioCubit(
      obtenerUsuarioUseCase: sl(),
      actualizarRolUseCase: sl(),
      cambiarEstadoActivoUseCase: sl(),
      eliminarUsuarioUseCase: sl(),
      uid: uid,
      usuarioDemo: usuarioDemo,
    ),
  );
}
