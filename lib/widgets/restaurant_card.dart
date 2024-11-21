import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:transparent_image/transparent_image.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onSelectedCardapio
  });
  final Restaurant restaurant;
  final VoidCallback? onSelectedCardapio;

  String formatMenuItems(List<MenuItem> menuItems) {
    StringBuffer formattedItems = StringBuffer();
    for (var item in menuItems) {
      formattedItems.writeln('${item.title} - R\$ ${item.price.toStringAsFixed(2)}');
    }
    return formattedItems.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), 
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onSelectedCardapio,
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: Image.asset(restaurant.imageLogo).image,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity
            ),
            ListTile(
              title: Text(
                restaurant.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: formatMenuItems(restaurant.menuItems).isNotEmpty ? Text(formatMenuItems(restaurant.menuItems)) : null
            ),
          ]
        ),
      ),
    );
  }
}