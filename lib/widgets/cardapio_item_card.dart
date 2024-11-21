import 'package:flutter/material.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:transparent_image/transparent_image.dart';

class CardapioItemCard extends StatelessWidget {
  const CardapioItemCard({
    super.key,
    required this.cardapioItem,
    required this.selectedItemDetails
  });

  final MenuItem cardapioItem;
  final VoidCallback? selectedItemDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: selectedItemDetails,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage), 
                  image: Image.asset(cardapioItem.imageMenu).image,
                  fit: BoxFit.contain,
                  height: 100,
                  width: double.infinity,
                )
              ),
              Text(
                cardapioItem.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'R\$ ${cardapioItem.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}