import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/price_text.dart';
import '../../data/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: CachedNetworkImage(
                imageUrl: item.thumbnail,
                width: 90,
                height: 90,
                fit: BoxFit.cover,

                placeholder: (_, _) => Container(
                  width: 90,
                  height: 90,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),

                errorWidget: (_, _, _) => const SizedBox(
                  width: 90,
                  height: 90,
                  child: Center(
                    child: Icon(Icons.broken_image_outlined, size: 32),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  PriceText(price: item.price, fontSize: 16),

                  const SizedBox(height: 6),

                  Text(
                    "Quantity: ${item.quantity}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Text("Subtotal: ", style: TextStyle(fontSize: 13)),

                      PriceText(price: item.totalPrice, fontSize: 14),
                    ],
                  ),
                ],
              ),
            ),

            /// Actions
            Column(
              children: [
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                        onPressed: onDecrease,
                        icon: const Icon(Icons.remove, size: 18),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "${item.quantity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                        onPressed: onIncrease,
                        icon: const Icon(Icons.add, size: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
