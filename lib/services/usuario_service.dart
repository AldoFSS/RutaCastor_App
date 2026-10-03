import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/usuario.dart';

class UsuarioService {
  UsuarioService._internal();
  static final UsuarioService instance = UsuarioService._internal();
  factory UsuarioService() => instance;

  final CollectionReference<Map<String, dynamic>> _col =
      FirebaseFirestore.instance.collection('usuarios');

  Future<Usuario?> obtenerPorId(String id) async {
    final doc = await _col.doc(id).get();
    if (!doc.exists) return null;
    return Usuario.fromMap(doc.data()!, doc.id);
  }

  Stream<List<Usuario>> obtenerTodos() {
    return _col.orderBy('nombre').snapshots().map(
          (snap) => snap.docs
              .map((d) => Usuario.fromMap(d.data(), d.id))
              .toList(),
        );
  }

  Future<void> actualizar(Usuario usuario) async {
    await _col.doc(usuario.id).update(usuario.toMap());
  }

  Future<void> actualizarCampos(String id, Map<String, dynamic> campos) async {
    await _col.doc(id).update(campos);
  }

  Future<void> cambiarEstadoActivo(String id, bool activo) async {
    await _col.doc(id).update({'activo': activo});
  }

  Future<void> eliminar(String id) async {
    await _col.doc(id).delete();
  }
}
