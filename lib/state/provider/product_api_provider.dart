import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductApiProvider extends ChangeNotifier {
  final ProductRepository repository;
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  ProductApiProvider({required this.repository});

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Carregar produtos da API
  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await repository.getProducts();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Carregar produtos por categoria
  Future<void> loadProductsByCategory(String category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await repository.getProductsByCategory(category);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Alternar status de favorito
  void toggleFavorite(String productId) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index].favorite = !_products[index].favorite;
      notifyListeners();
    }
  }

  // Adicionar produto
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  // Remover produto
  void removeProduct(String productId) {
    _products.removeWhere((p) => p.id == productId);
    notifyListeners();
  }
}
