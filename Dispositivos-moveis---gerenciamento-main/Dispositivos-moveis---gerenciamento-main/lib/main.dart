import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/home_page.dart';
import 'state/provider/counter_provider.dart';
import 'state/provider/product_provider.dart';
import 'state/provider/product_api_provider.dart';
import 'state/bloc/product_bloc.dart';
import 'state/bloc/product_api_bloc.dart';

void main() {
  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => CounterProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ProductProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ProductApiProvider(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductBloc()),
            BlocProvider(create: (_) => ProductApiBloc()),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management Patterns',
      home: const HomePage(),
    );
  }
}
