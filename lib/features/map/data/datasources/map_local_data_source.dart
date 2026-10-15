import 'dart:ui';

import '../../domain/entities/edificio_entity.dart';
import '../../domain/entities/espacio_entity.dart';

/// Los contornos de los edificios dependen de TU imagen del croquis, así que
/// viven en la app (no en Firestore). Usa el modo "Calibrar" de la pantalla
/// para sacar las coordenadas reales y reemplaza estos valores de ejemplo.
class MapLocalDataSource {
  const MapLocalDataSource();

  List<EdificioEntity> obtenerEdificios() {
    return const [
      EdificioEntity(
        id: 'a1',
        nombre: 'A1',
        descripcion: 'Edificio académico principal.',
        contorno: [
          Offset(0.10, 0.18),
          Offset(0.30, 0.18),
          Offset(0.30, 0.42),
          Offset(0.10, 0.42),
        ],
      ),
      EdificioEntity(
        id: 'b2',
        nombre: 'B2',
        descripcion: 'Edificio de laboratorio y aulas.',
        contorno: [
          Offset(0.42, 0.12),
          Offset(0.70, 0.12),
          Offset(0.70, 0.38),
          Offset(0.42, 0.38),
        ],
      ),
      EdificioEntity(
        id: 'c3',
        nombre: 'C3',
        descripcion: 'Bloque de servicios y bienestar.',
        contorno: [
          Offset(0.20, 0.58),
          Offset(0.52, 0.58),
          Offset(0.52, 0.82),
          Offset(0.20, 0.82),
        ],
      ),
    ];
  }

  /// Solo se usan si Firestore falla o está vacío (útil para desarrollar).
  List<EspacioEntity> espaciosDemo() {
    return const [
      EspacioEntity(id: 'e1', nombre: 'Biblioteca', tipo: TipoEspacio.biblioteca, edificioId: 'a1', piso: 1),
      EspacioEntity(id: 'e2', nombre: 'Baños', tipo: TipoEspacio.bano, edificioId: 'a1', piso: 1),
      EspacioEntity(id: 'e3', nombre: 'Baños', tipo: TipoEspacio.bano, edificioId: 'b2', piso: 1),
      EspacioEntity(id: 'e4', nombre: 'Laboratorio de cómputo', tipo: TipoEspacio.laboratorio, edificioId: 'b2', piso: 2),
      EspacioEntity(id: 'e5', nombre: 'Comedor', tipo: TipoEspacio.comedor, edificioId: 'c3', piso: 1),
      EspacioEntity(id: 'e6', nombre: 'Baños', tipo: TipoEspacio.bano, edificioId: 'c3', piso: 1),
    ];
  }
}
