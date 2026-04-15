import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

// Notifier para gerenciar a lista de produtos da API
class ProductApiNotifier extends StateNotifier<List<Product>> {
  final ProductRepository repository;
  ProductApiNotifier({required this.repository}) : super([]);

  // Carregar produtos da API
  Future<void> loadProducts() async {
    try {
      state = await repository.getProducts();
    } catch (e) {
      state = [];
    }
  }

  // Carregar produtos por categoria
  Future<void> loadProductsByCategory(String category) async {
    try {
      state = await repository.getProductsByCategory(category);
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

// Provider para o Repositório (precisa ser inicializado ou usar um placeholder)
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  throw UnimplementedError('Repositório não inicializado');
});

// Provider para produtos da API
final productApiProvider =
    StateNotifierProvider<ProductApiNotifier, List<Product>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductApiNotifier(repository: repository);
});
