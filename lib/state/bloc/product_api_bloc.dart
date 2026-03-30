import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import 'product_api_event.dart';
import 'product_api_state.dart';

class ProductApiBloc extends Bloc<ProductApiEvent, ProductApiState> {
  List<Product> _products = [];

  ProductApiBloc() : super(ProductApiInitialState()) {
    on<LoadProductsApiEvent>(_onLoadProducts);
    on<LoadProductsApiByCategory>(_onLoadProductsByCategory);
    on<ToggleFavoriteApiEvent>(_onToggleFavorite);
    on<AddProductApiEvent>(_onAddProduct);
    on<RemoveProductApiEvent>(_onRemoveProduct);
  }

  // Carregar produtos da API
  Future<void> _onLoadProducts(
    LoadProductsApiEvent event,
    Emitter<ProductApiState> emit,
  ) async {
    emit(ProductApiLoadingState());
    try {
      _products = await ProductService.fetchProducts();
      emit(ProductApiLoadedState(_products));
    } catch (e) {
      emit(ProductApiErrorState('Erro ao carregar produtos: $e'));
    }
  }

  // Carregar produtos por categoria
  Future<void> _onLoadProductsByCategory(
    LoadProductsApiByCategory event,
    Emitter<ProductApiState> emit,
  ) async {
    emit(ProductApiLoadingState());
    try {
      _products = await ProductService.fetchProductsByCategory(event.category);
      emit(ProductApiLoadedState(_products));
    } catch (e) {
      emit(ProductApiErrorState('Erro ao carregar produtos: $e'));
    }
  }

  // Alternar favorito
  Future<void> _onToggleFavorite(
    ToggleFavoriteApiEvent event,
    Emitter<ProductApiState> emit,
  ) async {
    final index = _products.indexWhere((p) => p.id == event.productId);
    if (index != -1) {
      _products[index].favorite = !_products[index].favorite;
      emit(ProductApiLoadedState(List.from(_products)));
    }
  }

  // Adicionar produto
  Future<void> _onAddProduct(
    AddProductApiEvent event,
    Emitter<ProductApiState> emit,
  ) async {
    _products.add(event.product);
    emit(ProductApiLoadedState(List.from(_products)));
  }

  // Remover produto
  Future<void> _onRemoveProduct(
    RemoveProductApiEvent event,
    Emitter<ProductApiState> emit,
  ) async {
    _products.removeWhere((p) => p.id == event.productId);
    emit(ProductApiLoadedState(List.from(_products)));
  }
}
