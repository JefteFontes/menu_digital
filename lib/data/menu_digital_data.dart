class Restaurant {
  final String id;
  final String name;
  final String imageLogo;
  final String address;
  final String phoneNumber;
  final double rating;
  final List<MenuItem> menuItems;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageLogo,
    required this.address,
    required this.phoneNumber,
    required this.rating,
    required this.menuItems,
  });
}

class MenuItem {
  final String id;
  final String title;
  final String description;
  final String imageMenu;
  final double price;
  final List<String> ingredients;

  const MenuItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageMenu,
    required this.price,
    required this.ingredients,
  });
}

// Lista de restaurantes com os novos campos adicionados
const availableRestaurants = [
  Restaurant(
    id: 'r1',
    name: 'Italian Bistro',
    imageLogo: 'assets/images/italian.jpg',
    address: '123 Main Street, Rome, Italy',
    phoneNumber: '+39 06 1234 5678',
    rating: 4.8,
    menuItems: [
      MenuItem(
        id: 'm1',
        title: 'Spaghetti Bolognese',
        description: 'Uma combinação clássica de espaguete com um molho rico e saboroso à base de carne moída, tomates frescos e especiarias italianas.',
        imageMenu: 'assets/images/spaghetti_bolognese.png',
        price: 25.50,
        ingredients: [
          'Espaguete',
          'Carne moída',
          'Molho de tomate',
          'Cebola',
          'Alho',
          'Manjericão',
          'Azeite de oliva',
          'Queijo parmesão'
        ],
      ),
      MenuItem(
        id: 'm2',
        title: 'Lasagna',
        description: 'Camadas de massa de lasanha intercaladas com molho de carne, molho branco e uma mistura de queijos, tudo assado até dourar.',
        imageMenu: 'assets/images/lasagna.png',
        price: 30.00,
        ingredients: [
          'Massa de lasanha',
          'Carne moída',
          'Molho de tomate',
          'Molho bechamel',
          'Queijo mussarela',
          'Queijo parmesão',
          'Manjericão'
        ],
      ),
    ],
  ),
  Restaurant(
    id: 'r2',
    name: 'Burger Joint',
    imageLogo: 'assets/images/burger.jpg',
    address: '456 Elm Street, New York, USA',
    phoneNumber: '+1 212 555 1234',
    rating: 4.5,
    menuItems: [
      MenuItem(
        id: 'm3',
        title: 'Classic Cheeseburger',
        description: 'Um hambúrguer clássico com um suculento hambúrguer de carne bovina, queijo derretido e acompanhamentos frescos.',
        imageMenu: 'assets/images/classic_cheeseburger.png',
        price: 15.00,
        ingredients: [
          'Pão de hambúrguer',
          'Carne bovina',
          'Queijo cheddar',
          'Alface',
          'Tomate',
          'Picles',
          'Molho especial',
        ],
      ),
      MenuItem(
        id: 'm4',
        title: 'Veggie Burger',
        description: 'Uma opção vegetariana deliciosa, com um hambúrguer à base de vegetais e os acompanhamentos clássicos de um burger.',
        imageMenu: 'assets/images/veggie_burger.png',
        price: 13.00,
        ingredients: [
          'Pão de hambúrguer',
          'Hambúrguer de vegetais',
          'Alface',
          'Tomate',
          'Picles',
          'Molho especial'
        ],
      ),
    ],
  ),
  Restaurant(
    id: 'r3',
    name: 'Sushi House',
    imageLogo: 'assets/images/sushi.jpg',
    address: '789 Sushi Lane, Tokyo, Japan',
    phoneNumber: '+81 3 4567 8901',
    rating: 4.9,
    menuItems: [
      MenuItem(
        id: 'm5',
        title: 'California Roll',
        description: 'Um rolo de sushi clássico com carne de caranguejo, abacate e pepino, envolto em arroz temperado e alga nori.',
        imageMenu: 'assets/images/california_roll.png',
        price: 18.50,
        ingredients: [
          'Carne de caranguejo',
          'Abacate',
          'Pepino',
          'Arroz para sushi',
          'Alga nori',
          'Vinagre de arroz',
          'Gergelim'
        ],
      ),
      MenuItem(
        id: 'm6',
        title: 'Sashimi Platter',
        description: 'Uma seleção de peixes frescos fatiados finamente, servidos com molho de soja e wasabi.',
        imageMenu: 'assets/images/sashimi_platter.png',
        price: 25.00,
        ingredients: [
          'Salmão',
          'Atum',
          'Peixe branco',
          'Molho de soja',
          'Wasabi',
          'Gengibre em conserva'
        ],
      ),
    ],
  ),
  Restaurant(
    id: 'r4',
    name: 'Taco Corner',
    imageLogo: 'assets/images/taco.jpg',
    address: '321 Taco Avenue, Mexico City, Mexico',
    phoneNumber: '+52 55 1234 5678',
    rating: 4.7,
    menuItems: [
      MenuItem(
        id: 'm7',
        title: 'Beef Tacos',
        description: 'Tortilhas macias recheadas com carne moída temperada, alface crocante, queijo e salsa fresca.',
        imageMenu: 'assets/images/beef_tacos.png',
        price: 12.00,
        ingredients: [
          'Tortilhas de trigo',
          'Carne moída',
          'Alface',
          'Queijo cheddar',
          'Salsa fresca'
        ],
      ),
      MenuItem(
        id: 'm8',
        title: 'Chicken Quesadilla',
        description: 'Uma quesadilla recheada com frango desfiado, queijo derretido e especiarias mexicanas, grelhada até ficar crocante.',
        imageMenu: 'assets/images/chicken_quesadilla.png',
        price: 15.00,
        ingredients: [
          'Tortilhas de trigo',
          'Frango desfiado',
          'Queijo mussarela',
          'Especiarias mexicanas',
          'Creme azedo'
        ],
      ),
    ],
  ),
  Restaurant(
    id: 'r5',
    name: 'Pasta Palace',
    imageLogo: 'assets/images/pasta.jpg',
    address: '567 Pasta Street, Milan, Italy',
    phoneNumber: '+39 02 9876 5432',
    rating: 4.6,
    menuItems: [
      MenuItem(
        id: 'm9',
        title: 'Penne Alfredo',
        description: 'Um prato delicioso com macarrão penne cozido na perfeição, servido em um molho Alfredo cremoso e coberto com queijo parmesão ralado na hora para um sabor rico e satisfatório.',
        ingredients: [
          'Macarrão penne', 
          'Molho Alfredo (manteiga, creme de leite, alho)', 
          'Queijo parmesão', 
          'Salsa (opcional)'
        ],
        imageMenu: 'assets/images/penne_alfredo.png',
        price: 22.00,
      ),
      MenuItem(
        id: 'm10',
        title: 'Fettuccine Carbonara',
        description: 'Uma receita italiana clássica que combina macarrão fettuccine com uma mistura cremosa de ovos e queijo, complementada por pancetta crocante e pimenta-do-reino moída na hora.',
        ingredients: [
          'Massa Fettuccine', 
          'Gemas de ovo', 
          'Pancetta ou guanciale', 
          'Queijo parmesão', 
          'Pimenta preta'
        ],
        imageMenu: 'assets/images/fettuccine_carbonara.png',
        price: 24.00,
      ),
    ],
  ),

];
