class Categoria {
  final String id;
  final String nombre;
  final String icono;

  Categoria({
    required this.id,
    required this.nombre,
    required this.icono,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'] ?? json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      icono: json['icono'] ?? 'help_outline',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'icono': icono,
    };
  }
}