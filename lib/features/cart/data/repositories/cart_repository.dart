import '../datasource/cart_local_datasource.dart';
import '../models/cart_item_model.dart';

class CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepository(this.localDataSource);

  Future<List<CartItemModel>> getCartItems() async {
    return await localDataSource.getCartItems();
  }

  Future<void> addToCart(CartItemModel item) async {
    final items = await localDataSource.getCartItems();

    final index = items.indexWhere((element) => element.id == item.id);

    if (index != -1) {
      final existing = items[index];

      items[index] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      items.add(item);
    }

    await localDataSource.saveCartItems(items);
  }

  Future<void> removeFromCart(int productId) async {
    final items = await localDataSource.getCartItems();

    items.removeWhere((item) => item.id == productId);

    await localDataSource.saveCartItems(items);
  }

  Future<void> increaseQuantity(int productId) async {
    final items = await localDataSource.getCartItems();

    final index = items.indexWhere((item) => item.id == productId);

    if (index != -1) {
      final item = items[index];

      items[index] = item.copyWith(quantity: item.quantity + 1);

      await localDataSource.saveCartItems(items);
    }
  }

  Future<void> decreaseQuantity(int productId) async {
    final items = await localDataSource.getCartItems();

    final index = items.indexWhere((item) => item.id == productId);

    if (index != -1) {
      final item = items[index];

      if (item.quantity > 1) {
        items[index] = item.copyWith(quantity: item.quantity - 1);
      } else {
        items.removeAt(index);
      }

      await localDataSource.saveCartItems(items);
    }
  }

  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }

  Future<double> getTotalPrice() async {
    final items = await localDataSource.getCartItems();

    double total = 0;

    for (final item in items) {
      total += item.price * item.quantity;
    }

    return total;
  }
}
