import 'dart:convert';

import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/models/order_item.dart';
import 'package:ct484_project/services/firebase_service.dart';

class OrderService extends FirebaseService {
  OrderService([AuthToken? authToken]) : super(authToken);

  Future<List<OrderItem>> fetchOrder() async {
    final List<OrderItem> order = [];

    try {
      final orderMap = await httpFetch(
        '$databaseUrl/orders/$userId.json?auth=$token',
      ) as Map<String, dynamic>?;

      orderMap!.forEach((orderId, orderItem) {
        List<CartItem> products = (orderItem['products'] as List<dynamic>).map((item) => CartItem.fromJson(item)).toList();
        order.add(
          OrderItem.fromJson({
            'id': orderId,
            ...orderItem,
            'dateTime': DateTime.parse(orderItem['dateTime']),
            'products': products
          })
        );
      });
      order.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      
      return order;
    } catch (e) {
      print(e);
      return order;
    }
  }

  Future<OrderItem?> addOrder(List<CartItem> products, int amount) async {
    try {
      final newOrder = await httpFetch(
        '$databaseUrl/orders/$userId.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode({
          'amount': amount,
          'products': products,
          'dateTime': DateTime.now().toIso8601String(),
        })
      ) as Map<String, dynamic>?;

      if (newOrder != null) {
          return OrderItem(
            amount: amount,
            products: products,
            dateTime: DateTime.now(),
          );
        } else {
          return null;
        }
    } catch (e) {
      print(e);
      return null;
    }
  }

}