import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/providers/order_provider.dart';
import 'package:menu_digital/widgets/orders_item_card.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  final Map<MenuItem, int> _orderQuantities = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final orders = ref.read(orderProvider);
      setState(() {
        for (var order in orders) {
          _orderQuantities[order] = 1;
        }
      });
    });
  }

  double _calculateTotalPrice() {
    return ref.read(orderProvider.notifier).calculateTotalPrice(_orderQuantities);
  }

  void _incrementQuantity(MenuItem item) {
    setState(() {
      _orderQuantities[item] = (_orderQuantities[item] ?? 1) + 1;
    });
  }

  void _decrementQuantity(MenuItem item) {
    setState(() {
      final currentQuantity = _orderQuantities[item] ?? 1;
      if (currentQuantity > 1) {
        _orderQuantities[item] = currentQuantity - 1;
      }
    });
  }

  void _sendOrder() async {
    final orders = ref.read(orderProvider);
    if (orders.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhum pedido realizado!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      await ref.read(orderProvider.notifier).sendOrder(_orderQuantities);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pedido enviado com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _orderQuantities.clear();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar pedido: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider); 

    return Column(
      children: [
        Expanded(
          child: orders.isEmpty
              ? const Center(child: Text('Nenhum pedido realizado.'))
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final item = orders[index];
                    final quantity = _orderQuantities[item] ?? 1;

                    return OrdersItemCard(
                      item: item,
                      quantity: quantity,
                      onIcrementQuantity: () => _incrementQuantity(item),
                      onDecrementQuantity: () => _decrementQuantity(item),
                    );
                  },
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
