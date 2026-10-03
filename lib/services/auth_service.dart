import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/usuario.dart';
import '../models/rol.dart';
import 'storage_service.dart';

class AuthException implements Exception {
  final String mensaje;
  AuthException(this.mensaje);
  @override
  String toString() => mensaje;
}

class AuthService {
  AuthService._internal();
  static final AuthService instance = AuthService._internal();
  factory AuthService() => instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final StorageService _storage = StorageService.instance;

  User? get usuarioActual => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<Usuario> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) async {
    UserCredential? credential;
    final cleanEmail = correo.trim();
    final cleanPassword = password.trim();

    try {
      // 1. Crear usuario en Firebase Auth
      credential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: cleanPassword,
      );

      final uid = credential.user!.uid;
      final usuario = Usuario(
        id: uid,
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        correo: cleanEmail,
        matricula: matricula.trim(),
        telefono: telefono.trim(),
        rol: TipoRol.alumno,
        activo: true,
      );

      // 2. Guardar en Firestore y Storage Local
      try {
        await _db.collection('usuarios').doc(uid).set(usuario.toMap());
        await _storage.guardarSesion(uid: uid, rol: 'alumno');
      } catch (dbError) {
      
        await credential.user?.delete();
        throw AuthException('Error al guardar el perfil en la base de datos: $dbError');
      }

      return usuario;

    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Ocurrió un error inesperado al registrar el usuario.');
    }
  }

  Future<Usuario> login({
    required String correo,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: correo.trim(),
        password: password.trim(), // Se aplica .trim() por seguridad
      );

      final uid = credential.user!.uid;
      final doc = await _db.collection('usuarios').doc(uid).get();

      if (!doc.exists) {
        throw AuthException('No se encontró el perfil del usuario en la base de datos.');
      }

      final usuario = Usuario.fromMap(doc.data()!, uid);

      if (!usuario.activo) {
        await _auth.signOut();
        throw AuthException('Tu cuenta está desactivada. Contacta a control escolar.');
      }

      await _storage.guardarSesion(uid: uid, rol: Rol.tipoToString(usuario.rol));
      return usuario;

    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Error al iniciar sesión: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await _storage.limpiarSesion();
  }

  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  }) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw AuthException('No hay una sesión activa');
    }
    try {
      final credencial = EmailAuthProvider.credential(
        email: user.email!,
        password: passwordActual.trim(),
      );
      await user.reauthenticateWithCredential(credencial);
      await user.updatePassword(passwordNueva.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    }
  }

  Future<void> enviarCorreoRecuperacion(String correo) async {
    try {
      await _auth.sendPasswordResetEmail(email: correo.trim());
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    }
  }

  String _mensajeError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Ese correo ya está registrado';
      case 'invalid-email':
        return 'El correo no es válido';
      case 'weak-password':
        return 'La contraseña es demasiado débil (mínimo 6 caracteres)';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Intenta más tarde';
      case 'requires-recent-login':
        return 'Por seguridad, vuelve a iniciar sesión e inténtalo de nuevo';
      default:
        return 'Ocurrió un error de autenticación ($code)';
    }
  }
}