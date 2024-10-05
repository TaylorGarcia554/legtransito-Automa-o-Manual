import 'package:flutter/material.dart';

class drawerMenu extends StatelessWidget {
  final String pagina;
  final BuildContext context;

  const drawerMenu(this.pagina, this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Slides'),
              onTap: () {
                print("Manual");
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
