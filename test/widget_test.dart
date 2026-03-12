import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_state_patterns/main.dart';
import 'package:flutter_state_patterns/state/provider/product_provider.dart';

void main() {
  testWidgets('Home page displays menu items', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the home page displays the menu titles
    expect(find.text('State Management Examples'), findsOneWidget);
    expect(find.text('📊 Exemplos de Contador'), findsOneWidget);
    expect(find.text('⭐ Sistema de Favoritos'), findsOneWidget);
    expect(find.text('Provider - Lista de Favoritos'), findsOneWidget);
    expect(find.text('Riverpod - Lista de Favoritos'), findsOneWidget);
    expect(find.text('BLoC - Lista de Favoritos'), findsOneWidget);
  });

  testWidgets('Provider favorites functionality', (WidgetTester tester) async {
    // Build the app with Provider
    await tester.pumpWidget(
      ProviderScope(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ProductProvider()),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  return ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return ListTile(
                        title: Text(product.name),
                        trailing: IconButton(
                          icon: Icon(product.favorite
                              ? Icons.star
                              : Icons.star_border),
                          onPressed: () => provider.toggleFavorite(product.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Verify that products are displayed
    expect(find.text('Notebook'), findsOneWidget);
    expect(find.text('Mouse'), findsOneWidget);
    expect(find.text('Teclado'), findsOneWidget);
    expect(find.text('Monitor'), findsOneWidget);

    // Verify that all products start as not favorited (star_border icons)
    expect(find.byIcon(Icons.star_border), findsWidgets);
    expect(find.byIcon(Icons.star), findsNothing);

    // Tap the favorite button for the first product (Notebook)
    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pumpAndSettle();

    // Verify that the first product is now favorited
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsWidgets);

    // Tap again to unfavorite
    await tester.tap(find.byIcon(Icons.star).first);
    await tester.pumpAndSettle();

    // Verify that all products are back to not favorited
    expect(find.byIcon(Icons.star_border), findsWidgets);
    expect(find.byIcon(Icons.star), findsNothing);
  });
}
