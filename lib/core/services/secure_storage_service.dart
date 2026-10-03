import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Maneja la persistencia local de la sesión (uid, rol, token) usando
/// flutter_secure_storage para datos sensibles.
///
/// Es un Singleton: debe existir una única instancia en toda la app para
/// evitar múltiples conexiones al almacenamiento seguro del dispositivo
/// y no duplicar lecturas/escrituras de la sesión.
class SecureStorageService {
  SecureStorageService._internal();
  static final SecureStorageService instance = SecureStorageService._internal();
  factory SecureStorageService() => instance;

  final _storage = const FlutterSecureStorage();

  static const _kToken = 'auth_token';
  static const _kUid = 'auth_uid';
  static const _kRol = 'auth_rol';

  Future<void> guardarSesion({
    required String uid,
    required String rol,
    String? token,
  }) async {
    await _storage.write(key: _kUid, value: uid);
    await _storage.write(key: _kRol, value: rol);
    if (token != null) {
      await _storage.write(key: _kToken, value: token);
    }
  }

  Future<String?> obtenerUid() => _storage.read(key: _kUid);
  Future<String?> obtenerRol() => _storage.read(key: _kRol);
  Future<String?> obtenerToken() => _storage.read(key: _kToken);

  Future<bool> haySesionGuardada() async {
    final uid = await obtenerUid();
    return uid != null && uid.isNotEmpty;
  }

  Future<void> limpiarSesion() async {
    await _storage.delete(key: _kToken);
    await _storage.delete(key: _kUid);
    await _storage.delete(key: _kRol);
  }
}
