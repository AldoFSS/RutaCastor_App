import 'package:equatable/equatable.dart';

enum TipoEspacio {
  aula,
  laboratorio,
  taller,
  coordinacion,
  comedor,
  areaEstudio,
  biblioteca,
  bano,
  otro,
}

extension TipoEspacioX on TipoEspacio {
  String get etiqueta {
    switch (this) {
      case TipoEspacio.aula:
        return 'Aula';
      case TipoEspacio.laboratorio:
        return 'Laboratorio';
      case TipoEspacio.taller:
        return 'Taller';
      case TipoEspacio.coordinacion:
        return 'Coordinación';
      case TipoEspacio.comedor:
        return 'Comedor';
      case TipoEspacio.areaEstudio:
        return 'Área de estudio';
      case TipoEspacio.biblioteca:
        return 'Biblioteca';
      case TipoEspacio.bano:
        return 'Baño';
      case TipoEspacio.otro:
        return 'Otro';
    }
  }
}

/// Un lugar dentro de un edificio (baño, biblioteca, laboratorio...).
/// Ya NO lleva latitud/longitud: su posición en el mapa es la de su edificio.
class EspacioEntity extends Equatable {
  final String id;
  final String nombre;
  final TipoEspacio tipo;
  final String edificioId;
  final int piso;
  final String descripcion;

  const EspacioEntity({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.edificioId,
    this.piso = 1,
    this.descripcion = '',
  });

  @override
  List<Object?> get props => [id, nombre, tipo, edificioId, piso, descripcion];
}
