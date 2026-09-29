import '../../domain/entities/usuario.dart';

enum ListaUsuariosStatus { cargando, listo, error }

class ListaUsuariosState {
  final ListaUsuariosStatus status;
  final List<Usuario> usuarios;
  final String? mensajeError;

  const ListaUsuariosState({
    this.status = ListaUsuariosStatus.cargando,
    this.usuarios = const [],
    this.mensajeError,
  });

  ListaUsuariosState copyWith({
    ListaUsuariosStatus? status,
    List<Usuario>? usuarios,
    String? mensajeError,
  }) {
    return ListaUsuariosState(
      status: status ?? this.status,
      usuarios: usuarios ?? this.usuarios,
      mensajeError: mensajeError,
    );
  }
}
