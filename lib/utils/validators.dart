class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  static String? requerido(String? value, {String campo = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$campo es obligatorio';
    }
    return null;
  }

  static String? correo(String? value) {
    final req = requerido(value, campo: 'El correo');
    if (req != null) return req;
    if (!_emailRegex.hasMatch(value!.trim())) {
      return 'Ingresa un correo válido';
    }
    return null;
  }

  static String? password(String? value) {
    final req = requerido(value, campo: 'La contraseña');
    if (req != null) return req;
    if (value!.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }

  static String? confirmarPassword(String? value, String original) {
    final req = requerido(value, campo: 'Confirmar contraseña');
    if (req != null) return req;
    if (value != original) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  static String? matricula(String? value) {
    final req = requerido(value, campo: 'La matrícula');
    if (req != null) return req;
    if (value!.trim().length < 5) {
      return 'Matrícula inválida';
    }
    return null;
  }

  static String? telefono(String? value) {
    final req = requerido(value, campo: 'El teléfono');
    if (req != null) return req;
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) {
      return 'Ingresa un teléfono a 10 dígitos';
    }
    return null;
  }
}
