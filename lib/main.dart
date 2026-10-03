import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'firebase_options.dart'; // generado por `flutterfire configure`

import 'core/di/injection_container.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  //);
  await initInjectionContainer();
  runApp(const RutaCastorApp());
}

class RutaCastorApp extends StatelessWidget {
  const RutaCastorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthCubit vive a nivel de app: es el mismo singleton para splash,
    // login, registro, cambio de contraseña y perfil (logout).
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: MaterialApp(
        title: 'RutaCastor',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        initialRoute: AppRoutes.splash,
        routes: AppRouter.routes,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}