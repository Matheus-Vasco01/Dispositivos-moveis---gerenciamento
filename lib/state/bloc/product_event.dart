import '../../models/product.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class ToggleFavoriteEvent extends ProductEvent {
  final String productId;
  ToggleFavoriteEvent(this.productId);
}

class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent(this.product);
}

class RemoveProductEvent extends ProductEvent {
  final String productId;
  RemoveProductEvent(this.productId);
}
