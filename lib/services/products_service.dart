import 'dart:convert';

import 'package:ct484_project/models/auth_token.dart';
import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/services/firebase_service.dart';

class ProductsService extends FirebaseService {
  ProductsService([AuthToken? authToken]) : super(authToken);

  Future<List<Product>> fetchProducts({String? filterByType}) async {
    final List<Product> products = [];

    try {
      final filters = filterByType != null ? 'orderBy="type"&equalTo="$filterByType"' : '';
      final productsMap = await httpFetch(
        '$databaseUrl/products.json?auth=$token&$filters'
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
      print(products);
      return products;
    } catch (e) {
      print(e);
      return products;
    }
  }

  Future<bool?> isFavorite(String productId) async {
    try {
      final response = await httpFetch(
        '$databaseUrl/favorite/$userId/$productId.json?auth=$token',
        method: HttpMethod.get,
      );
      print(response);
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return null; 
    }
  }

  Future<List<Product>> allFavorite() async {
    final List<Product> products = [];
    
    try {
      final productsMap = await httpFetch(
        '$databaseUrl/products.json?auth=$token'
      ) as Map<String, dynamic>?;

      for (var entry in productsMap!.entries) {
        final productId = entry.key;
        final value = entry.value;
        bool? isFav = await isFavorite(productId);
        if (isFav == true) {
          List<String> images = (value['images'] as List<dynamic>).cast<String>();
          products.add(
            Product.fromJson({
              'id': productId,
              ...value,
              'images': images,
            })
          );
        }
      }
      // print(products);
      return products;
    } catch (e) {
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
      print(product.type);
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

  Future<bool?> addFavorite(String productId) async {
    try {
      await httpFetch(
        '$databaseUrl/favorite/$userId/$productId.json?auth=$token',
        method: HttpMethod.post,
        body: jsonEncode(true)
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool?> deleteFavorite(String productId) async {
    try {
      await httpFetch(
        '$databaseUrl/favorite/$userId/$productId.json?auth=$token',
        method: HttpMethod.delete,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

}