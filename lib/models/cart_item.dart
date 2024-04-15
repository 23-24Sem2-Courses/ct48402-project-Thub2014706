class CartItem {
  final String? id;
  final int quantity;
  final String name;
  final String image;
  final int price;

  CartItem({
    this.id,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    int? quantity,
    String? name,
    String? image,
    int? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity, 
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'name': name,
      'image': image,
      'price': price,
    };
  }

  static CartItem fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      name: json['name'], 
      price: json['price'],
      image: json['image'], 
    );
  }
}