import 'package:flutter/material.dart';
import 'package:menu_digital/screens/orders_screen.dart';
import 'package:menu_digital/screens/principal_screen.dart';
import 'package:menu_digital/widgets/side_drawer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _pageSelectedIndex = 0;

  void _pageSelect(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageSelected = const PrincipalScreen();
    var pageSelectedTitle = 'Principal';
    
    if (_pageSelectedIndex == 1) {
      pageSelected = const OrdersScreen();
      pageSelectedTitle = 'Pedidos';
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFFF56606),
        ),
        title: Text(
          pageSelectedTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const SideDrawer(),
      body: pageSelected,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFF56606),
        onTap: _pageSelect,
        currentIndex: _pageSelectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Pedidos',
          ),
        ],
      ),
    );
  }
}