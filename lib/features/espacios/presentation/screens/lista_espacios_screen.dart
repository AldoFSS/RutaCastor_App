import 'package:flutter/material.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/espacio_model.dart';
import '../../data/services/espacio_service.dart';
import '../espacio_labels.dart';
import 'detalle_espacio_screen.dart';

class ListaEspaciosScreen extends StatefulWidget {
  const ListaEspaciosScreen({super.key});

  @override
  State<ListaEspaciosScreen> createState() => _ListaEspaciosScreenState();
}

class _ListaEspaciosScreenState extends State<ListaEspaciosScreen> {
  static const _categorias = <String?, String>{
    null: 'Todos',
    'cat-aula': 'Aulas',
    'cat-laboratorio': 'Laboratorios',
  };

  final _busquedaController = TextEditingController();
  late final EspacioService _servicio;
  late Stream<List<EspacioModel>> _espaciosStream;
  String? _categoriaSeleccionada;
  String? _edificioSeleccionado;
  String _textoBusqueda = '';

  @override
  void initState() {
    super.initState();
    _servicio = sl<EspacioService>();
    _actualizarStream();
  }

  @override
  void dispose() {
    _busquedaController.dispose();
    super.dispose();
  }

  void _actualizarStream() {
    _espaciosStream = _servicio.obtenerEspaciosFiltrados(
      edificioId: _edificioSeleccionado,
      categoriaId: _categoriaSeleccionada,
    );
  }

  void _seleccionarCategoria(String? categoriaId) {
    setState(() {
      _categoriaSeleccionada = categoriaId;
      _actualizarStream();
    });
  }

  void _seleccionarEdificio(String? edificioId) {
    setState(() {
      _edificioSeleccionado = edificioId;
      _actualizarStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Espacios del campus')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _busquedaController,
              onChanged: (texto) => setState(() => _textoBusqueda = texto),
              decoration: InputDecoration(
                labelText: 'Buscar espacio',
                hintText: 'Ej. Laboratorio de Sistemas',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _textoBusqueda.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Limpiar búsqueda',
                        onPressed: () {
                          _busquedaController.clear();
                          setState(() => _textoBusqueda = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: _categorias.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(entry.value),
                    selected: _categoriaSeleccionada == entry.key,
                    onSelected: (_) => _seleccionarCategoria(entry.key),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: DropdownButtonFormField<String?>(
              initialValue: _edificioSeleccionado,
              decoration: const InputDecoration(
                labelText: 'Edificio',
                prefixIcon: Icon(Icons.apartment_outlined),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todos los edificios'),
                ),
                ...EspacioLabels.edificios.entries.map(
                  (edificio) => DropdownMenuItem<String?>(
                    value: edificio.key,
                    child: Text(edificio.value),
                  ),
                ),
              ],
              onChanged: _seleccionarEdificio,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<EspacioModel>>(
              stream: _espaciosStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text('No se pudieron cargar los espacios: '
                          '${snapshot.error}'),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final consulta = _textoBusqueda.trim().toLowerCase();
                final espacios = (snapshot.data ?? const <EspacioModel>[])
                    .where(
                      (espacio) =>
                          espacio.nombre.toLowerCase().contains(consulta),
                    )
                    .toList();
                if (espacios.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron espacios con esos filtros.'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: espacios.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) =>
                      _tarjetaEspacio(context, espacios[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaEspacio(BuildContext context, EspacioModel espacio) {
    final imagenUrl = espacio.imagenUrl?.trim();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: SizedBox(
          width: 56,
          height: 56,
          child: imagenUrl == null || imagenUrl.isEmpty
              ? const _MiniaturaEspacioPlaceholder()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imagenUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const _MiniaturaEspacioPlaceholder(),
                  ),
                ),
        ),
        title: Text(
          espacio.nombre,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${EspacioLabels.categoria(espacio.categoriaId)} · '
            '${EspacioLabels.edificio(espacio.edificioId)}',
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => DetalleEspacioScreen(espacio: espacio),
            ),
          );
        },
      ),
    );
  }
}

class _MiniaturaEspacioPlaceholder extends StatelessWidget {
  const _MiniaturaEspacioPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.meeting_room_outlined, color: AppColors.primary),
    );
  }
}
