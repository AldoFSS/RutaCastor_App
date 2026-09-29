import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/auth_service.dart';
import '../services/usuario_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_dialog.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = AuthService.instance.usuarioActual?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              await AuthService.instance.logout();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }
            },
          ),
        ],
      ),
      body: uid == null
          ? const Center(child: Text('No hay sesión activa'))
          : FutureBuilder<Usuario?>(
              future: UsuarioService.instance.obtenerPorId(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicator(mensaje: 'Cargando perfil...');
                }
                if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ErrorDialog.showSnackBar(context, 'No se pudo cargar el perfil');
                  });
                  return const SizedBox.shrink();
                }

                final u = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    CircleAvatar(
                      radius: 44,
                      child: Text(
                        u.nombre.isNotEmpty ? u.nombre[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(u.nombreCompleto,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    const SizedBox(height: 24),
                    _InfoTile(icon: Icons.email_outlined, label: 'Correo', value: u.correo),
                    _InfoTile(icon: Icons.badge_outlined, label: 'Matrícula', value: u.matricula),
                    _InfoTile(icon: Icons.phone_outlined, label: 'Teléfono', value: u.telefono),
                    _InfoTile(
                      icon: Icons.verified_user_outlined,
                      label: 'Rol',
                      value: u.rol.name,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.lock_reset),
                      label: const Text('Cambiar contraseña'),
                      onPressed: () => Navigator.of(context).pushNamed('/cambiar-password'),
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value.isEmpty ? '—' : value),
    );
  }
}
