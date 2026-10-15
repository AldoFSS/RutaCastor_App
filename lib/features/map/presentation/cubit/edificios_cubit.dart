import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/edificio_entity.dart';
import 'edificio_state.dart';

class EdificiosCubit extends Cubit<EdificiosState> {
  EdificiosCubit() : super(const EdificiosCargando());

  Future<void> cargar() async {
    emit(const EdificiosCargando());
    await Future<void>.delayed(const Duration(milliseconds: 150));
    emit(EdificiosCargado(_edificiosDemo()));
  }

  List<EdificioEntity> _edificiosDemo() {
    return const [
      EdificioEntity(
        id: 'a1',
        nombre: 'A1',
        descripcion: 'Edificio académico principal.',
        contorno: [
          Offset(0.10, 0.18),
          Offset(0.30, 0.18),
          Offset(0.30, 0.42),
          Offset(0.10, 0.42),
        ],
      ),
      EdificioEntity(
        id: 'b2',
        nombre: 'B2',
        descripcion: 'Edificio de laboratorio y aulas.',
        contorno: [
          Offset(0.42, 0.12),
          Offset(0.70, 0.12),
          Offset(0.70, 0.38),
          Offset(0.42, 0.38),
        ],
      ),
      EdificioEntity(
        id: 'c3',
        nombre: 'C3',
        descripcion: 'Bloque de servicios y bienestar.',
        contorno: [
          Offset(0.20, 0.58),
          Offset(0.52, 0.58),
          Offset(0.52, 0.82),
          Offset(0.20, 0.82),
        ],
      ),
    ];
  }
}