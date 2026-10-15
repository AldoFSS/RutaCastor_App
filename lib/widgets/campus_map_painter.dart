import 'package:flutter/material.dart';

import '../features/map/domain/entities/edificio_entity.dart';

class CampusMapPainter extends CustomPainter {
  final List<EdificioEntity> edificios;
  final String? edificioSeleccionadoId;

  CampusMapPainter({required this.edificios, this.edificioSeleccionadoId});

  Path _pathDeEdificio(EdificioEntity e, Size size) {
    final path = Path();
    if (e.contorno.isEmpty) return path;
    final primero = e.contorno.first;
    path.moveTo(primero.dx * size.width, primero.dy * size.height);
    for (final punto in e.contorno.skip(1)) {
      path.lineTo(punto.dx * size.width, punto.dy * size.height);
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in edificios) {
      final path = _pathDeEdificio(e, size);
      final isSeleccionado = e.id == edificioSeleccionadoId;

      final relleno = Paint()
        ..color = isSeleccionado
            ? Colors.orange.withValues(alpha: 0.35)
            : Colors.blueGrey.withValues(alpha: 0.18)
        ..style = PaintingStyle.fill;
      final borde = Paint()
        ..color = isSeleccionado ? Colors.orange : Colors.blueGrey
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      canvas.drawPath(path, relleno);
      canvas.drawPath(path, borde);
    }
  }

  EdificioEntity? edificioEnPosicion(Offset posicion, Size size) {
    for (final e in edificios) {
      final path = _pathDeEdificio(e, size);
      if (path.contains(posicion)) return e;
    }
    return null;
  }

  @override
  bool shouldRepaint(CampusMapPainter oldDelegate) =>
      oldDelegate.edificioSeleccionadoId != edificioSeleccionadoId ||
      oldDelegate.edificios != edificios;
}