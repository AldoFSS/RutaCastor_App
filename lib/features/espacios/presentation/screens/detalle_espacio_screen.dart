import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/models/espacio_model.dart';
import '../espacio_labels.dart';

class DetalleEspacioScreen extends StatelessWidget {
  const DetalleEspacioScreen({super.key, required this.espacio});

  final EspacioModel espacio;

  @override
  Widget build(BuildContext context) {
    final imagenUrl = espacio.imagenUrl?.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del espacio')),
      body: ListView(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: imagenUrl == null || imagenUrl.isEmpty
                ? const _ImagenEspacioPlaceholder()
                : Image.network(
                    imagenUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const _ImagenEspacioPlaceholder(),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  espacio.nombre,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.category_outlined, size: 18),
                      label: Text(
                        EspacioLabels.categoria(espacio.categoriaId),
                      ),
                    ),
                    Chip(
                      avatar: const Icon(Icons.apartment_outlined, size: 18),
                      label: Text(EspacioLabels.edificio(espacio.edificioId)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Descripción',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  espacio.descripcion.isEmpty
                      ? 'No hay descripción disponible.'
                      : espacio.descripcion,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImagenEspacioPlaceholder extends StatelessWidget {
  const _ImagenEspacioPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary.withValues(alpha: 0.08),
      child: const Center(
        child: Icon(
          Icons.meeting_room_outlined,
          size: 80,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
