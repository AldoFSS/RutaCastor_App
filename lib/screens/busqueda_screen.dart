import 'package:flutter/material.dart';
import '../models/categoria.dart';
import '../services/categoria_service.dart';

class BusquedaScreen extends StatefulWidget {
  const BusquedaScreen({Key? key}) : super(key: key);

  @override
  _BusquedaScreenState createState() => _BusquedaScreenState();
}

class _BusquedaScreenState extends State<BusquedaScreen> {
  final CategoriaService _categoriaService = CategoriaService();
  
  List<Categoria> _categorias = [];
  bool _isLoadingCategorias = true;
  
  String? _categoriaSeleccionadaId;
  String _filtroTexto = '';
  final TextEditingController _searchController = TextEditingController();

  // Lugares de prueba del campus (puedes enlazarlos a tu backend de edificios después)
  final List<Map<String, dynamic>> _todosLosLugares = [
    {'nombre': 'Edificio A - Rectoría', 'categoriaId': 'cat-administrativo', 'descripcion': 'Dirección general y control escolar'},
    {'nombre': 'Edificio B - Aulas', 'categoriaId': 'cat-aula', 'descripcion': 'Salones de clase generales'},
    {'nombre': 'Laboratorio de Cómputo 1', 'categoriaId': 'cat-laboratorio', 'descripcion': 'Equipos con software de desarrollo'},
    {'nombre': 'Biblioteca Central', 'categoriaId': 'cat-biblioteca', 'descripcion': 'Área de estudio y préstamo de libros'},
    {'nombre': 'Cafetería Principal', 'categoriaId': 'cat-cafeteria', 'descripcion': 'Comida y zona de descanso'},
  ];

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  Future<void> _cargarCategorias() async {
    try {
      final categorias = await _categoriaService.getCategorias();
      setState(() {
        _categorias = categorias;
        _isLoadingCategorias = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCategorias = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lugaresFiltrados = _todosLosLugares.where((lugar) {
      final coincideTexto = lugar['nombre'].toLowerCase().contains(_filtroTexto.toLowerCase()) ||
                            lugar['descripcion'].toLowerCase().contains(_filtroTexto.toLowerCase());
      
      final coincideCategoria = _categoriaSeleccionadaId == null || 
                                lugar['categoriaId'] == _categoriaSeleccionadaId;

      return coincideTexto && coincideCategoria;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Búsqueda y Filtros'),
      ),
      body: Column(
        children: [
          // 1. Buscador
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (valor) {
                setState(() {
                  _filtroTexto = valor;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar edificio, aula o laboratorio...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _filtroTexto.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _filtroTexto = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),

          // 2. Filtros de Categorías (Chips horizontales)
          SizedBox(
            height: 50,
            child: _isLoadingCategorias
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: const Text('Todas'),
                          selected: _categoriaSeleccionadaId == null,
                          onSelected: (selected) {
                            setState(() {
                              _categoriaSeleccionadaId = null;
                            });
                          },
                        ),
                      ),
                      ..._categorias.map((categoria) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ChoiceChip(
                            label: Text(categoria.nombre),
                            selected: _categoriaSeleccionadaId == categoria.id,
                            onSelected: (selected) {
                              setState(() {
                                _categoriaSeleccionadaId = selected ? categoria.id : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
          ),
          const Divider(height: 20),

          // 3. Resultados de la búsqueda
          Expanded(
            child: lugaresFiltrados.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 8),
                        Text('No se encontraron resultados', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: lugaresFiltrados.length,
                    itemBuilder: (context, index) {
                      final lugar = lugaresFiltrados[index];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.place),
                        ),
                        title: Text(lugar['nombre'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(lugar['descripcion']),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}