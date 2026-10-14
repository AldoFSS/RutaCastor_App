import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/mock/mock_espacios.dart';
import '../models/espacio_model.dart';

/// Acceso a Firestore para la colección `espacios`.
///
/// La instancia normal usa Firestore. La instancia `demo()` expone datos de
/// muestra en memoria para poder navegar la app sin Firebase configurado.
class EspacioService {
  EspacioService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _espaciosDemo = null;

  EspacioService.demo()
      : _firestore = null,
        _espaciosDemo = List.of(MockEspacios.listaDemo);

  final FirebaseFirestore? _firestore;
  final List<EspacioModel>? _espaciosDemo;

  CollectionReference<Map<String, dynamic>> get _coleccion {
    final firestore = _firestore;
    if (firestore == null) {
      throw StateError('Esta operación requiere una instancia de Firestore.');
    }
    return firestore.collection('espacios');
  }

  Future<void> crearEspacio(EspacioModel espacio) async {
    _validarId(espacio.id);
    _validarEspacio(espacio.toMap());
    final espaciosDemo = _espaciosDemo;
    if (espaciosDemo != null) {
      if (espaciosDemo.any((item) => item.id == espacio.id)) {
        throw StateError('Ya existe un espacio con el ID "${espacio.id}".');
      }
      espaciosDemo.add(espacio);
      return;
    }

    final firestore = _firestore!;
    final referencia = _coleccion.doc(espacio.id);
    await firestore.runTransaction((transaccion) async {
      final existente = await transaccion.get(referencia);
      if (existente.exists) {
        throw StateError('Ya existe un espacio con el ID "${espacio.id}".');
      }
      transaccion.set(referencia, espacio.toMap());
    });
  }

  Stream<List<EspacioModel>> obtenerEspacios() => obtenerEspaciosFiltrados();

  Stream<List<EspacioModel>> obtenerEspaciosFiltrados({
    String? edificioId,
    String? categoriaId,
  }) {
    final edificio = _filtroNoVacio(edificioId);
    final categoria = _filtroNoVacio(categoriaId);
    final espaciosDemo = _espaciosDemo;

    if (espaciosDemo != null) {
      final filtrados = espaciosDemo
          .where((espacio) =>
              (edificio == null || espacio.edificioId == edificio) &&
              (categoria == null || espacio.categoriaId == categoria))
          .toList()
        ..sort((a, b) => a.nombre.toLowerCase().compareTo(
              b.nombre.toLowerCase(),
            ));
      return Stream.value(filtrados);
    }

    Query<Map<String, dynamic>> consulta = _coleccion;
    if (edificio != null) {
      consulta = consulta.where('edificioId', isEqualTo: edificio);
    }
    if (categoria != null) {
      consulta = consulta.where('categoriaId', isEqualTo: categoria);
    }

    return consulta.snapshots().map((snapshot) {
      final espacios = snapshot.docs
          .map((documento) =>
              EspacioModel.fromMap(documento.data(), documento.id))
          .toList()
        ..sort((a, b) => a.nombre.toLowerCase().compareTo(
              b.nombre.toLowerCase(),
            ));
      return espacios;
    });
  }

  Future<void> actualizarEspacio(
    String id,
    Map<String, dynamic> datos,
  ) async {
    _validarId(id);
    _validarCamposActualizables(datos);

    final espaciosDemo = _espaciosDemo;
    if (espaciosDemo != null) {
      final index = espaciosDemo.indexWhere((espacio) => espacio.id == id);
      if (index == -1) {
        throw StateError('No existe un espacio con el ID "$id".');
      }
      espaciosDemo[index] = EspacioModel.fromMap(
        {
          ...espaciosDemo[index].toMap(),
          ...datos,
          if (datos['imagenUrl'] == null || datos['imagenUrl'] == '')
            'imagenUrl': null,
        },
        id,
      );
      return;
    }

    final datosFirestore = Map<String, dynamic>.from(datos);
    final imagenUrl = datosFirestore['imagenUrl'];
    if (datosFirestore.containsKey('imagenUrl') &&
        (imagenUrl == null ||
            (imagenUrl is String && imagenUrl.trim().isEmpty))) {
      datosFirestore['imagenUrl'] = FieldValue.delete();
    }
    await _coleccion.doc(id).update(datosFirestore);
  }

  Future<void> eliminarEspacio(String id) async {
    _validarId(id);
    final espaciosDemo = _espaciosDemo;
    if (espaciosDemo != null) {
      espaciosDemo.removeWhere((espacio) => espacio.id == id);
      return;
    }
    await _coleccion.doc(id).delete();
  }

  static String? _filtroNoVacio(String? valor) {
    if (valor == null || valor.trim().isEmpty) return null;
    return valor.trim();
  }

  static void _validarId(String id) {
    if (id.trim().isEmpty) {
      throw ArgumentError.value(
          id, 'id', 'El ID del espacio no puede estar vacío.');
    }
  }

  static void _validarCamposActualizables(Map<String, dynamic> datos) {
    const camposPermitidos = {
      'nombre',
      'descripcion',
      'edificioId',
      'categoriaId',
      'imagenUrl',
    };
    if (datos.isEmpty) {
      throw ArgumentError.value(datos, 'datos', 'Indica al menos un campo.');
    }
    final camposInvalidos = datos.keys.toSet().difference(camposPermitidos);
    if (camposInvalidos.isNotEmpty) {
      throw ArgumentError.value(
        camposInvalidos,
        'datos',
        'Hay campos que no pertenecen a un espacio.',
      );
    }
    if (datos.containsKey('nombre') &&
        (datos['nombre'] is! String ||
            (datos['nombre'] as String).trim().isEmpty)) {
      throw ArgumentError.value(
        datos['nombre'],
        'datos.nombre',
        'El nombre del espacio es obligatorio.',
      );
    }
    if (datos.containsKey('descripcion') && datos['descripcion'] is! String) {
      throw ArgumentError.value(
        datos['descripcion'],
        'datos.descripcion',
        'La descripción debe ser texto.',
      );
    }
    for (final campo in ['edificioId', 'categoriaId']) {
      if (datos.containsKey(campo) &&
          (datos[campo] is! String ||
              (datos[campo] as String).trim().isEmpty)) {
        throw ArgumentError.value(
          datos[campo],
          'datos.$campo',
          'La relación con $campo es obligatoria.',
        );
      }
    }
    if (datos.containsKey('imagenUrl') && datos['imagenUrl'] != null) {
      final imagenUrl = datos['imagenUrl'];
      if (imagenUrl is! String ||
          (imagenUrl.trim().isNotEmpty &&
              Uri.tryParse(imagenUrl)?.scheme != 'https')) {
        throw ArgumentError.value(
          imagenUrl,
          'datos.imagenUrl',
          'La imagen debe tener una URL HTTPS válida.',
        );
      }
    }
  }

  static void _validarEspacio(Map<String, dynamic> datos) {
    _validarCamposActualizables(datos);
    for (final campo in [
      'nombre',
      'descripcion',
      'edificioId',
      'categoriaId'
    ]) {
      if (!datos.containsKey(campo)) {
        throw ArgumentError.value(
          datos,
          'espacio',
          'El campo "$campo" es obligatorio.',
        );
      }
    }
  }
}
