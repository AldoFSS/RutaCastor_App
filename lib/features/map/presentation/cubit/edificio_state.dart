import 'package:equatable/equatable.dart';
import '../../domain/entities/edificio_entity.dart';

abstract class EdificiosState extends Equatable {
  const EdificiosState();
  @override
  List<Object?> get props => [];
}

class EdificiosCargando extends EdificiosState {
  const EdificiosCargando();
}

class EdificiosCargado extends EdificiosState {
  final List<EdificioEntity> edificios;
  const EdificiosCargado(this.edificios);
  @override
  List<Object?> get props => [edificios];
}

class EdificiosError extends EdificiosState {
  final String mensaje;
  const EdificiosError(this.mensaje);
  @override
  List<Object?> get props => [mensaje];
}