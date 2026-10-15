import 'package:equatable/equatable.dart';

import '../../domain/entities/edificio_entity.dart';
import '../../domain/entities/espacio_entity.dart';

abstract class MapState extends Equatable {
  const MapState();
  @override
  List<Object?> get props => [];
}

class MapCargando extends MapState {
  const MapCargando();
}

class MapError extends MapState {
  final String mensaje;
  const MapError(this.mensaje);
  @override
  List<Object?> get props => [mensaje];
}

class MapCargado extends MapState {
  final List<EdificioEntity> edificios;
  final List<EspacioEntity> espacios;
  final String consulta;
  final List<EspacioEntity> resultados;

  /// Edificios que se iluminan por la búsqueda (puede ser más de uno).
  final Set<String> resaltados;

  /// Edificio tocado por el usuario.
  final String? seleccionadoId;

  const MapCargado({
    required this.edificios,
    required this.espacios,
    this.consulta = '',
    this.resultados = const [],
    this.resaltados = const {},
    this.seleccionadoId,
  });

  MapCargado copyWith({
    String? consulta,
    List<EspacioEntity>? resultados,
    Set<String>? resaltados,
    String? seleccionadoId,
    bool limpiarSeleccion = false,
  }) {
    return MapCargado(
      edificios: edificios,
      espacios: espacios,
      consulta: consulta ?? this.consulta,
      resultados: resultados ?? this.resultados,
      resaltados: resaltados ?? this.resaltados,
      seleccionadoId:
          limpiarSeleccion ? null : (seleccionadoId ?? this.seleccionadoId),
    );
  }

  @override
  List<Object?> get props =>
      [edificios, espacios, consulta, resultados, resaltados, seleccionadoId];
}
