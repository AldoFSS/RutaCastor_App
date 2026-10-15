class Edificio {
  final String id;
  final String codigo;
  final String nombre;
  final String tipo;
  final String descripcion;
  final String tallerAsociado;
  final List<String> carreras;

  Edificio({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.tipo,
    required this.descripcion,
    required this.tallerAsociado,
    required this.carreras,
  });

  factory Edificio.fromMap(Map<String, dynamic> map, String docId) {
    return Edificio(
      id: docId,
      codigo: map['codigo'] ?? docId,
      nombre: map['nombre'] ?? '',
      tipo: map['tipo'] ?? '',
      descripcion: map['descripcion'] ?? '',
      tallerAsociado: map['tallerAsociado'] ?? '',
      carreras: List<String>.from(map['carreras'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'tipo': tipo,
      'descripcion': descripcion,
      'tallerAsociado': tallerAsociado,
      'carreras': carreras,
    };
  }
}