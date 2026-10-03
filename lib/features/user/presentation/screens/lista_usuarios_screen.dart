import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/mock/mock_usuarios.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/guest_banner.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../domain/entities/rol.dart';
import '../../../../core/widgets/access_denied_screen.dart';
import '../cubit/lista_usuarios_cubit.dart';
import '../cubit/lista_usuarios_state.dart';
import 'detalle_usuario_screen.dart';

/// Accesible para el rol admin. En modo invitado se navega aquí con datos
/// de ejemplo (ver [MockUsuarios]) solo para poder ver la pantalla.
class ListaUsuariosScreen extends StatelessWidget {
  const ListaUsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final esInvitado = authCubit.esInvitado;
    final esAdmin = authCubit.state.usuario?.rol == TipoRol.admin;

    if (!esAdmin && !esInvitado) {
      return const AccessDeniedScreen();
    }

    return BlocProvider(
      create: (_) => sl<ListaUsuariosCubit>(
        param1: esInvitado ? MockUsuarios.listaDemo : null,
      )..observar(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Usuarios')),
        body: Column(
          children: [
            if (esInvitado) const GuestBanner(),
            Expanded(
              child: BlocConsumer<ListaUsuariosCubit, ListaUsuariosState>(
                listener: (context, state) {
                  if (state.status == ListaUsuariosStatus.error &&
                      state.mensajeError != null) {
                    ErrorDialog.showSnackBar(context, state.mensajeError!);
                  }
                },
                builder: (context, state) {
                  if (state.status == ListaUsuariosStatus.cargando) {
                    return const LoadingIndicator(
                        mensaje: 'Cargando usuarios...');
                  }
                  if (state.status == ListaUsuariosStatus.error) {
                    return Center(
                        child: Text(state.mensajeError ?? 'Ocurrió un error'));
                  }
                  if (state.usuarios.isEmpty) {
                    return const Center(
                        child: Text('No hay usuarios registrados'));
                  }

                  return ListView.separated(
                    itemCount: state.usuarios.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, i) {
                      final u = state.usuarios[i];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              u.activo ? AppColors.success : AppColors.error,
                          child: Text(
                            u.nombre.isNotEmpty
                                ? u.nombre[0].toUpperCase()
                                : '?',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(u.nombreCompleto),
                        subtitle: Text('${u.correo} · ${u.rol.name}'),
                        trailing: Switch(
                          value: u.activo,
                          onChanged: (val) => context
                              .read<ListaUsuariosCubit>()
                              .cambiarEstadoActivo(u.id, val),
                        ),
                        onTap: () {
                          if (esInvitado) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => DetalleUsuarioScreen(
                                  uid: u.id, usuarioDemo: u),
                            ));
                          } else {
                            Navigator.of(context).pushNamed(
                                AppRoutes.usuarioDetalle,
                                arguments: u.id);
                          }
                        },
                      );
                    },
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
