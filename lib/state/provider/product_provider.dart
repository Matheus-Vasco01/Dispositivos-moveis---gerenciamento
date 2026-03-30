import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductProvider extends ChangeNotifier {
  // Lista inicial de produtos
  List<Product> _products = [
    Product(id: '1', name: 'Notebook', price: 3500.0),
    Product(id: '2', name: 'Mouse', price: 120.0),
    Product(id: '3', name: 'Teclado', price: 250.0),
    Product(id: '4', name: 'Monitor', price: 900.0),
  ];

  // Getter para produtos
  List<Product> get products => _products;

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
