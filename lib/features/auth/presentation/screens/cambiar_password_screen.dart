import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

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

  @override
  void dispose() {
    _actualCtrl.dispose();
    _nuevaCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  void _cambiar() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().cambiarPassword(
          passwordActual: _actualCtrl.text,
          passwordNueva: _nuevaCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.passwordActualizada) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contraseña actualizada correctamente')),
          );
          Navigator.of(context).pop();
        } else if (state.status == AuthStatus.error && state.mensajeError != null) {
          ErrorDialog.showSnackBar(context, state.mensajeError!);
        }
      },
      child: Scaffold(
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
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      label: 'Guardar cambios',
                      loading: state.status == AuthStatus.cargando,
                      onPressed: _cambiar,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
