import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _validarSesion());
  }

  Future<void> _validarSesion() async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    await context.read<AuthCubit>().verificarSesionInicial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.autenticado) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else if (state.status == AuthStatus.noAutenticado) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore, color: Colors.white, size: 72),
              SizedBox(height: 16),
              Text(
                'RutaCastor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tu guía en la UTP',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              SizedBox(height: 32),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
