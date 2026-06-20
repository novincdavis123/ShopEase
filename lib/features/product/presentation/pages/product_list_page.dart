import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'ShopEase',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            }

            if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
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
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];

                    return ProductCard(
                      product: product,
                      onTap: () {
                        // Navigate to Product Detail Page
                      },
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
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
      ),
    );
  }
}
