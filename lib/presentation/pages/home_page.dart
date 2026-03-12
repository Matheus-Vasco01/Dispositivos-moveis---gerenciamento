import 'package:flutter/material.dart';
import 'provider_page.dart';
import 'riverpod_page.dart';
import 'bloc_page.dart';
import 'provider_api_products_page.dart';
import 'riverpod_api_products_page.dart';
import 'bloc_api_products_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("State Management Examples")),
      body: ListView(
        children: [
          // Original Counter Examples
          const ListTile(
            title: Text("?? Exemplos de Contador"),
          ),
          ListTile(
            title: const Text("Provider Counter"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProviderPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Riverpod Counter"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiverpodPage()),
              );
            },
          ),
          ListTile(
            title: const Text("BLoC Counter"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BlocPage()),
              );
            },
          ),
          const Divider(),
          // Product Favorites Examples
          const ListTile(
            title: Text("? Sistema de Favoritos"),
          ),
          ListTile(
            title: const Text("Provider"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProviderApiProductPage()),
              );
            },
          ),
          ListTile(
            title: const Text("Riverpod"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const RiverpodApiProductPage()),
              );
            },
          ),
          ListTile(
            title: const Text("BLoC"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const BlocApiProductPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
