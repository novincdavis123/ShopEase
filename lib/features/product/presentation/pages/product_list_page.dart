import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import 'package:shopease/features/cart/presentation/pages/cart_page.dart';
import 'package:shopease/features/theme/presentation/widgets/theme_toggle_button.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'ShopEase',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          const ThemeToggleButton(),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const AppLoader();
          }

          if (state is ProductError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<ProductBloc>().add(const FetchProducts());
              },
            );
          }

          if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const EmptyState(
                icon: Icons.shopping_bag_outlined,
                title: 'No Products Found',
                subtitle: 'Pull down to refresh or check back again later.',
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductBloc>().add(const FetchProducts());
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
