import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/guest_banner.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../user/domain/entities/rol.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final esInvitado = context.read<AuthCubit>().esInvitado;
    final esAdmin =
        context.watch<AuthCubit>().state.usuario?.rol == TipoRol.admin;

    final opciones = [
      _MenuOpcion('Mapa del campus', Icons.map_outlined, '/mapa'),
      _MenuOpcion('Trámites', Icons.assignment_turned_in_outlined, '/tramites'),
      _MenuOpcion('Copiloto IA', Icons.smart_toy_outlined, '/copiloto'),
      _MenuOpcion(
          'Eventos y vida universitaria', Icons.event_outlined, '/eventos'),
      _MenuOpcion('Mi perfil', Icons.person_outline, AppRoutes.perfil),
      // Solo visible en modo invitado, para poder llegar a la
      // administración de usuarios sin ser realmente admin.
      if (esInvitado)
        _MenuOpcion(
            'Usuarios (demo)', Icons.people_outline, AppRoutes.usuarios),
      if (esAdmin)
        _MenuOpcion('Gestionar usuarios', Icons.manage_accounts_outlined,
            AppRoutes.usuarios),
    ];

    final rutasNavegables = {AppRoutes.perfil, AppRoutes.usuarios};

    return Scaffold(
      appBar: AppBar(title: const Text('RutaCastor')),
      body: Column(
        children: [
          if (esInvitado) const GuestBanner(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: opciones.length,
                itemBuilder: (context, i) {
                  final o = opciones[i];
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // Módulos de mapa, trámites, copiloto y eventos
                        // se conectan en fases posteriores del sprint.
                        if (rutasNavegables.contains(o.ruta)) {
                          Navigator.of(context).pushNamed(o.ruta);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(o.icono, size: 40, color: AppColors.primary),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              o.titulo,
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuOpcion {
  final String titulo;
  final IconData icono;
  final String ruta;
  _MenuOpcion(this.titulo, this.icono, this.ruta);
}
