import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shopease/core/constants/app_constants.dart';
import '../models/cart_item_model.dart';

class CartLocalDataSource {
  /// Opens the Hive box for cart items.
  /// If the box is already open,
  /// it returns the existing instance;
  /// otherwise, it opens a new box.
  Future<Box> _openBox() async {
    if (Hive.isBoxOpen(AppConstants.cartBoxName)) {
      return Hive.box(AppConstants.cartBoxName);
    }

    return await Hive.openBox(AppConstants.cartBoxName);
  }

  /// Get all cart items
  Future<List<CartItemModel>> getCartItems() async {
    final box = await _openBox();

    final List<dynamic> data = box.get(AppConstants.cartKey, defaultValue: []);

    return data
        .map((item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  /// Save cart items
  Future<void> saveCartItems(List<CartItemModel> items) async {
    final box = await _openBox();

    final data = items.map((item) => item.toJson()).toList();

    await box.put(AppConstants.cartKey, data);
  }

  /// Clear cart
  Future<void> clearCart() async {
    final box = await _openBox();

    await box.delete(AppConstants.cartKey);
  }
}
