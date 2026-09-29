import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../../core/widgets/access_denied_screen.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/rol.dart';
import '../../domain/entities/usuario.dart';
import '../cubit/detalle_usuario_cubit.dart';
import '../cubit/detalle_usuario_state.dart';

/// Recibe el uid del usuario como argumento de la ruta:
///   Navigator.of(context).pushNamed(AppRoutes.usuarioDetalle, arguments: uid);
/// En modo invitado se navega directo pasando [usuarioDemo] (ver
/// ListaUsuariosScreen), sin pasar por la ruta con nombre.
class DetalleUsuarioScreen extends StatelessWidget {
  final String uid;
  final Usuario? usuarioDemo;
  const DetalleUsuarioScreen({super.key, required this.uid, this.usuarioDemo});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final esAdmin = authCubit.state.usuario?.rol == TipoRol.admin;
    if (!esAdmin && !authCubit.esInvitado) {
      return const AccessDeniedScreen();
    }

    return BlocProvider(
      create: (_) =>
          sl<DetalleUsuarioCubit>(param1: uid, param2: usuarioDemo)..cargar(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de usuario'),
          actions: [
            BlocBuilder<DetalleUsuarioCubit, DetalleUsuarioState>(
              builder: (context, state) {
                if (state.usuario == null) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Eliminar usuario',
                  onPressed: () => _confirmarEliminar(context),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<DetalleUsuarioCubit, DetalleUsuarioState>(
          listener: (context, state) {
            if (state.status == DetalleUsuarioStatus.error &&
                state.mensajeError != null) {
              ErrorDialog.showSnackBar(context, state.mensajeError!);
            } else if (state.mensajeExito != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.mensajeExito!)),
              );
            }
          },
          builder: (context, state) {
            if (state.status == DetalleUsuarioStatus.cargando) {
              return const LoadingIndicator(mensaje: 'Cargando usuario...');
            }
            if (state.status == DetalleUsuarioStatus.noEncontrado ||
                state.usuario == null) {
              return const Center(child: Text('Usuario no encontrado'));
            }

            final u = state.usuario!;
            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Text(u.nombreCompleto,
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(u.correo, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 24),
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text('Matrícula'),
                  subtitle: Text(u.matricula.isEmpty ? '—' : u.matricula),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_outlined),
                  title: const Text('Teléfono'),
                  subtitle: Text(u.telefono.isEmpty ? '—' : u.telefono),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.toggle_on_outlined),
                  title: const Text('Cuenta activa'),
                  value: u.activo,
                  onChanged: (val) => context
                      .read<DetalleUsuarioCubit>()
                      .cambiarEstadoActivo(val),
                ),
                const SizedBox(height: 16),
                Text('Rol', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                DropdownButtonFormField<TipoRol>(
                  initialValue: state.rolSeleccionado,
                  items: TipoRol.values
                      .map((r) =>
                          DropdownMenuItem(value: r, child: Text(r.name)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<DetalleUsuarioCubit>().seleccionarRol(val);
                    }
                  },
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: 'Guardar cambios',
                  loading: state.status == DetalleUsuarioStatus.guardando,
                  onPressed: () =>
                      context.read<DetalleUsuarioCubit>().guardarCambios(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmarEliminar(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: const Text('Esta acción no se puede deshacer. ¿Continuar?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirmar == true && context.mounted) {
      await context.read<DetalleUsuarioCubit>().eliminar();
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}
