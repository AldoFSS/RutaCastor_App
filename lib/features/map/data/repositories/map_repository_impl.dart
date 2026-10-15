import '../../domain/entities/edificio_entity.dart';
import '../../domain/entities/espacio_entity.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/map_local_data_source.dart';
import '../datasources/map_remote_data_source.dart';

class MapRepositoryImpl implements MapRepository {
  final MapRemoteDataSource _remote;
  final MapLocalDataSource _local;

  MapRepositoryImpl({
    required MapRemoteDataSource remoteDataSource,
    MapLocalDataSource localDataSource = const MapLocalDataSource(),
  })  : _remote = remoteDataSource,
        _local = localDataSource;

  @override
  Future<List<EdificioEntity>> obtenerEdificios() async =>
      _local.obtenerEdificios();

  @override
  Future<List<EspacioEntity>> obtenerEspacios() async {
    try {
      final remotos = await _remote.obtenerEspacios();
      if (remotos.isNotEmpty) return remotos;
    } catch (_) {
      // Sin red o Firestore sin configurar: caemos a los datos demo.
    }
    return _local.espaciosDemo();
  }
}
