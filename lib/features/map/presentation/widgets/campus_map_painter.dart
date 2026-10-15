import 'package:flutter/material.dart';

import '../../domain/entities/edificio_entity.dart';

/// Dibuja ENCIMA del croquis solo los edificios resaltados/seleccionados.
/// Los demás son invisibles (pero siguen siendo "tocables").
class CampusMapPainter extends CustomPainter {
  final List<EdificioEntity> edificios;
  final Set<String> resaltados;
  final String? seleccionadoId;
  final List<Offset> puntosCalibracion;

  CampusMapPainter({
    required this.edificios,
    this.resaltados = const {},
    this.seleccionadoId,
    this.puntosCalibracion = const [],
  });

  Path _path(EdificioEntity e, Size size) {
    final path = Path();
    for (var i = 0; i < e.contorno.length; i++) {
      final p = Offset(e.contorno[i].dx * size.width, e.contorno[i].dy * size.height);
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    return path..close();
  }

  /// [posicion] debe estar en coordenadas locales del mapa (la imagen).
  EdificioEntity? edificioEnPosicion(Offset posicion, Size size) {
    for (final e in edificios.reversed) {
      if (_path(e, size).contains(posicion)) return e;
    }
    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in edificios) {
      final seleccionado = e.id == seleccionadoId;
      final resaltado = resaltados.contains(e.id);
      if (!seleccionado && !resaltado) continue;

      final base = seleccionado ? Colors.blue : Colors.amber;
      final path = _path(e, size);

      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = base.withAlpha(110),
      );
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5
          ..strokeJoin = StrokeJoin.round
          ..color = base.shade700,
      );
      _etiqueta(canvas, e, size);
    }

    _dibujarCalibracion(canvas, size);
  }

  void _etiqueta(Canvas canvas, EdificioEntity e, Size size) {
    if (e.contorno.isEmpty) return;
    final centro = e.contorno.fold<Offset>(Offset.zero, (a, b) => a + b) /
        e.contorno.length.toDouble();
    final tp = TextPainter(
      text: TextSpan(
        text: e.nombre,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          shadows: [Shadow(color: Colors.white, blurRadius: 4)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(centro.dx * size.width - tp.width / 2,
          centro.dy * size.height - tp.height / 2),
    );
  }

  void _dibujarCalibracion(Canvas canvas, Size size) {
    if (puntosCalibracion.isEmpty) return;
    final pts = puntosCalibracion
        .map((p) => Offset(p.dx * size.width, p.dy * size.height))
        .toList();
    final linea = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < pts.length - 1; i++) {
      canvas.drawLine(pts[i], pts[i + 1], linea);
    }
    for (final p in pts) {
      canvas.drawCircle(p, 5, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CampusMapPainter old) =>
      old.edificios != edificios ||
      old.resaltados != resaltados ||
      old.seleccionadoId != seleccionadoId ||
      old.puntosCalibracion != puntosCalibracion;
}
