import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:menu_digital/providers/order_provider.dart';

class MenuItemDetails extends ConsumerWidget {
  const MenuItemDetails({ 
    super.key,
    required this.item,
  });

  final MenuItem item;

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderProvider); 

    Widget content = Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber
                ),
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: Image.asset(item.imageMenu).image,
                  fit: BoxFit.contain,
                  height: 300,
                  width: double.infinity
                )
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(item.description, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    const Text('Ingredientes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    for (final ingredient in item.ingredients)
                      Text(ingredient, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ]
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                ref.read(orderProvider.notifier).addOrder(item);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(!state.contains(item) ? '${item.title} adicionado ao pedido!' : '${item.title} removido do pedido!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(200, 50)
              ),
              child: Text(!state.contains(item) ? 'Realizar pedido' : 'Desfazer pedido', style: TextStyle(fontSize: 16)),
            ),
          ),
        )
      ]
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: content
    );
  }
}