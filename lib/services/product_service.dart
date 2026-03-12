import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  // Buscar produtos da API
  static Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((item) => Product(
                  id: item['id'].toString(),
                  name: item['title'] ?? 'Produto sem nome',
                  price: (item['price'] as num).toDouble(),
                  favorite: false,
                ))
            .toList();
      } else {
        throw Exception('Erro ao buscar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar categorias
  static Future<List<String>> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/products/categories'));

      if (response.statusCode == 200) {
        final List<dynamic> categories = jsonDecode(response.body);
        return categories.cast<String>();
      } else {
        throw Exception('Erro ao buscar categorias');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar produtos por categoria
  static Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/products/category/$category'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((item) => Product(
                  id: item['id'].toString(),
                  name: item['title'] ?? 'Produto sem nome',
                  price: (item['price'] as num).toDouble(),
                  favorite: false,
                ))
            .toList();
      } else {
        throw Exception('Erro ao buscar produtos por categoria');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
