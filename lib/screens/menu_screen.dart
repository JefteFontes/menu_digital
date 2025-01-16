import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/screens/orders_screen.dart';
import 'package:menu_digital/screens/principal_screen.dart';
import 'package:menu_digital/widgets/side_drawer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    super.key,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _pageSelectedIndex = 0;
  final List<MenuItem> _ordersMenuItems = [];

  void _showMensage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message)
        ),
    );
  }

  void _realizeOrder(MenuItem order) {
    final existingOrder = _ordersMenuItems.contains(order);
    if(existingOrder) {
      setState(() {
        _ordersMenuItems.remove(order);
      });
      _showMensage('Pedido removido com sucesso!');
    } else {
      setState(() {
        _ordersMenuItems.add(order);
      });
      _showMensage('Pedido realizado com sucesso!');
    }
  }

  void _clearOrders() {
    setState(() {
      _ordersMenuItems.clear();
    });
  }

  void _pageSelect(int index) {
    setState(() {
      _pageSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget pageSelected = PrincipalScreen(
      onRealizeOrder: _realizeOrder,
    );
    var pageSelectedTitle = 'Principal';
    
    if (_pageSelectedIndex == 1) {
      pageSelected = OrdersScreen(
        orders: _ordersMenuItems,
        onClearOrders: _clearOrders,
      );
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