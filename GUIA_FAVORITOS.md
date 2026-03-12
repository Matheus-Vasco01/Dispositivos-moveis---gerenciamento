# 📱 Sistema de Gerenciamento de Favoritos - Flutter

Um projeto educacional demonstrando três abordagens diferentes de gerenciamento de estado em Flutter: **Provider**, **Riverpod** e **BLoC**.

## 🎯 Objetivo

Implementar um sistema de controle de favoritos em uma lista de produtos, permitindo ao usuário:
- ✅ Visualizar uma lista de produtos
- ✅ Marcar/desmarcar produtos como favoritos
- ✅ Atualizar a interface automaticamente quando o estado muda

## 📂 Estrutura do Projeto

```
lib/
├── models/
│   └── product.dart                    # Modelo de produto
├── presentation/pages/
│   ├── home_page.dart                  # Menu principal
│   ├── provider_products_page.dart      # Implementação com Provider
│   ├── riverpod_products_page.dart      # Implementação com Riverpod
│   └── bloc_products_page.dart          # Implementação com BLoC
├── state/
│   ├── provider/
│   │   ├── counter_provider.dart        # Provider original (contador)
│   │   └── product_provider.dart        # Provider para produtos
│   ├── riverpod/
│   │   ├── counter_riverpod.dart        # Riverpod original
│   │   └── product_riverpod.dart        # Riverpod para produtos
│   └── bloc/
│       ├── counter_bloc.dart            # BLoC original
│       ├── product_bloc.dart            # BLoC para produtos
│       ├── product_event.dart           # Eventos de produtos
│       └── product_state.dart           # Estados de produtos
└── main.dart                           # Configuração da aplicação
```

## 🚀 Como Usar

### 1. **Instalar Dependências**
```bash
flutter pub get
```

### 2. **Executar a Aplicação**
```bash
flutter run
```

### 3. **Navegar Entre as Abordagens**

A tela inicial apresenta um menu com as opções:
- **Exemplos de Contador** (originais)
- **Sistema de Favoritos** (nova implementação)
  - Provider - Lista de Favoritos
  - Riverpod - Lista de Favoritos
  - BLoC - Lista de Favoritos

## 📦 Modelo de Dados

```dart
class Product {
  final String id;
  final String name;
  final double price;
  bool favorite;
}
```

## 🔄 Produtos Padrão

A aplicação começa com 4 produtos:
1. **Notebook** - R$ 3.500,00
2. **Mouse** - R$ 120,00
3. **Teclado** - R$ 250,00
4. **Monitor** - R$ 900,00

## 💡 Características de Cada Abordagem

### **Provider**
- ✅ Padrão `ChangeNotifier` com `notifyListeners()`
- ✅ Acesso via `context.watch<ProductProvider>()`
- ✅ Simples e fácil de aprender
- ⚠️ Menos reativo que Riverpod

### **Riverpod**
- ✅ Padrão `StateNotifier` (imutável)
- ✅ Melhor performance que Provider
- ✅ Acesso via `ref.watch(productProvider)`
- ✅ Sem dependência de contexto

### **BLoC**
- ✅ Padrão reativo com Eventos e Estados
- ✅ Separação clara entre UI e lógica
- ✅ Melhor para aplicações complexas
- ⚠️ Mais verboso que Provider/Riverpod

## 🎨 Interface

Cada um dos três exemplos apresenta:
- Lista de produtos com nome e preço
- Ícone de estrela (⭐ cheio / ☆ vazio)
- Clique para alterar status de favorito
- Atualização automática da interface

## 📝 Exemplo de Uso - Provider

```dart
class ProviderProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return ListView.builder(
      itemBuilder: (context, index) {
        final product = productProvider.products[index];
        return ListTile(
          title: Text(product.name),
          trailing: IconButton(
            icon: Icon(product.favorite ? Icons.star : Icons.star_border),
            onPressed: () => productProvider.toggleFavorite(product.id),
          ),
        );
      },
    );
  }
}
```

## 📝 Exemplo de Uso - Riverpod

```dart
class RiverpodProductPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);

    return ListView.builder(
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          trailing: IconButton(
            icon: Icon(product.favorite ? Icons.star : Icons.star_border),
            onPressed: () => 
              ref.read(productProvider.notifier).toggleFavorite(product.id),
          ),
        );
      },
    );
  }
}
```

## 📝 Exemplo de Uso - BLoC

```dart
class BlocProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProductsEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadedState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.name),
                  trailing: IconButton(
                    icon: Icon(product.favorite ? Icons.star : Icons.star_border),
                    onPressed: () => 
                      context.read<ProductBloc>()
                        .add(ToggleFavoriteEvent(product.id)),
                  ),
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
```

## 🔧 Funcionalidades Implementadas

### ProductProvider (Provider)
- `toggleFavorite(String productId)` - Alternar status de favorito
- `addProduct(Product product)` - Adicionar novo produto
- `removeProduct(String productId)` - Remover produto
- `get products` - Getter para lista de produtos

### ProductNotifier (Riverpod)
- `toggleFavorite(String productId)` - Alternar status de favorito
- `addProduct(Product product)` - Adicionar novo produto
- `removeProduct(String productId)` - Remover produto

### ProductBloc (BLoC)
- Eventos: `LoadProductsEvent`, `ToggleFavoriteEvent`, `AddProductEvent`, `RemoveProductEvent`
- Estados: `ProductInitialState`, `ProductLoadingState`, `ProductLoadedState`, `ProductErrorState`

## 🎓 Conceitos Aprendidos

1. **Reatividade**: Como o Flutter atualiza automaticamente a UI quando o estado muda
2. **Padrões de Projeto**: Provider, Riverpod e BLoC
3. **Separação de Responsabilidades**: Lógica vs Interface
4. **Imutabilidade**: Conceitos de estado imutável em Riverpod e BLoC
5. **Eventos**: Padrão de comunicação em BLoC

## 🐛 Troubleshooting

Se encontrar problemas ao executar:

1. **Limpar cache do Flutter**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Verificar erros de análise**
   ```bash
   flutter analyze
   ```

3. **Tentar executar novamente**
   ```bash
   flutter run
   ```

## 📚 Dependências

- `provider: ^6.1.2` - Gerenciamento de estado com Provider
- `flutter_riverpod: ^2.5.1` - Gerenciamento de estado com Riverpod
- `flutter_bloc: ^8.1.3` - Gerenciamento de estado com BLoC

## 💬 Dúvidas Frequentes

**P: Qual abordagem usar em meu projeto?**
R: Depende da complexidade. Use Provider para projetos simples, Riverpod para performance, e BLoC para aplicações complexas.

**P: Posso misturar as três abordagens?**
R: Sim, cada página usa uma abordagem diferente.

**P: Como adicionar novos produtos?**
R: Estenda a lista `_products` em cada implementação ou implemente um formulário de adição.

---

**Criado para fins educacionais** 📚
Demonstra conceitos fundamentais de gerenciamento de estado em Flutter.
