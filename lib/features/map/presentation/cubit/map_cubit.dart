import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/espacio_entity.dart';
import '../../domain/repositories/map_repository.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapRepository _repository;

  MapCubit({required MapRepository repository})
      : _repository = repository,
        super(const MapCargando());

  Future<void> cargar() async {
    emit(const MapCargando());
    try {
      final edificios = await _repository.obtenerEdificios();
      final espacios = await _repository.obtenerEspacios();
      emit(MapCargado(edificios: edificios, espacios: espacios));
    } catch (_) {
      emit(const MapError('No se pudo cargar el mapa'));
    }
  }

  /// Busca por nombre o por tipo ("baño", "biblioteca", "lab"...).
  /// Ilumina TODOS los edificios que tengan coincidencia.
  void buscar(String texto) {
    final s = state;
    if (s is! MapCargado) return;

    final q = _normalizar(texto.trim());
    if (q.isEmpty) {
      emit(s.copyWith(
        consulta: '',
        resultados: const [],
        resaltados: const {},
        limpiarSeleccion: true,
      ));
      return;
    }

    final resultados = s.espacios
        .where((e) =>
            _normalizar(e.nombre).contains(q) ||
            _normalizar(e.tipo.etiqueta).contains(q))
        .toList();

    final resaltados = <String>{
      ...resultados.map((e) => e.edificioId),
      ...s.edificios
          .where((e) => _normalizar(e.nombre).contains(q))
          .map((e) => e.id),
    };

    emit(s.copyWith(
      consulta: texto,
      resultados: resultados,
      resaltados: resaltados,
      limpiarSeleccion: true,
    ));
  }

  void seleccionar(String? edificioId) {
    final s = state;
    if (s is! MapCargado) return;
    emit(edificioId == null
        ? s.copyWith(limpiarSeleccion: true)
        : s.copyWith(seleccionadoId: edificioId));
  }

  String _normalizar(String s) {
    const de = 'áàäâéèëêíìïîóòöôúùüûñ';
    const a = 'aaaaeeeeiiiioooouuuun';
    var r = s.toLowerCase();
    for (var i = 0; i < de.length; i++) {
      r = r.replaceAll(de[i], a[i]);
    }
    return r;
  }
}
