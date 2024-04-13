class Product {
  final String? id;
  final String name;
  final List<String> images;
  final String information;
  final double price;

  Product({
    this.id,
    required this.name,
    required this.images,
    required this.information,
    required this.price,
  });

  Product copyWith({
    String? id,
    String? name,
    List<String>? images,
    String? information,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name, 
      images: images ?? this.images, 
      information: information ?? this.information, 
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'information': information,
      'price': price,
      'images': images,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'], 
      images: json['images'], 
      information: json['information'], 
      price: json['price']
    );
  }
  
}