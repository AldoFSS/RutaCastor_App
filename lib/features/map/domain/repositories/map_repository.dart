import '../entities/edificio_entity.dart';
import '../entities/espacio_entity.dart';

abstract class MapRepository {
  Future<List<EdificioEntity>> obtenerEdificios();
  Future<List<EspacioEntity>> obtenerEspacios();
}
