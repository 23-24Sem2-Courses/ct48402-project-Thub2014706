import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/models/product.dart';

class CartManager {
  final List<CartItem> _items = [
    CartItem(
      id: 'c1',
      quantity: 1,
      totalPrice: 1390000,
      product: Product(id: 'p1',
      name: 'Calm',
      information: 'Đồng hồ nam Curnon Kashmir Calm mang phong cách trẻ trung, hiện đại, tối giản, phù hợp với nhiều trang phục; Dây kim loại thép, Mặt kính Sapphire chống trầy xước, Chống nước 3ATM',
      price: 1390000,
      type: 'Moraine',
      images: ['https://curnonwatch.com/wp-content/uploads/2024/02/BT.Calm-11242.png',
          'https://curnonwatch.com/wp-content/uploads/2024/02/Curnonlst18273-copy-e1708576927927.jpg',
          'https://curnonwatch.com/wp-content/uploads/2024/02/Curnonlst18216-copy-e1708576889891.jpg',
          'https://curnonwatch.com/wp-content/uploads/2024/02/Calm.246445343.png',
          ])
    ),
    // CartItem(
    //   id: 'c1',
    //   quantity: 2,
    //   totalPrice: 29.99,
    //   product: Product(id: 'p2',
    //   name: 'Trousers',
    //   information: 'A nice pair of trousers.',
    //   price: 59.99,
    //   images: ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //       ])
    // ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<CartItem> get items {
    return [..._items];
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((element) {
      total += element.product.price * element.quantity;
    });
    return total;
  }

  // List<Product> get 
}