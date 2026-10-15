import 'package:flutter/material.dart';
import '../features/map/domain/entities/espacio_entity.dart';

/// Ícono del marcador según el tipo de espacio.
class EspacioMarker extends StatelessWidget {
  final EspacioEntity espacio;
  final VoidCallback onTap;

  const EspacioMarker({super.key, required this.espacio, required this.onTap});

  IconData get _icono {
    switch (espacio.tipo) {
      case TipoEspacio.aula:
        return Icons.school;
      case TipoEspacio.laboratorio:
        return Icons.science;
      case TipoEspacio.taller:
        return Icons.build;
      case TipoEspacio.coordinacion:
        return Icons.badge;
      case TipoEspacio.comedor:
        return Icons.restaurant;
      case TipoEspacio.areaEstudio:
        return Icons.menu_book;
      case TipoEspacio.otro:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(_icono, color: Colors.white, size: 20),
      ),
    );
  }
}