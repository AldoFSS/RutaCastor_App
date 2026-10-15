import 'package:flutter/material.dart';
import '../models/edificio_model.dart';
import '../services/edificio_service.dart';
import 'formulario_edificio_screen.dart';

class DetalleEdificioScreen extends StatelessWidget {
  final Edificio edificio;

  const DetalleEdificioScreen({super.key, required this.edificio});

  IconData _obtenerIconoTipo(String tipo) {
    switch (tipo) {
      case 'Académico':
        return Icons.school;
      case 'Taller':
        return Icons.build;
      case 'Administrativo':
        return Icons.business;
      case 'Servicio':
        return Icons.local_convenience_store;
      default:
        return Icons.domain;
    }
  }

  Color _obtenerColorTipo(String tipo) {
    switch (tipo) {
      case 'Académico':
        return Colors.blue;
      case 'Taller':
        return Colors.orange;
      case 'Administrativo':
        return Colors.purple;
      case 'Servicio':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorTipo = _obtenerColorTipo(edificio.tipo);

    return Scaffold(
      appBar: AppBar(
        title: Text('${edificio.codigo} - ${edificio.nombre}'),
        backgroundColor: colorTipo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FormularioEdificioScreen(edificio: edificio),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmar = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmar eliminación'),
                  content: Text('¿Deseas eliminar el edificio ${edificio.nombre}?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );

              if (confirmar == true && context.mounted) {
                await EdificioService().eliminarEdificio(edificio.id);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera con icono e información principal
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: colorTipo.withValues(alpha: 0.2),
                      child: Icon(
                        _obtenerIconoTipo(edificio.tipo),
                        size: 32,
                        color: colorTipo,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            edificio.nombre,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Chip(
                            avatar: Icon(
                              _obtenerIconoTipo(edificio.tipo),
                              size: 16,
                              color: colorTipo,
                            ),
                            label: Text(
                              edificio.tipo,
                              style: TextStyle(
                                color: colorTipo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: colorTipo.withValues(alpha: 0.15),
                            side: BorderSide.none,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sección de Descripción
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    edificio.descripcion.isNotEmpty
                        ? edificio.descripcion
                        : 'Sin descripción disponible.',
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Taller Asociado (si aplica)
            if (edificio.tallerAsociado.isNotEmpty) ...[
              const Text(
                'Taller Vinculado',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 2,
                color: Colors.orange.shade50,
                child: ListTile(
                  leading: const Icon(Icons.build, color: Colors.orange),
                  title: Text(
                    'Taller ${edificio.tallerAsociado}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Este edificio académico está vinculado al taller ${edificio.tallerAsociado}.',
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Lista de Carreras
            if (edificio.carreras.isNotEmpty) ...[
              const Text(
                'Carreras e Ingenierías Impartidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...edificio.carreras.map(
                (carrera) => Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.school_outlined, color: Colors.blueAccent),
                    title: Text(carrera),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}