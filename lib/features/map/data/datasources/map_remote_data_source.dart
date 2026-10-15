import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/espacio_model.dart';

abstract class MapRemoteDataSource {
  Future<List<EspacioModel>> obtenerEspacios();
}

class MapRemoteDataSourceImpl implements MapRemoteDataSource {
  final FirebaseFirestore _db;
  MapRemoteDataSourceImpl({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  @override
  Future<List<EspacioModel>> obtenerEspacios() async {
    final snap = await _db.collection('espacios').get();
    return snap.docs.map((d) => EspacioModel.fromMap(d.data(), d.id)).toList();
  }
}
