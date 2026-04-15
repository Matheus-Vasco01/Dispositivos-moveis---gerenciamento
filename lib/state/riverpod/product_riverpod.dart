import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';

// Notifier para gerenciar a lista de produtos
class ProductNotifier extends StateNotifier<List<Product>> {
  ProductNotifier()
      : super([
          Product(id: '1', name: 'Notebook', price: 3500.0, imageUrl: ''),
          Product(id: '2', name: 'Mouse', price: 120.0, imageUrl: ''),
          Product(id: '3', name: 'Teclado', price: 250.0, imageUrl: ''),
          Product(id: '4', name: 'Monitor', price: 900.0, imageUrl: ''),
        ]);

  // Alternar status de favorito
  void toggleFavorite(String productId) {
    state = [
      for (final product in state)
        if (product.id == productId)
          product.copyWith(favorite: !product.favorite)
        else
          product
    ];
  }

  // Adicionar produto
  void addProduct(Product product) {
    state = [...state, product];
  }

  // Remover produto
  void removeProduct(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}

// Provider para produtos
final productProvider =
    StateNotifierProvider<ProductNotifier, List<Product>>((ref) {
  return ProductNotifier();
});
