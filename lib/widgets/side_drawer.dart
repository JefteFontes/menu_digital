import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer ({super.key});

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
                onTap: () {},
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
                onTap: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}