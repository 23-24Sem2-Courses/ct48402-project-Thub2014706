import 'package:ct484_project/models/product.dart';

class ProductsManager {
  final List<Product> _items = [
    Product(
      id: 'p1',
      name: 'Red Shirt',
      information: 'A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red!A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red! A red shirt - it is pretty red!',
      price: 29.99,
      images:
          ['https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg'],
    ),
    Product(
      id: 'p2',
      name: 'Trousers',
      information: 'A nice pair of trousers.',
      price: 59.99,
      images: ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
          ]
    ),
    Product(
      id: 'p3',
      name: 'Yellow Scarf',
      information: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      images:
          ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'],
    ),
    Product(
      id: 'p4',
      name: 'A Pan',
      information: 'Prepare any meal you want.',
      price: 49.99,
      images:
          ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg'],
    ),
    Product(
      id: 'p1',
      name: 'Red Shirt',
      information: 'A red shirt - it is pretty red!',
      price: 29.99,
      images:
          ['https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'],
    ),
    Product(
      id: 'p2',
      name: 'Trousers',
      information: 'A nice pair of trousers.',
      price: 59.99,
      images:
          ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg'],
    ),
    Product(
      id: 'p3',
      name: 'Yellow Scarf',
      information: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      images:
          ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'],
    ),
    Product(
      id: 'p4',
      name: 'A Pan',
      information: 'Prepare any meal you want.',
      price: 49.99,
      images:
          ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg'],
    ),
    Product(
      id: 'p1',
      name: 'Red Shirt',
      information: 'A red shirt - it is pretty red!',
      price: 29.99,
      images:
          ['https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'],
    ),
    Product(
      id: 'p2',
      name: 'Trousers',
      information: 'A nice pair of trousers.',
      price: 59.99,
      images:
          ['https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg'],
    ),
    Product(
      id: 'p3',
      name: 'Yellow Scarf',
      information: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      images:
          ['https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg'],
    ),
    Product(
      id: 'p4',
      name: 'A Pan',
      information: 'Prepare any meal you want.',
      price: 49.99,
      images:
          ['https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg'],
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }
}