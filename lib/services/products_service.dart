import 'dart:convert';

import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/services/firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService([AuthToken? authToken]) : super(authToken);

  Future<List<Product>> fetchProducts() async {
    final List<Product> products = [];

    try {
      // final filters = filteredByUser ? 'orderBy="'
      final productsMap = await httpFetch(
        '$databaseUrl/products.json?auth=$token'
      ) as Map<String, dynamic>?;

      productsMap?.forEach((productId, product) {
        List<String> images = (product['images'] as List<dynamic>).cast<String>();
        products.add(
          Product.fromJson({
            'id': productId,
            ...product,
            'images': images,
          })
        );
      });
      // print(AuthToken().);
      return products;
    } catch (e) {
      print(e);
      return products;
    }
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final newProduct = await httpFetch(
        '$databaseUrl/products.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(
          product.toJson()
        )
      );
      return product.copyWith(
        id: newProduct!['name'],
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await httpFetch(
        '$databaseUrl/products/${product.id}.json?auth=$token',
        method: HttpMethod.patch,
        body: jsonEncode(
          product.toJson()
        )
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await httpFetch(
        '$databaseUrl/products/${id}.json?auth=$token',
        method: HttpMethod.delete,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}