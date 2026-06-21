import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_title.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded && state.items.isNotEmpty) {
                return IconButton(
                  onPressed: () {
                    context.read<CartBloc>().add(const ClearCart());
                  },
                  icon: const Icon(Icons.delete_outline),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const AppLoader();
          }

          if (state is CartError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context.read<CartBloc>().add(const LoadCart());
              },
            );
          }

          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return const EmptyState(
                icon: Icons.shopping_cart_outlined,
                title: "Your Cart is Empty",
                subtitle:
                    "Add some products to your cart and they will appear here.",
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const SectionTitle(title: "Cart Items"),

                      const SizedBox(height: 8),

                      ...state.items.map(
                        (item) => CartItemCard(
                          item: item,
                          onIncrease: () {
                            context.read<CartBloc>().add(
                              IncreaseQuantity(item.id),
                            );
                          },
                          onDecrease: () {
                            context.read<CartBloc>().add(
                              DecreaseQuantity(item.id),
                            );
                          },
                          onRemove: () {
                            context.read<CartBloc>().add(
                              RemoveFromCart(item.id),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, -2),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(title: "Order Summary"),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Text(
                              "Total Amount",
                              style: TextStyle(fontSize: 16),
                            ),

                            const Spacer(),

                            PriceText(price: state.totalPrice, fontSize: 26),
                          ],
                        ),

                        const SizedBox(height: 20),

                        PrimaryButton(
                          text: "Proceed to Checkout",
                          icon: Icons.payment_outlined,
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                  "Checkout functionality coming soon!",
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
