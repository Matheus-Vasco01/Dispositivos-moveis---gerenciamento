import '../../models/product.dart';

abstract class ProductApiState {}

class ProductApiInitialState extends ProductApiState {}

class ProductApiLoadingState extends ProductApiState {}

class ProductApiLoadedState extends ProductApiState {
  final List<Product> products;
  ProductApiLoadedState(this.products);
}

class ProductApiErrorState extends ProductApiState {
  final String message;
  ProductApiErrorState(this.message);
}
