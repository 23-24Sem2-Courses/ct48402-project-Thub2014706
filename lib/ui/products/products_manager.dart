import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/services/products_service.dart';
import 'package:flutter/foundation.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
    : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts(String? type) async {
    print(type);
    _items = await _productsService.fetchProducts(filterByType: type);
    notifyListeners();
  }
  
  // Future<void> fetchProductsFilter(type) async {
  //   _items = await _productsService.fetchProducts(
  //     filterByType: type
  //   );
  //   notifyListeners();
  // }

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