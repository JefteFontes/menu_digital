import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

final historyProvider = FutureProvider<List<Order>>((ref) async {
  final url = Uri.https('avali-app-menudigital-default-rtdb.firebaseio.com', 'orders.json');
  final userId = FirebaseAuth.instance.currentUser?.uid;

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>?;

      if (data == null) {
        return [];
      }

      final orders = data.entries
          .where((entry) {
            final orderData = entry.value as Map<String, dynamic>;
            return orderData['userId'] == userId; // Filtra os pedidos do usuário atual
          })
          .map((entry) {
            final orderData = entry.value as Map<String, dynamic>;
            return Order.fromJson(orderData);
          })
          .toList();

      return orders;
    } else {
      throw Exception('Erro ao carregar histórico.');
    }
  } catch (error) {
    throw Exception('Erro ao carregar histórico: $error');
  }
});

class Order {
  final List<MenuItem> items;
  final double totalPrice;
  final DateTime timestamp;

  Order({required this.items, required this.totalPrice, required this.timestamp});

  factory Order.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>).map((item) {
      return MenuItem(
        id: item['id'] ?? '',
        title: item['title'],
        price: (item['price'] as num).toDouble(),
        imageMenu: item['imageMenu'] ?? '',
        description: item['description'] ?? '',
        ingredients: item['ingredients'] ?? [], 
      );
    }).toList();

    return Order(
      items: items,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}