import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/usuario_model.dart';

/// Fuente de datos remota de usuarios: lee y escribe directamente en la
/// colección `usuarios` de Firestore.
abstract class UsuarioRemoteDataSource {
  Future<UsuarioModel?> obtenerPorId(String id);

  Stream<List<UsuarioModel>> observarTodos();

  Future<void> actualizar(UsuarioModel usuario);

  Future<void> actualizarCampos(String id, Map<String, dynamic> campos);

  Future<void> cambiarEstadoActivo(String id, bool activo);

  Future<void> eliminar(String id);
}

class UsuarioRemoteDataSourceImpl implements UsuarioRemoteDataSource {
  final FirebaseFirestore firestore;

  UsuarioRemoteDataSourceImpl({required this.firestore});

  CollectionReference<Map<String, dynamic>> get _col =>
      firestore.collection('usuarios');

  @override
  Future<UsuarioModel?> obtenerPorId(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return UsuarioModel.fromMap(doc.data()!, doc.id);
  }

  @override
  Stream<List<UsuarioModel>> observarTodos() {
    return _col.orderBy('nombre').snapshots().map(
          (snap) => snap.docs
              .map((d) => UsuarioModel.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  @override
  Future<void> actualizar(UsuarioModel usuario) async {
    await _col.doc(usuario.id).update(usuario.toMap());
  }

  @override
  Future<void> actualizarCampos(String id, Map<String, dynamic> campos) async {
    await _col.doc(id).update(campos);
  }

  @override
  Future<void> cambiarEstadoActivo(String id, bool activo) async {
    await _col.doc(id).update({'activo': activo});
  }

  @override
  Future<void> eliminar(String id) async {
    await _col.doc(id).delete();
  }
}
