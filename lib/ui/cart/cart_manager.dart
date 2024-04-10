import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/models/product.dart';

class CartManager {
  final List<CartItem> _items = [
    CartItem(
      id: 'c1',
      quantity: 2,
      totalPrice: 29.99,
      product: Product(id: 'p2',
      name: 'Trousers',
      information: 'A nice pair of trousers.',
      price: 59.99,
      images: ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ])
    ),
    CartItem(
      id: 'c1',
      quantity: 2,
      totalPrice: 29.99,
      product: Product(id: 'p2',
      name: 'Trousers',
      information: 'A nice pair of trousers.',
      price: 59.99,
      images: ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ])
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<CartItem> get items {
    return [..._items];
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((element) {
      total += element.product.price * element.quantity;
    });
    return total;
  }

  // List<Product> get 
}