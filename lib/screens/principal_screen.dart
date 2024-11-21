import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/screens/cardapio_screen.dart';
import 'package:menu_digital/widgets/restaurant_card.dart';


class PrincipalScreen extends StatelessWidget {
  const PrincipalScreen({
    super.key,
    required this.onRealizeOrder
  });

  final void Function(MenuItem order) onRealizeOrder;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30),
        children: [
          const SizedBox(height: 40),
          const Text(
            'Restaurantes disponíveis',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Color(0xFF929292), thickness: 1),
          const SizedBox(height: 10), 
          // ListView da lista de restaurantes
          for (var restaurant in availableRestaurants)
            RestaurantCard(
              restaurant: restaurant,
              onSelectedCardapio: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CardapioScreen(
                      restaurant: restaurant,
                      onRealizeOrder: onRealizeOrder,
                    )
                  )
                );
              },
            ),
        ],
      ),
    );
  }
}