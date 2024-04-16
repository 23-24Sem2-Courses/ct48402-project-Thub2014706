import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/models/order_item.dart';
import 'package:ct484_project/services/order_service.dart';
import 'package:flutter/foundation.dart';

class OrdersManager with ChangeNotifier {
  List<OrderItem> _orders = [];

  final OrderService _orderService;

  OrdersManager([AuthToken? authToken]) 
    : _orderService = OrderService(authToken);

  set authToken(AuthToken? authToken) {
    _orderService.authToken = authToken;
  }

  Future<void> fetchOrder() async {
    _orders = await _orderService.fetchOrder();
    notifyListeners();
  }

  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, int amount) async {
    await _orderService.addOrder(cartProducts, amount);
    notifyListeners();
  }
}