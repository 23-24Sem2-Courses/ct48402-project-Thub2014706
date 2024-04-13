import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/services/products_service.dart';
import 'package:flutter/foundation.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [
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
  ];

  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
    : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts() async {
    _items = await _productsService.fetchProducts();
    notifyListeners();
  }

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

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }
}