import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CartBloc>()..add(const LoadCart()),
      child: Scaffold(
        appBar: AppBar(
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
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CartError) {
              return Center(child: Text(state.message));
            }

            if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text(
                    "Your cart is empty",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item = state.items[index];

                        return CartItemCard(
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
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, -2),
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "\$${state.totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Checkout coming soon!"),
                                  ),
                                );
                              },
                              child: const Text("Checkout"),
                            ),
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
      ),
    );
  }
}
