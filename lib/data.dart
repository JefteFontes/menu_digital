import 'package:flutter/material.dart';

class Restaurant {
  final String id;
  final String name;
  final String imageUrl;
  final List<MenuItem> menuItems;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.menuItems,
  });
}

class MenuItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  const MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });
}

// Lista de restaurantes com seus respectivos itens de menu
const availableRestaurants = [
  Restaurant(
    id: 'r1',
    name: 'Italian Bistro',
    imageUrl: 'https://cdn.pixabay.com/photo/2017/06/14/10/55/spaghetti-2400874_1280.jpg',
    menuItems: [
      MenuItem(
        id: 'm1',
        title: 'Spaghetti Bolognese',
        description: 'Classic Italian pasta with a rich meat sauce.',
        imageUrl: 'https://cdn.pixabay.com/photo/2017/06/14/10/55/spaghetti-2400874_1280.jpg',
        price: 25.50,
      ),
      MenuItem(
        id: 'm2',
        title: 'Lasagna',
        description: 'Layered pasta with meat, cheese, and a savory tomato sauce.',
        imageUrl: 'https://cdn.pixabay.com/photo/2016/05/05/17/17/lasagna-1371164_1280.jpg',
        price: 30.00,
      ),
    ],
  ),
  Restaurant(
    id: 'r2',
    name: 'Burger Joint',
    imageUrl: 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    menuItems: [
      MenuItem(
        id: 'm3',
        title: 'Classic Cheeseburger',
        description: 'Beef patty with cheese, lettuce, tomato, and pickles.',
        imageUrl: 'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
        price: 15.00,
      ),
      MenuItem(
        id: 'm4',
        title: 'Veggie Burger',
        description: 'A hearty veggie patty with all the classic burger toppings.',
        imageUrl: 'https://cdn.pixabay.com/photo/2015/03/29/15/56/hamburger-695439_1280.jpg',
        price: 13.00,
      ),
    ],
  ),
  Restaurant(
    id: 'r3',
    name: 'Sushi House',
    imageUrl: 'https://cdn.pixabay.com/photo/2017/03/17/16/33/sushi-2150151_1280.jpg',
    menuItems: [
      MenuItem(
        id: 'm5',
        title: 'California Roll',
        description: 'Crab meat, avocado, and cucumber wrapped in seaweed and rice.',
        imageUrl: 'https://cdn.pixabay.com/photo/2017/03/17/16/33/sushi-2150151_1280.jpg',
        price: 18.50,
      ),
      MenuItem(
        id: 'm6',
        title: 'Sashimi Platter',
        description: 'Assorted fresh fish served raw with soy sauce and wasabi.',
        imageUrl: 'https://cdn.pixabay.com/photo/2015/06/29/01/25/sushi-824399_1280.jpg',
        price: 25.00,
      ),
    ],
  ),
  Restaurant(
    id: 'r4',
    name: 'Taco Corner',
    imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/tacos-1238902_1280.jpg',
    menuItems: [
      MenuItem(
        id: 'm7',
        title: 'Beef Tacos',
        description: 'Soft tortillas with seasoned ground beef, lettuce, cheese, and salsa.',
        imageUrl: 'https://cdn.pixabay.com/photo/2016/03/05/19/02/tacos-1238902_1280.jpg',
        price: 12.00,
      ),
      MenuItem(
        id: 'm8',
        title: 'Chicken Quesadilla',
        description: 'Flour tortilla stuffed with chicken, cheese, and spices, grilled to perfection.',
        imageUrl: 'https://cdn.pixabay.com/photo/2018/01/16/14/21/quesadilla-3082354_1280.jpg',
        price: 15.00,
      ),
    ],
  ),
  Restaurant(
    id: 'r5',
    name: 'Pasta Palace',
    imageUrl: 'https://cdn.pixabay.com/photo/2016/10/21/09/45/pasta-1753012_1280.jpg',
    menuItems: [
      MenuItem(
        id: 'm9',
        title: 'Penne Alfredo',
        description: 'Penne pasta served with a creamy Alfredo sauce and parmesan cheese.',
        imageUrl: 'https://cdn.pixabay.com/photo/2016/10/21/09/45/pasta-1753012_1280.jpg',
        price: 22.00,
      ),
      MenuItem(
        id: 'm10',
        title: 'Fettuccine Carbonara',
        description: 'Fettuccine pasta with eggs, cheese, pancetta, and pepper.',
        imageUrl: 'https://cdn.pixabay.com/photo/2017/07/31/13/05/italian-2560526_1280.jpg',
        price: 24.00,
      ),
    ],
  ),
];
