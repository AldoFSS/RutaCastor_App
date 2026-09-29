import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_dialog.dart';

class CambiarPasswordScreen extends StatefulWidget {
  const CambiarPasswordScreen({super.key});

  @override
  State<CambiarPasswordScreen> createState() => _CambiarPasswordScreenState();
}

class _CambiarPasswordScreenState extends State<CambiarPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _actualCtrl = TextEditingController();
  final _nuevaCtrl = TextEditingController();
  final _confirmarCtrl = TextEditingController();
  bool _cargando = false;

  @override
  void dispose() {
    _actualCtrl.dispose();
    _nuevaCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  Future<void> _cambiar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _cargando = true);
    try {
      await AuthService.instance.cambiarPassword(
        passwordActual: _actualCtrl.text,
        passwordNueva: _nuevaCtrl.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada correctamente')),
      );
      Navigator.of(context).pop();
    } on AuthException catch (e) {
      if (mounted) ErrorDialog.showSnackBar(context, e.mensaje);
    } catch (_) {
      if (mounted) ErrorDialog.showSnackBar(context, 'No se pudo cambiar la contraseña');
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cambiar contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                label: 'Contraseña actual',
                controller: _actualCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_outline,
                validator: (v) => Validators.requerido(v, campo: 'La contraseña actual'),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Nueva contraseña',
                controller: _nuevaCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_reset,
                validator: Validators.password,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirmar nueva contraseña',
                controller: _confirmarCtrl,
                obscureText: true,
                prefixIcon: Icons.lock_reset,
                validator: (v) => Validators.confirmarPassword(v, _nuevaCtrl.text),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: 'Guardar cambios',
                loading: _cargando,
                onPressed: _cambiar,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
