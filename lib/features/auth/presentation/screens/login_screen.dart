import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _correoCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _iniciarSesion() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthCubit>().login(
          correo: _correoCtrl.text,
          password: _passwordCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.autenticado || state.status == AuthStatus.invitado) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        } else if (state.status == AuthStatus.error && state.mensajeError != null) {
          ErrorDialog.showSnackBar(context, state.mensajeError!);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 32),
                  Text('Bienvenido a RutaCastor',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Inicia sesión para continuar',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Correo institucional',
                    controller: _correoCtrl,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: Validators.correo,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Contraseña',
                    controller: _passwordCtrl,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: Validators.password,
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return CustomButton(
                        label: 'Iniciar sesión',
                        loading: state.status == AuthStatus.cargando,
                        onPressed: _iniciarSesion,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.registro),
                    child: const Text('¿No tienes cuenta? Regístrate'),
                  ),
                  TextButton(
                    onPressed: () => context.read<AuthCubit>().entrarComoInvitado(),
                    child: const Text('Entrar como invitado (ver pantallas)'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
