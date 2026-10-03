import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/error/app_exceptions.dart';
import '../../../user/data/models/usuario_model.dart';

/// Fuente de datos remota de autenticación: habla directamente con
/// Firebase Auth y con la colección `usuarios` de Firestore.
abstract class AuthRemoteDataSource {
  String? get uidActual;

  Future<UsuarioModel?> obtenerUsuarioActual();

  Future<UsuarioModel> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  });

  Future<UsuarioModel> login({
    required String correo,
    required String password,
  });

  Future<void> logout();

  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  });

  Future<void> enviarCorreoRecuperacion(String correo);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  String? get uidActual => auth.currentUser?.uid;

  @override
  Future<UsuarioModel?> obtenerUsuarioActual() async {
    final usuarioAuth = auth.currentUser;
    if (usuarioAuth == null) return null;

    final doc =
        await firestore.collection('usuarios').doc(usuarioAuth.uid).get();
    if (!doc.exists) return null;
    return UsuarioModel.fromMap(doc.data()!, doc.id);
  }

  @override
  Future<UsuarioModel> registrar({
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String matricula,
    required String telefono,
  }) async {
    User? usuarioCreado;
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: correo.trim(),
        password: password,
      );

      usuarioCreado = credential.user;
      final uid = usuarioCreado!.uid;
      final usuario = UsuarioModel(
        id: uid,
        nombre: nombre.trim(),
        apellido: apellido.trim(),
        correo: correo.trim(),
        matricula: matricula.trim(),
        telefono: telefono.trim(),
      );

      await firestore.collection('usuarios').doc(uid).set(usuario.toMap());
      return usuario;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    } on FirebaseException catch (e) {
      await _eliminarUsuarioCreado(usuarioCreado);
      throw AuthException(_mensajeErrorFirebase(e));
    } catch (_) {
      await _eliminarUsuarioCreado(usuarioCreado);
      throw AuthException(
          'No se pudo guardar el perfil del usuario. Intenta nuevamente.');
    }
  }

  @override
  Future<UsuarioModel> login({
    required String correo,
    required String password,
  }) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: correo.trim(),
        password: password,
      );

      final uid = credential.user!.uid;
      final doc = await firestore.collection('usuarios').doc(uid).get();

      if (!doc.exists) {
        throw AuthException('No se encontró el perfil del usuario');
      }

      final usuario = UsuarioModel.fromMap(doc.data()!, uid);

      if (!usuario.activo) {
        await auth.signOut();
        throw AuthException(
            'Tu cuenta está desactivada. Contacta a control escolar.');
      }

      return usuario;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    }
  }

  @override
  Future<void> logout() => auth.signOut();

  @override
  Future<void> cambiarPassword({
    required String passwordActual,
    required String passwordNueva,
  }) async {
    final user = auth.currentUser;
    if (user == null || user.email == null) {
      throw AuthException('No hay una sesión activa');
    }
    try {
      final credencial = EmailAuthProvider.credential(
        email: user.email!,
        password: passwordActual,
      );
      await user.reauthenticateWithCredential(credencial);
      await user.updatePassword(passwordNueva);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_mensajeError(e.code));
    }
  }

  @override
  Future<void> enviarCorreoRecuperacion(String correo) async {
    try {
      await auth.sendPasswordResetEmail(email: correo.trim());
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
        return 'La contraseña es demasiado débil';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      case 'requires-recent-login':
        return 'Por seguridad, vuelve a iniciar sesión e inténtalo de nuevo';
      default:
        return 'Ocurrió un error de autenticación ($code)';
    }
  }

  Future<void> _eliminarUsuarioCreado(User? usuario) async {
    if (usuario == null) return;
    try {
      await usuario.delete();
    } catch (_) {
      // El error original es más útil para la UI; la cuenta se puede borrar
      // manualmente desde Firebase Authentication si la reversión falla.
    }
  }

  String _mensajeErrorFirebase(FirebaseException error) {
    switch (error.code) {
      case 'permission-denied':
        return 'Firestore rechazó el registro. Revisa las reglas de la colección usuarios.';
      case 'failed-precondition':
        return 'Firestore no está habilitado o necesita configuración en Firebase Console.';
      case 'unavailable':
        return 'Firestore no está disponible. Revisa tu conexión e inténtalo de nuevo.';
      default:
        return 'No se pudo guardar el perfil en Firestore (${error.code}).';
    }
  }
}
