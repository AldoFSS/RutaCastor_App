import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_indicator.dart';
import '../../domain/entities/edificio_entity.dart';
import '../../domain/entities/espacio_entity.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';
import '../widgets/campus_map_painter.dart';

const _rutaCroquis = 'assets/images/campus_croquis.png';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _busquedaCtrl = TextEditingController();

  /// Tamaño real de la imagen, para mantener su proporción y que los
  /// contornos (0..1) siempre caigan sobre los edificios correctos.
  Size? _tamanoImagen;

  bool _calibrando = false;
  final List<Offset> _puntos = [];

  @override
  void initState() {
    super.initState();
    context.read<MapCubit>().cargar();
    _resolverImagen();
  }

  @override
  void dispose() {
    _busquedaCtrl.dispose();
    super.dispose();
  }

  void _resolverImagen() {
    final stream = const AssetImage(_rutaCroquis).resolve(const ImageConfiguration());
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        if (mounted) {
          setState(() => _tamanoImagen =
              Size(info.image.width.toDouble(), info.image.height.toDouble()));
        }
        stream.removeListener(listener);
      },
      onError: (_, __) => stream.removeListener(listener),
    );
    stream.addListener(listener);
  }

  void _alTocar(Offset pos, Size size, CampusMapPainter painter, MapCargado s) {
    if (_calibrando) {
      setState(() => _puntos.add(Offset(pos.dx / size.width, pos.dy / size.height)));
      return;
    }
    final cubit = context.read<MapCubit>();
    final tocado = painter.edificioEnPosicion(pos, size);
    if (tocado == null) {
      cubit.seleccionar(null);
      return;
    }
    cubit.seleccionar(tocado.id);
    _mostrarDetalle(tocado, s.espacios.where((e) => e.edificioId == tocado.id).toList());
  }

  void _mostrarDetalle(EdificioEntity edificio, List<EspacioEntity> espacios) {
    final cubit = context.read<MapCubit>();
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(edificio.nombre, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(edificio.descripcion),
              if (espacios.isNotEmpty) ...[
                const Divider(height: 24),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final e in espacios)
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(_icono(e.tipo)),
                          title: Text(e.nombre),
                          subtitle: Text('${e.tipo.etiqueta} · Piso ${e.piso}'),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    ).whenComplete(() => cubit.seleccionar(null));
  }

  IconData _icono(TipoEspacio t) {
    switch (t) {
      case TipoEspacio.bano:
        return Icons.wc;
      case TipoEspacio.biblioteca:
        return Icons.local_library;
      case TipoEspacio.laboratorio:
        return Icons.science;
      case TipoEspacio.comedor:
        return Icons.restaurant;
      case TipoEspacio.aula:
        return Icons.school;
      case TipoEspacio.taller:
        return Icons.build;
      case TipoEspacio.coordinacion:
        return Icons.badge;
      case TipoEspacio.areaEstudio:
        return Icons.menu_book;
      case TipoEspacio.otro:
        return Icons.place;
    }
  }

  Future<void> _copiarPuntos() async {
    final texto = StringBuffer('contorno: [\n');
    for (final p in _puntos) {
      texto.writeln('  Offset(${p.dx.toStringAsFixed(3)}, ${p.dy.toStringAsFixed(3)}),');
    }
    texto.write('],');
    await Clipboard.setData(ClipboardData(text: texto.toString()));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Contorno copiado al portapapeles')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa del campus'),
        actions: [
          if (kDebugMode)
            IconButton(
              tooltip: 'Calibrar contornos',
              icon: Icon(_calibrando ? Icons.edit_location_alt : Icons.edit_location_alt_outlined),
              onPressed: () => setState(() {
                _calibrando = !_calibrando;
                _puntos.clear();
              }),
            ),
        ],
      ),
      body: BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state is MapCargando) {
            return const LoadingIndicator(mensaje: 'Cargando campus...');
          }
          if (state is MapError) {
            return Center(child: Text(state.mensaje));
          }
          final s = state as MapCargado;

          return Column(
            children: [
              _buscador(s),
              if (_calibrando) _barraCalibracion(),
              Expanded(child: _mapa(s)),
              if (s.consulta.isNotEmpty) _resultados(s),
            ],
          );
        },
      ),
    );
  }

  Widget _buscador(MapCargado s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: TextField(
        controller: _busquedaCtrl,
        textInputAction: TextInputAction.search,
        onChanged: context.read<MapCubit>().buscar,
        decoration: InputDecoration(
          hintText: 'Buscar: baño, biblioteca, laboratorio...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: s.consulta.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _busquedaCtrl.clear();
                    context.read<MapCubit>().buscar('');
                  },
                ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          isDense: true,
        ),
      ),
    );
  }

  Widget _barraCalibracion() {
    return Container(
      color: Colors.red.withAlpha(30),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(child: Text('Calibrando: ${_puntos.length} puntos (toca las esquinas)')),
          IconButton(
            tooltip: 'Deshacer',
            icon: const Icon(Icons.undo),
            onPressed: _puntos.isEmpty ? null : () => setState(_puntos.removeLast),
          ),
          IconButton(
            tooltip: 'Copiar código',
            icon: const Icon(Icons.copy),
            onPressed: _puntos.isEmpty ? null : _copiarPuntos,
          ),
          IconButton(
            tooltip: 'Limpiar',
            icon: const Icon(Icons.delete_outline),
            onPressed: _puntos.isEmpty ? null : () => setState(_puntos.clear),
          ),
        ],
      ),
    );
  }

  Widget _mapa(MapCargado s) {
    final tam = _tamanoImagen;
    if (tam == null) {
      return const Center(
        child: Text('No se encontró assets/images/campus_croquis.png\n'
            '(revisa el pubspec.yaml)', textAlign: TextAlign.center),
      );
    }

    return InteractiveViewer(
      minScale: 1,
      maxScale: 6,
      child: Center(
        child: AspectRatio(
          aspectRatio: tam.width / tam.height,
          child: LayoutBuilder(
            builder: (context, c) {
              final size = Size(c.maxWidth, c.maxHeight);
              final painter = CampusMapPainter(
                edificios: s.edificios,
                resaltados: s.resaltados,
                seleccionadoId: s.seleccionadoId,
                puntosCalibracion: List.of(_puntos),
              );
              return GestureDetector(
                onTapUp: (d) => _alTocar(d.localPosition, size, painter, s),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(_rutaCroquis, fit: BoxFit.fill),
                    CustomPaint(painter: painter),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _resultados(MapCargado s) {
    if (s.resultados.isEmpty && s.resaltados.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Sin resultados'),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 170),
      child: ListView(
        shrinkWrap: true,
        children: [
          for (final e in s.resultados)
            ListTile(
              dense: true,
              leading: Icon(_icono(e.tipo)),
              title: Text(e.nombre),
              subtitle: Text(
                'Edificio ${_nombreEdificio(s, e.edificioId)} · Piso ${e.piso}',
              ),
              onTap: () {
                final ed = s.edificios.where((x) => x.id == e.edificioId);
                if (ed.isEmpty) return;
                context.read<MapCubit>().seleccionar(ed.first.id);
                _mostrarDetalle(
                  ed.first,
                  s.espacios.where((x) => x.edificioId == ed.first.id).toList(),
                );
              },
            ),
        ],
      ),
    );
  }

  String _nombreEdificio(MapCargado s, String id) {
    final r = s.edificios.where((e) => e.id == id);
    return r.isEmpty ? id : r.first.nombre;
  }
}
