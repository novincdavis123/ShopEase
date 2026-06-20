import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final String currency;

  const PriceText({
    super.key,
    required this.price,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.currency = '\$',
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currency${price.toStringAsFixed(2)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.green,
      ),
    );
  }
}
