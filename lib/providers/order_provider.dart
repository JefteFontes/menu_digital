import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:menu_digital/data/menu_digital_data.dart';


final orderProvider = StateNotifierProvider<OrderNotifier, List<MenuItem>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<MenuItem>> {
  OrderNotifier() : super([]);

  final firebaseUrl = Uri.https('avali-app-menudigital-default-rtdb.firebaseio.com', 'orders.json');
  
  void addOrder(MenuItem item) {
    if (!state.contains(item)) {
      state = [...state, item];
    } else {
      state = state.where((menuItem) => menuItem != item).toList();
    }
  }

  
  void clearOrders() {
    state = [];
  }

  
  double calculateTotalPrice(Map<MenuItem, int> quantities) {
    return state
        .map((item) => item.price * (quantities[item] ?? 1))
        .fold(0.0, (sum, price) => sum + price);
  }
  

  
  Future<void> sendOrder(Map<MenuItem, int> quantities) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      throw Exception("Usuário não autenticado.");
    }

    if (state.isEmpty) {
      throw Exception("Nenhum pedido realizado.");
    }

    final orderData = {
      "userId": userId,
      "items": state.map((item) { 
        return {
          "id": item.id,
          "title": item.title,
          "price": item.price,
          "quantity": quantities[item] ?? 1,
          "imageMenu": item.imageMenu
        };
      }).toList(),
      "totalPrice": calculateTotalPrice(quantities),
      "timestamp": DateTime.now().toIso8601String(),
    };

    try {
      final response = await http.post(
        firebaseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(orderData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        clearOrders();
        print("Pedido enviado com sucesso!");
      } else {
        throw Exception("Erro ao enviar pedido");
      }
    } catch (error) {
      print("Erro ao enviar o pedido: $error");
      rethrow;
    }
  }
}
