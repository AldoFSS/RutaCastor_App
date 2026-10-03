import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/screens/cambiar_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/registro_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/user/presentation/screens/detalle_usuario_screen.dart';
import '../../features/user/presentation/screens/lista_usuarios_screen.dart';
import '../../features/user/presentation/screens/perfil_screen.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/user/domain/entities/rol.dart';
import '../widgets/access_denied_screen.dart';
import 'app_routes.dart';

/// Centraliza la generación de rutas de la app, junto con [AppRoutes],
/// para no depender de strings sueltos repartidos por las pantallas.
class AppRouter {
  AppRouter._();

  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.registro: (_) => const RegistroScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.perfil: (_) => const PerfilScreen(),
        AppRoutes.cambiarPassword: (_) => const CambiarPasswordScreen(),
        AppRoutes.usuarios: (context) {
          final authCubit = context.read<AuthCubit>();
          final esAdmin = authCubit.state.usuario?.rol == TipoRol.admin;
          if (!esAdmin && !authCubit.esInvitado) {
            return const AccessDeniedScreen();
          }
          return const ListaUsuariosScreen();
        },
      };

  // '/usuarios/detalle' necesita un argumento (uid), por eso va aparte.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoutes.usuarioDetalle) {
      final uid = settings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => DetalleUsuarioScreen(uid: uid),
      );
    }
    return null;
  }
}
