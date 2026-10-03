import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/busqueda_screen.dart';
//import 'firebase_options.dart'; // generado por `flutterfire configure`

import 'core/di/injection_container.dart';
import 'core/routes/app_router.dart';
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
    return BlocProvider<AuthCubit>(
      create: (_) => sl<AuthCubit>(),
      child: MaterialApp(
        title: 'RutaCastor',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        // Cambia esto temporalmente para abrir directo tu pantalla:
        home: const BusquedaScreen(), 
      ),
    );
  }
}