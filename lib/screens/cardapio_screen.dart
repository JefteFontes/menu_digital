import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/widgets/cardapio_item_card.dart';
import 'package:menu_digital/screens/menuitem_details.dart';
import 'package:transparent_image/transparent_image.dart';

class CardapioScreen extends StatelessWidget {
  const CardapioScreen({
    super.key,
    required this.restaurant,
  });

  final Restaurant restaurant;

  
  Widget _buildCardapioItems(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: Image.asset(restaurant.imageLogo).image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150
                  )
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.address,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        restaurant.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800]
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ]
                  )
                )
              ],
            )
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pratos disponiveis:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16
              ),
              itemCount: restaurant.menuItems.length,
              itemBuilder: (ctx, index) => CardapioItemCard(
                cardapioItem: restaurant.menuItems[index],
                selectedItemDetails: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MenuItemDetails(
                      item: restaurant.menuItems[index],
                    )
                  )
                ) ,
              ),
            ),
          )
        ],
      );
    }
  @override
  Widget build(BuildContext context) {
    Widget content = _buildCardapioItems(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurant.name
        )
      ),
      body: content
    );
  }
}