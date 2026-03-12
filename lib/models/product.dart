class Product {
  final String id;
  final String name;
  final double price;
  bool favorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.favorite = false,
  });

  // Método para copiar com mudanças
  Product copyWith({
    String? id,
    String? name,
    double? price,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      favorite: favorite ?? this.favorite,
    );
  }
}
