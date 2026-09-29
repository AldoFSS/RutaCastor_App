import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/guest_banner.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../cubit/perfil_cubit.dart';
import '../cubit/perfil_state.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final uid = authCubit.uidActual;
    final esInvitado = authCubit.esInvitado;

    return BlocProvider(
      create: (_) => sl<PerfilCubit>(
        param1: uid,
        param2: esInvitado ? authCubit.state.usuario : null,
      )..cargar(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi perfil'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Cerrar sesión',
              onPressed: () async {
                await context.read<AuthCubit>().logout();
                if (context.mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            if (esInvitado) const GuestBanner(),
            Expanded(
              child: BlocConsumer<PerfilCubit, PerfilState>(
                listener: (context, state) {
                  if (state.status == PerfilStatus.error && state.mensajeError != null) {
                    ErrorDialog.showSnackBar(context, state.mensajeError!);
                  }
                },
                builder: (context, state) {
                  if (state.status == PerfilStatus.cargando) {
                    return const LoadingIndicator(mensaje: 'Cargando perfil...');
                  }
                  if (state.status == PerfilStatus.sinSesion || state.usuario == null) {
                    return const Center(child: Text('No hay sesión activa'));
                  }

                  final u = state.usuario!;
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
                        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cambiarPassword),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
