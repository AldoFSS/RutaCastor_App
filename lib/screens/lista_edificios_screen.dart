import 'package:flutter/material.dart';
import '../models/edificio_model.dart';
import '../services/edificio_service.dart';
import 'detalle_edificio_screen.dart';
import 'formulario_edificio_screen.dart';

class ListaEdificiosScreen extends StatefulWidget {
  const ListaEdificiosScreen({super.key});

  @override
  State<ListaEdificiosScreen> createState() => _ListaEdificiosScreenState();
}

class _ListaEdificiosScreenState extends State<ListaEdificiosScreen> {
  final EdificioService _edificioService = EdificioService();

  // Asigna icono según el tipo de edificio
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

  // Asigna color según el tipo de edificio
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edificios - RutaCastor'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Edificio>>(
        stream: _edificioService.getEdificios(),
        builder: (context, snapshot) {
          // 1. Cargando datos
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error al cargar los edificios:\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // 3. Lista vacía
          final edificios = snapshot.data ?? [];
          if (edificios.isEmpty) {
            return const Center(
              child: Text(
                'No hay edificios registrados en la base de datos.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // 4. Lista de edificios
          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: edificios.length,
            itemBuilder: (context, index) {
              final edificio = edificios[index];
              final colorTipo = _obtenerColorTipo(edificio.tipo);

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: colorTipo.withValues(alpha: 0.2),
                    child: Icon(
                      _obtenerIconoTipo(edificio.tipo),
                      color: colorTipo,
                    ),
                  ),
                  title: Text(
                    '${edificio.codigo} - ${edificio.nombre}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colorTipo.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            edificio.tipo,
                            style: TextStyle(
                              color: colorTipo,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (edificio.carreras.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Carreras: ${edificio.carreras.join(', ')}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalleEdificioScreen(edificio: edificio),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      // BOTÓN FLOTANTE (+) DENTRO DEL SCAFFOLD
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioEdificioScreen(),
            ),
          );
        },
      ),
    );
  }
}