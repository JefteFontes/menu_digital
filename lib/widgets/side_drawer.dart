import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu_digital/screens/info_screen.dart';
import 'package:menu_digital/screens/login_screen.dart';
import 'package:menu_digital/screens/menu_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer ({super.key});

  void logout(BuildContext context) async {
    try {
      FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao fazer logout: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: () => logout(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}