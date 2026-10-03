import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../models/rol.dart';
import '../services/usuario_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/custom_button.dart';
import '../widgets/error_dialog.dart';

/// Detalle de un usuario específico, solo para admin.
/// Recibe el uid del usuario como argumento de la ruta:
///   Navigator.of(context).pushNamed('/usuarios/detalle', arguments: uid);
class DetalleUsuarioScreen extends StatefulWidget {
  final String uid;
  const DetalleUsuarioScreen({super.key, required this.uid});

  @override
  State<DetalleUsuarioScreen> createState() => _DetalleUsuarioScreenState();
}

class _DetalleUsuarioScreenState extends State<DetalleUsuarioScreen> {
  Usuario? _usuario;
  bool _cargando = true;
  bool _guardando = false;
  TipoRol? _rolSeleccionado;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final u = await UsuarioService.instance.obtenerPorId(widget.uid);
    if (!mounted) return;
    setState(() {
      _usuario = u;
      _rolSeleccionado = u?.rol;
      _cargando = false;
    });
  }

  Future<void> _guardarCambios() async {
    if (_usuario == null || _rolSeleccionado == null) return;
    setState(() => _guardando = true);
    try {
      await UsuarioService.instance.actualizarCampos(
        _usuario!.id,
        {'rol': Rol.tipoToString(_rolSeleccionado!)},
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario actualizado')),
        );
      }
    } catch (_) {
      if (mounted) ErrorDialog.showSnackBar(context, 'No se pudo actualizar el usuario');
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  Future<void> _confirmarEliminar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: const Text('Esta acción no se puede deshacer. ¿Continuar?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirmar == true && _usuario != null) {
      await UsuarioService.instance.eliminar(_usuario!.id);
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de usuario'),
        actions: [
          if (_usuario != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Eliminar usuario',
              onPressed: _confirmarEliminar,
            ),
        ],
      ),
      body: _cargando
          ? const LoadingIndicator(mensaje: 'Cargando usuario...')
          : _usuario == null
              ? const Center(child: Text('Usuario no encontrado'))
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(_usuario!.nombreCompleto,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(_usuario!.correo,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 24),
                    ListTile(
                      leading: const Icon(Icons.badge_outlined),
                      title: const Text('Matrícula'),
                      subtitle: Text(_usuario!.matricula.isEmpty ? '—' : _usuario!.matricula),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone_outlined),
                      title: const Text('Teléfono'),
                      subtitle: Text(_usuario!.telefono.isEmpty ? '—' : _usuario!.telefono),
                    ),
                    SwitchListTile(
                      secondary: const Icon(Icons.toggle_on_outlined),
                      title: const Text('Cuenta activa'),
                      value: _usuario!.activo,
                      onChanged: (val) async {
                        await UsuarioService.instance.cambiarEstadoActivo(_usuario!.id, val);
                        setState(() => _usuario = _usuario!.copyWith(activo: val));
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Rol', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<TipoRol>(
                      initialValue: _rolSeleccionado,
                      items: TipoRol.values
                          .map((r) => DropdownMenuItem(value: r, child: Text(r.name)))
                          .toList(),
                      onChanged: (val) => setState(() => _rolSeleccionado = val),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      label: 'Guardar cambios',
                      loading: _guardando,
                      onPressed: _guardarCambios,
                    ),
                  ],
                ),
    );
  }
}
