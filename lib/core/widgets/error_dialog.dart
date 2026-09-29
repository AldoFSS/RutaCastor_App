import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ErrorDialog {
  static Future<void> show(BuildContext context, String mensaje, {String titulo = 'Ocurrió un error'}) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.error_outline, color: AppColors.error, size: 32),
        title: Text(titulo),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  /// Muestra el error como SnackBar, útil para validaciones ligeras.
  static void showSnackBar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
