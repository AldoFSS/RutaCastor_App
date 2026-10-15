import 'package:flutter/material.dart';
import '../models/edificio_model.dart';
import '../services/edificio_service.dart';

class FormularioEdificioScreen extends StatefulWidget {
  final Edificio? edificio; // Si es nulo, crea un nuevo edificio. Si tiene valor, lo edita.

  const FormularioEdificioScreen({super.key, this.edificio});

  @override
  State<FormularioEdificioScreen> createState() =>
      _FormularioEdificioScreenState();
}

class _FormularioEdificioScreenState extends State<FormularioEdificioScreen> {
  final _formKey = GlobalKey<FormState>();
  final EdificioService _edificioService = EdificioService();

  late TextEditingController _codigoController;
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _tallerAsociadoController;
  late TextEditingController _carrerasController;

  String _tipoSeleccionado = 'Académico';
  final List<String> _tiposDisponibles = [
    'Académico',
    'Taller',
    'Administrativo',
    'Servicio',
  ];

  bool _cargando = false;

  @override
  void initState() {
    super.initState();
    // Si estamos editando, rellenamos los controladores con los datos actuales
    _codigoController =
        TextEditingController(text: widget.edificio?.codigo ?? '');
    _nombreController =
        TextEditingController(text: widget.edificio?.nombre ?? '');
    _descripcionController =
        TextEditingController(text: widget.edificio?.descripcion ?? '');
    _tallerAsociadoController =
        TextEditingController(text: widget.edificio?.tallerAsociado ?? '');
    _carrerasController = TextEditingController(
      text: widget.edificio?.carreras.join(', ') ?? '',
    );

    if (widget.edificio != null &&
        _tiposDisponibles.contains(widget.edificio!.tipo)) {
      _tipoSeleccionado = widget.edificio!.tipo;
    }
  }

  @override
  void dispose() {
    _codigoController.dispose();
    _nombreController.dispose();
    _descripcionController.dispose();
    _tallerAsociadoController.dispose();
    _carrerasController.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _cargando = true;
    });

    try {
      // Convertimos el texto de carreras separado por comas en una Lista de Strings
      List<String> listaCarreras = _carrerasController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final edificioGuardar = Edificio(
        id: widget.edificio?.id ?? _codigoController.text.trim(),
        codigo: _codigoController.text.trim().toUpperCase(),
        nombre: _nombreController.text.trim(),
        tipo: _tipoSeleccionado,
        descripcion: _descripcionController.text.trim(),
        tallerAsociado: _tallerAsociadoController.text.trim().toUpperCase(),
        carreras: listaCarreras,
      );

      if (widget.edificio == null) {
        // Crear nuevo en Firestore
        await _edificioService.agregarEdificio(edificioGuardar);
      } else {
        // Actualizar existente en Firestore
        await _edificioService.actualizarEdificio(edificioGuardar);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.edificio == null
                  ? 'Edificio registrado correctamente'
                  : 'Edificio actualizado correctamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar en Firestore: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _cargando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.edificio != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Edificio' : 'Nuevo Edificio'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _codigoController,
                      enabled: !esEdicion, // El código/ID no se edita si ya existe
                      decoration: const InputDecoration(
                        labelText: 'Código del Edificio (ej. D8, K8, BIBLIO2)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.qr_code),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa un código identificador';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo del Edificio',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.domain),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Ingresa el nombre del edificio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _tipoSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Tipo / Categoría de Espacio',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.category),
                      ),
                      items: _tiposDisponibles.map((tipo) {
                        return DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        );
                      }).toList(),
                      onChanged: (nuevoValor) {
                        if (nuevoValor != null) {
                          setState(() {
                            _tipoSeleccionado = nuevoValor;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descripcionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Descripción e Instalaciones',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tallerAsociadoController,
                      decoration: const InputDecoration(
                        labelText: 'Taller Vinculado (ej. K1, dejar vacío si no aplica)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.build),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _carrerasController,
                      decoration: const InputDecoration(
                        labelText: 'Carreras (separadas por coma ",")',
                        hintText: 'Ingeniería en Software, Redes',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.school),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _guardar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.save),
                        label: Text(
                          esEdicion ? 'Guardar Cambios' : 'Registrar Edificio',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}