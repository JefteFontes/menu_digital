import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/widgets/orders_item_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
    required this.orders,
    required this.onClearOrders,
  });

  final List<MenuItem> orders;
  final void Function() onClearOrders;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final Map<MenuItem, int> _orderQuantities = {};

  @override
  void initState() {
    super.initState(); 
    for (var order in widget.orders) {
      _orderQuantities[order] = 1;
    }
  }
  double _calculateTotalPrice() {
    return _orderQuantities.entries.map((entry) => entry.key.price * entry.value).fold(0.0, (prev, ammount) => prev + ammount);
  }
  void _incrementQuantity(int quantity, MenuItem menuItem) {
    setState(() {
      _orderQuantities[menuItem] = quantity + 1;
    });
  }
  void _decrementQuantity(int quantity, MenuItem menuItem) {
    if (quantity > 1) {
      setState(() {
        _orderQuantities[menuItem] = quantity - 1;
      });
    }
  }

  void _sendOrder() {
    if (widget.orders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum pedido realizado.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    widget.onClearOrders();
    _calculateTotalPrice();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pedido enviado com sucesso!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: widget.orders.isEmpty ? const Center(child: Text('Nenhum pedido realizado.')) : ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              MenuItem item = widget.orders[index];
              int quantity = _orderQuantities[widget.orders[index]] ?? 1;

              return OrdersItemCard(
                item: item, 
                quantity: quantity,
                onIcrementQuantity: () => _incrementQuantity(quantity, item),
                onDecrementQuantity: () => _decrementQuantity(quantity, item),
              );
            }
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: R\$ ${_calculateTotalPrice().toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                ),
                onPressed: _sendOrder,
                child: const Text('Enviar Pedido'),
              ),
            ],
          ),
        )
      ],
    );
  }
}