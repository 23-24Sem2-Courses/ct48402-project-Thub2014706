import 'package:ct484_project/models/product.dart';

class CartItem {
  final String id;
  final int quantity;
  final int totalPrice;
  final Product product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.totalPrice,
    required this.product,
  });

  CartItem copyWith({
    String? id,
    int? quantity,
    int? totalPrice,
    Product? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity, 
      totalPrice: totalPrice ?? this.totalPrice,
      product: product ?? this.product,
    );
  }
}