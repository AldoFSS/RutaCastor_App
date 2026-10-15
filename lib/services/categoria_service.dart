import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/categoria.dart';

class CategoriaService {
  // URL base de tu backend (ajusta el puerto o la ruta si es necesario)
  final String baseUrl = 'http://10.0.2.2:3000/api/categorias';

  Future<List<Categoria>> getCategorias() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body);
        return List<Categoria>.from(data.map((model) => Categoria.fromJson(model)));
      } else {
        throw Exception('Error al cargar las categorías');
      }
    } catch (e) {
      print('Error en CategoriaService: $e');
      return [];
    }
  }
}