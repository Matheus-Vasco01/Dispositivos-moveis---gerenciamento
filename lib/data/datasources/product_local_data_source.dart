import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getLastProducts();
  Future<void> cacheProducts(List<Product> productsToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String _cachedProductsKey = 'CACHED_PRODUCTS';

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<Product>> getLastProducts() async {
    final jsonString = sharedPreferences.getString(_cachedProductsKey);
    if (jsonString != null) {
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Nenhum dado em cache');
    }
  }

  @override
  Future<void> cacheProducts(List<Product> productsToCache) {
    final List<Map<String, dynamic>> jsonList =
        productsToCache.map((p) => p.toJson()).toList();
    return sharedPreferences.setString(
      _cachedProductsKey,
      jsonEncode(jsonList),
    );
  }
}
