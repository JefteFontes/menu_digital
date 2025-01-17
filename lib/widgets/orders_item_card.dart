import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/providers/order_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class OrdersItemCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
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
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => ref.read(orderProvider.notifier).addOrder(item),
            tooltip: 'Remover item',
          ),
        ],
      )
    );
  }
}