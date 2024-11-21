import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:transparent_image/transparent_image.dart';

class MenuItemDetails extends StatelessWidget {
  const MenuItemDetails({
    super.key,
    required this.item,
    required this.onRealizeOrder
  });

  final MenuItem item;
  final void Function(MenuItem order) onRealizeOrder;

  @override
  Widget build(BuildContext context) {
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
                onRealizeOrder(item);
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(200, 50)
              ),
              child: const Text('Realizar pedido', style: TextStyle(fontSize: 16)),
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