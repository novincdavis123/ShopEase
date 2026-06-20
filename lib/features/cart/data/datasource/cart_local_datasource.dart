import 'package:hive_ce_flutter/hive_flutter.dart';
import '../models/cart_item_model.dart';

class CartLocalDataSource {
  static const String boxName = 'cart_box';
  static const String cartKey = 'cart_items';

  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box(boxName);
    }

    return await Hive.openBox(boxName);
  }

  /// Get all cart items
  Future<List<CartItemModel>> getCartItems() async {
    final box = await _openBox();

    final List<dynamic> data = box.get(cartKey, defaultValue: []);

    return data
        .map((item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// Save cart items
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final box = await _openBox();

    final data = items.map((item) => item.toJson()).toList();

    await box.put(cartKey, data);
  }

  /// Clear cart
  Future<void> clearCart() async {
    final box = await _openBox();

    await box.delete(cartKey);
  }
}
