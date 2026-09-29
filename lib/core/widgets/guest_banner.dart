import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Aviso visual de que la pantalla actual muestra datos de ejemplo
/// (modo invitado), no información real de Firebase.
class GuestBanner extends StatelessWidget {
  const GuestBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.secondary,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: const Text(
        'Modo invitado · datos de ejemplo',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
