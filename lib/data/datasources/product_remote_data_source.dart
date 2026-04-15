import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://fakestoreapi.com';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar produtos: ${response.statusCode}');
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final response =
        await client.get(Uri.parse('$_baseUrl/products/category/$category'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Erro ao buscar produtos por categoria');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final response =
        await client.get(Uri.parse('$_baseUrl/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body);
      return categories.cast<String>();
    } else {
      throw Exception('Erro ao buscar categorias');
    }
  }
}
