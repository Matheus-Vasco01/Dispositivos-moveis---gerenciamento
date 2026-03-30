class Product {
  final String id;
  final String name;
  final double price;
  final String? description;
  final String? imageUrl;
  bool favorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.imageUrl,
    this.favorite = false,
  });

  // Método para copiar com mudanças
  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      favorite: favorite ?? this.favorite,
    );
  }
}
