import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/edificio_model.dart';

class EdificioService {
  final CollectionReference _edificiosRef =
      FirebaseFirestore.instance.collection('edificios');

  // LEER TODOS LOS EDIFICIOS EN TIEMPO REAL
  Stream<List<Edificio>> getEdificios() {
    return _edificiosRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Edificio.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  // LEER UN EDIFICIO POR ID
  Future<Edificio?> getEdificioPorId(String id) async {
    final docSnapshot = await _edificiosRef.doc(id).get();
    if (docSnapshot.exists) {
      return Edificio.fromMap(
        docSnapshot.data() as Map<String, dynamic>,
        docSnapshot.id,
      );
    }
    return null;
  }

  // REGISTRAR UN NUEVO EDIFICIO
  Future<void> agregarEdificio(Edificio edificio) async {
    await _edificiosRef.doc(edificio.codigo).set(edificio.toMap());
  }

  // MODIFICAR UN EDIFICIO EXISTENTE
  Future<void> actualizarEdificio(Edificio edificio) async {
    await _edificiosRef.doc(edificio.id).update(edificio.toMap());
  }

  // ELIMINAR UN EDIFICIO
  Future<void> eliminarEdificio(String id) async {
    await _edificiosRef.doc(id).delete();
  }
}