import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/services/cart_service.dart';
import 'package:flutter/foundation.dart';

class CartManager with ChangeNotifier {
  List<CartItem> _items = [];

  final CartService _cartService;

  CartManager([AuthToken? authToken])
    : _cartService = CartService(authToken);

  set authToken(AuthToken? authToken) {
    _cartService.authToken = authToken;
  }

  Future<void> fetchCart() async {
    _items = await _cartService.fetchCart();
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  List<CartItem> get items {
    return [..._items];
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((element) {
      total += element.price * element.quantity;
    });
    return total;
  }

  Future<void> addCart(CartItem cartItem) async {
    final newCart = await _cartService.addCart(cartItem);
    if (newCart != null) {
      _items.add(newCart);
      notifyListeners();
    }
  }

  Future<void> deleteCart(String id) async {
    final index = _items.indexWhere((element) => element.id == id);
    CartItem? existingCart = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _cartService.deleteCart(id)) {
      _items.insert(index, existingCart);
      notifyListeners();
    }
  }
}