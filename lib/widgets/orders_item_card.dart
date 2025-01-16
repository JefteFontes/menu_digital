import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';

class OrdersItemCard extends StatelessWidget {
  const OrdersItemCard({
    super.key,
    required this.item,
    required this.quantity,
    required this.onIcrementQuantity,
    required this.onDecrementQuantity,
  });

  final MenuItem item;
  final int quantity;
  final VoidCallback onIcrementQuantity;
  final VoidCallback onDecrementQuantity;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        item.imageMenu, 
        width: 100, 
        height: 100, 
        fit: BoxFit.cover
      ),
      title: Text(item.title),
      subtitle: Text('Valor: R\$ ${item.price.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onDecrementQuantity,
          ),
          Text('$quantity'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onIcrementQuantity,
          ),
        ],
      )
    );
  }
}