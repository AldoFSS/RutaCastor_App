/// Roles disponibles dentro de RutaCastor.
enum TipoRol { admin, alumno, staff }

/// Entidad de dominio que describe un rol (nombre público y descripción).
/// Hoy el control de acceso se basa en el enum [TipoRol]; esta entidad
/// queda lista para cuando el catálogo de roles se administre desde la app.
class Rol {
  final String id;
  final String nombre;
  final String descripcion;

  const Rol({
    required this.id,
    required this.nombre,
    required this.descripcion,
  });
}
