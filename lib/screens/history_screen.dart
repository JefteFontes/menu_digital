import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_digital/providers/history_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({
    super.key
  });

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.refresh(historyProvider));
  }

  @override
  Widget build(BuildContext context) {
    final historyAsyncValue = ref.watch(historyProvider);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Pedidos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(historyProvider);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Usuário logado: ${user.email ?? 'Desconhecido'}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: historyAsyncValue.when(
              data: (orders) {
                if (orders.isEmpty) {
                  return const Center(
                    child: Text('Nenhum histórico de pedidos disponível.'),
                  );
                }

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text('Pedido em ${order.timestamp.toLocal()}'),
                        subtitle: Text('Total: R\$ ${order.totalPrice.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.expand_more),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Detalhes do Pedido'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: order.items.map((item) {
                                    return ListTile(
                                      title: Text(item.title),
                                      subtitle: Text('R\$ ${item.price.toStringAsFixed(2)}'),
                                    );
                                  }).toList(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Fechar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, _) => Center(
                child: Text('Erro ao carregar histórico: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
