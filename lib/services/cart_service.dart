import 'dart:convert';

import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/services/firebase_service.dart';

class CartService extends FirebaseService {
  CartService([AuthToken? authToken]) : super(authToken);

  Future<List<CartItem>> fetchCart() async {
    final List<CartItem> cart = [];

    try {
      final cartMap = await httpFetch(
        '$databaseUrl/cart/$userId.json?auth=$token',
      ) as Map<String, dynamic>?;

      cartMap!.forEach((cartId, cartData) {
        cart.add(
          CartItem.fromJson({
            'id': cartId,
            ...cartData
          })
        );
      });
      return cart;
    } catch (e) {
      print(cart);
      print(e);
      return cart;
    }
  }

  Future<CartItem?> addCart(CartItem cartItem) async {
    try {
      final newCart = await httpFetch(
        '$databaseUrl/cart/$userId.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          cartItem.toJson()
        )
      );

      return cartItem.copyWith(
        id: newCart!['name'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

    Future<bool> deleteCart(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/cart/$userId/${id}.json?auth=$token',
        method: HttpMethod.delete,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}