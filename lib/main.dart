import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/pages/home_page.dart';
import 'state/provider/counter_provider.dart';
import 'state/provider/product_provider.dart';
import 'state/provider/product_api_provider.dart';
import 'state/riverpod/product_riverpod_api.dart';
import 'state/bloc/product_bloc.dart';
import 'state/bloc/product_api_bloc.dart';
import 'data/datasources/product_remote_data_source.dart';
import 'data/datasources/product_local_data_source.dart';
import 'data/repositories/product_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final httpClient = http.Client();

  final productRepository = ProductRepositoryImpl(
    remoteDataSource: ProductRemoteDataSourceImpl(client: httpClient),
    localDataSource:
        ProductLocalDataSourceImpl(sharedPreferences: sharedPreferences),
  );

  runApp(
    ProviderScope(
      overrides: [
        productRepositoryProvider.overrideWithValue(productRepository),
      ],
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider(
            create: (_) => CounterProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ProductProvider(),
          ),
          provider.ChangeNotifierProvider(
            create: (_) => ProductApiProvider(repository: productRepository),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ProductBloc()),
            BlocProvider(
                create: (_) => ProductApiBloc(repository: productRepository)),
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
