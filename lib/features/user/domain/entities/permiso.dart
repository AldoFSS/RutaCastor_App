/// Entidad de dominio para un permiso asociado a un rol.
class Permiso {
  final String id;
  final String nombre;
  final String descripcion;

  const Permiso({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });
}
