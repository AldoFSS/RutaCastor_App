import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _validarSesion();
  }

  Future<void> _validarSesion() async {
    await Future.delayed(const Duration(milliseconds: 900));
    final haySesion = await StorageService.instance.haySesionGuardada();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(haySesion ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
    );
  }
}
