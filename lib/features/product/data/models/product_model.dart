class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String thumbnail;

  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
    };
  }

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? rating,
    String? thumbnail,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.price == price &&
        other.rating == rating &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        thumbnail.hashCode;
  }
}
