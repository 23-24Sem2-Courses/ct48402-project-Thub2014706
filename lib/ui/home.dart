import 'package:ct484_project/ui/Shop/shop_screen.dart';
import 'package:ct484_project/ui/auth/account_screen.dart';
import 'package:ct484_project/ui/products/products_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
} 

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    ShopScreen(),
    ProductsScreen(),
    AccountScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 60,
        onDestinationSelected: _onItemTapped,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home), 
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_document), 
            label: 'Quản lý',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle), 
            label: 'Tài khoản',
          ),
        ],
      ),
    );
  }
}
