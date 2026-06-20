import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/price_text.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/section_title.dart';

import '../../../cart/data/models/cart_item_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';

import '../../data/models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"), centerTitle: true),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: PrimaryButton(
          text: "Add to Cart",
          icon: Icons.shopping_cart_outlined,
          onPressed: () {
            context.read<CartBloc>().add(
              AddToCart(CartItemModel.fromProduct(product)),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${product.title} added to cart"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      const SizedBox(height: 320, child: AppLoader()),
                  errorWidget: (_, __, ___) => const SizedBox(
                    height: 320,
                    child: Center(
                      child: Icon(Icons.broken_image_outlined, size: 60),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              product.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Chip(label: Text(product.category)),

                const Spacer(),

                const Icon(Icons.star, color: Colors.amber),

                const SizedBox(width: 4),

                Text(
                  product.rating.toStringAsFixed(1),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),

            const SizedBox(height: 20),

            PriceText(price: product.price, fontSize: 30),

            const SizedBox(height: 28),

            const SectionTitle(title: "Description"),

            const SizedBox(height: 8),

            Text(
              product.description,
              style: const TextStyle(fontSize: 15, height: 1.7),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
