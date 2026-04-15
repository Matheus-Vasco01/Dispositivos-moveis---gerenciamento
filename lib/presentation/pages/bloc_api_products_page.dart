import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../../state/bloc/product_api_bloc.dart';
import '../../state/bloc/product_api_event.dart';
import '../../state/bloc/product_api_state.dart';
import 'product_detail_page.dart';

class BlocApiProductPage extends StatefulWidget {
  const BlocApiProductPage({super.key});

  @override
  State<BlocApiProductPage> createState() => _BlocApiProductPageState();
}

class _BlocApiProductPageState extends State<BlocApiProductPage> {
  List<String> categories = [];
  String selectedCategory = 'electronics';

  @override
  void initState() {
    super.initState();
    context
        .read<ProductApiBloc>()
        .add(LoadProductsApiByCategory('electronics'));
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      categories = [
        'electronics',
        'jewelery',
        'men\'s clothing',
        'women\'s clothing'
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("✰ BLoC")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCategory = value;
                  });
                  context
                      .read<ProductApiBloc>()
                      .add(LoadProductsApiByCategory(value));
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductApiBloc, ProductApiState>(
              builder: (context, state) {
                if (state is ProductApiLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductApiLoadedState) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(product: product),
                            ),
                          );
                        },
                        leading: product.imageUrl != null
                            ? Image.network(
                                product.imageUrl!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              )
                            : const Icon(Icons.image),
                        title: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle:
                            Text('R\$ ${product.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: Icon(
                            product.favorite ? Icons.star : Icons.star_border,
                            color:
                                product.favorite ? Colors.amber : Colors.grey,
                          ),
                          onPressed: () {
                            context
                                .read<ProductApiBloc>()
                                .add(ToggleFavoriteApiEvent(product.id));
                          },
                        ),
                      );
                    },
                  );
                } else if (state is ProductApiErrorState) {
                  return Center(child: Text('Erro: ${state.message}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
