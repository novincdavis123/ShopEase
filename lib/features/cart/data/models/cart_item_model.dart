import '../../../product/data/models/product_model.dart';

class CartItemModel {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;

  const CartItemModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  /// Create CartItem from Product
  factory CartItemModel.fromProduct(ProductModel product) {
    return CartItemModel(
      id: product.id,
      title: product.title,
      thumbnail: product.thumbnail,
      price: product.price,
      quantity: 1,
    );
  }

  CartItemModel copyWith({
    int? id,
    String? title,
    String? thumbnail,
    double? price,
    int? quantity,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnail: json['thumbnail'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CartItemModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            quantity == other.quantity;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode;
}
