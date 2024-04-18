import 'dart:math';

import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/auth/auth_screen.dart';
import 'package:ct484_project/ui/orders/orders_screen.dart';
import 'package:ct484_project/ui/products/favorite_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {

  const AccountScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
      builder: (context, authManager, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tài khoản', 
              style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),
            ),
          ),
          body: authManager.isAuth
          ? Auth()
          : Customer()
        );
      }
    );    
  }
}

class Customer extends StatelessWidget {
  const Customer({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return CardItem(
      onPressed: () {
        Navigator.of(context).pushNamed(
          AuthScreen.routeName,
        );
      },
      icon: const Icon(Icons.login),
      text: const Text('Đăng nhập'),
    );
  }
}

class Auth extends StatelessWidget {
  const Auth({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardItem(
          onPressed: () {
            Navigator.of(context).pushNamed(
              FavoriteListScreen.routeName,
            );
          },
          icon: const Icon(Icons.favorite),
          text: const Text('Danh sách yêu thích'),
        ),
        CardItem(
          onPressed: () {
            Navigator.of(context).pushNamed(
              OrdersScreen.routeName,
            );
          },
          icon: const Icon(Icons.article_outlined),
          text: const Text('Đơn hàng của bạn'),
        ),
        CardItem(
          onPressed: () {
            context.read<AuthManager>().logout();
          },
          icon: const Icon(Icons.logout),
          text: const Text('Đăng xuất'),
        )
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {
        this.onPressed,
      this.icon,
      this.text,
        super.key,
      }
  );

  final void Function()? onPressed;
  final Icon? icon;
  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ?? const Icon(Icons.error),
              text ?? const Text('Error'),
            ],
          ),
        ),
      ),
    );    
  }
}