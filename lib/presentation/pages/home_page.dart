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
      appBar: AppBar(title: const Text("Loja de Produtos")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                "Bem-vindo à nossa Loja!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Explore nossa variedade de produtos consumindo uma Fake API.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ProviderApiProductPage()),
                  );
                },
                icon: const Icon(Icons.list),
                label: const Text("Ver Catálogo de Produtos"),
              ),
              const SizedBox(height: 40),
              const Divider(),
              const Text("Outras Implementações (State Management):"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RiverpodApiProductPage()),
                      );
                    },
                    child: const Text("Riverpod"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const BlocApiProductPage()),
                      );
                    },
                    child: const Text("BLoC"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
