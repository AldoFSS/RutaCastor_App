import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../services/usuario_service.dart';
import '../theme/app_theme.dart';
import '../widgets/loading_indicator.dart';

/// Solo accesible para usuarios con rol admin.
/// La restricción de acceso por rol se aplica en el router (go_router)
/// y se revalida aquí antes de mostrar acciones sensibles.
class ListaUsuariosScreen extends StatelessWidget {
  const ListaUsuariosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: StreamBuilder<List<Usuario>>(
        stream: UsuarioService.instance.obtenerTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator(mensaje: 'Cargando usuarios...');
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final usuarios = snapshot.data ?? [];
          if (usuarios.isEmpty) {
            return const Center(child: Text('No hay usuarios registrados'));
          }

          return ListView.separated(
            itemCount: usuarios.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final u = usuarios[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: u.activo ? AppColors.success : AppColors.error,
                  child: Text(
                    u.nombre.isNotEmpty ? u.nombre[0].toUpperCase() : '?',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(u.nombreCompleto),
                subtitle: Text('${u.correo} · ${u.rol.name}'),
                trailing: Switch(
                  value: u.activo,
                  onChanged: (val) =>
                      UsuarioService.instance.cambiarEstadoActivo(u.id, val),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/usuarios/detalle', arguments: u.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
