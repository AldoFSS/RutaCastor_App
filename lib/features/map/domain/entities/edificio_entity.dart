import 'dart:ui';

import 'package:equatable/equatable.dart';

class EdificioEntity extends Equatable {
  final String id;
  final String nombre;
  final String descripcion;

  /// Puntos del contorno como fracción del ancho/alto de la imagen (0.0–1.0),
  /// en el orden en que se trazan (como conectar los puntos de un dibujo).
  final List<Offset> contorno;

  const EdificioEntity({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.contorno,
  });

  @override
  List<Object?> get props => [id, nombre, descripcion, contorno];
}
