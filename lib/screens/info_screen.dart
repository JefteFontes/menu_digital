import 'package:flutter/material.dart';
import 'package:menu_digital/widgets/side_drawer.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Menu Digital é um aplicativo desenvolvido para facilitar o acesso aos cardápios de restaurantes e realização de pedidos.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Desenvolvedores:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'João Victor Rodrigues Terto e Jefté Fontes de Araújo',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      drawer: const SideDrawer(),
    );
  }
}