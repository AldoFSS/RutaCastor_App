import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_dialog.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _matriculaCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmarCtrl = TextEditingController();
  bool _cargando = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _correoCtrl.dispose();
    _matriculaCtrl.dispose();
    _telefonoCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmarCtrl.dispose();
    super.dispose();
  }

  Future<void> _registrar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _cargando = true);
    try {
      await AuthService.instance.registrar(
        nombre: _nombreCtrl.text,
        apellido: _apellidoCtrl.text,
        correo: _correoCtrl.text,
        password: _passwordCtrl.text,
        matricula: _matriculaCtrl.text,
        telefono: _telefonoCtrl.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } on AuthException catch (e) {
      if (mounted) ErrorDialog.showSnackBar(context, e.mensaje);
    } catch (_) {
      if (mounted) ErrorDialog.showSnackBar(context, 'No se pudo completar el registro');
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomTextField(
                  label: 'Nombre(s)',
                  controller: _nombreCtrl,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => Validators.requerido(v, campo: 'El nombre'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Apellidos',
                  controller: _apellidoCtrl,
                  prefixIcon: Icons.person_outline,
                  validator: (v) => Validators.requerido(v, campo: 'El apellido'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Correo institucional',
                  controller: _correoCtrl,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.correo,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Matrícula',
                  controller: _matriculaCtrl,
                  prefixIcon: Icons.badge_outlined,
                  validator: Validators.matricula,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Teléfono',
                  controller: _telefonoCtrl,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  validator: Validators.telefono,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Contraseña',
                  controller: _passwordCtrl,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: Validators.password,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Confirmar contraseña',
                  controller: _confirmarCtrl,
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (v) => Validators.confirmarPassword(v, _passwordCtrl.text),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Registrarme',
                  loading: _cargando,
                  onPressed: _registrar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
