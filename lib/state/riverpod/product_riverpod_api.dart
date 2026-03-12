import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';

// Notifier para gerenciar a lista de produtos da API
class ProductApiNotifier extends StateNotifier<List<Product>> {
  ProductApiNotifier() : super([]);

  // Carregar produtos da API
  Future<void> loadProducts() async {
    try {
      state = await ProductService.fetchProducts();
    } catch (e) {
      state = [];
    }
  }

  // Carregar produtos por categoria
  Future<void> loadProductsByCategory(String category) async {
    try {
      state = await ProductService.fetchProductsByCategory(category);
    } catch (e) {
      state = [];
    }
  }

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

// Provider para produtos da API
final productApiProvider =
    StateNotifierProvider<ProductApiNotifier, List<Product>>((ref) {
  return ProductApiNotifier();
});
