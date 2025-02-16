import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_digital/screens/info_screen.dart';
import 'package:menu_digital/screens/menu_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:menu_digital/providers/history_provider.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer ({super.key});

  void logout(BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseAuth.instance.signOut(); // Aguarda a conclusão do logout
    ref.invalidate(historyProvider); // Invalida o histórico para evitar dados do usuário anterior

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao fazer logout: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.storefront,
                  size: 48,
                  color: Color(0xFFF56606),
                ),
                SizedBox(width: 18),
                Text(
                  'Menu Digital',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.menu_book,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'Principal',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color:Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MenuScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'Informações',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color:Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const InfoScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: Text(
                  'Sair',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color:Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
                onTap: () => logout(context, ref),
              ),
            ],
          )
        ],
      ),
    );
  }
}