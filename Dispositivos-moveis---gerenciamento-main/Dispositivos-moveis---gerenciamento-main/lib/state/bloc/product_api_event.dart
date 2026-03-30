import '../../models/product.dart';

abstract class ProductApiEvent {}

class LoadProductsApiEvent extends ProductApiEvent {}

class LoadProductsApiByCategory extends ProductApiEvent {
  final String category;
  LoadProductsApiByCategory(this.category);
}

class ToggleFavoriteApiEvent extends ProductApiEvent {
  final String productId;
  ToggleFavoriteApiEvent(this.productId);
}

class AddProductApiEvent extends ProductApiEvent {
  final Product product;
  AddProductApiEvent(this.product);
}

class RemoveProductApiEvent extends ProductApiEvent {
  final String productId;
  RemoveProductApiEvent(this.productId);
}
