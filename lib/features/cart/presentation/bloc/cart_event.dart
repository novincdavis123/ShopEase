import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

/// Load all cart items
class LoadCart extends CartEvent {
  const LoadCart();
}

/// Add a product to cart
class AddToCart extends CartEvent {
  final CartItemModel item;

  const AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}

/// Remove a product completely
class RemoveFromCart extends CartEvent {
  final int productId;

  const RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

/// Increase quantity
class IncreaseQuantity extends CartEvent {
  final int productId;

  const IncreaseQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

/// Decrease quantity
class DecreaseQuantity extends CartEvent {
  final int productId;

  const DecreaseQuantity(this.productId);

  @override
  List<Object?> get props => [productId];
}

/// Clear the entire cart
class ClearCart extends CartEvent {
  const ClearCart();
}
