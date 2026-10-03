/// Excepciones de dominio para mostrar mensajes claros en la UI,
/// en vez de propagar errores crudos de Firebase u otras fuentes de datos.
class AuthException implements Exception {
  final String mensaje;
  AuthException(this.mensaje);
  @override
  String toString() => mensaje;
}

/// Excepción genérica para errores de datos (Firestore, almacenamiento
/// local, etc.) que no requieren un tipo más específico.
class DataException implements Exception {
  final String mensaje;
  DataException(this.mensaje);
  @override
  String toString() => mensaje;
}
