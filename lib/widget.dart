import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 37, 84, 123)),
              child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 37, 84, 123)),
                  accountName: Text(
                    'Меню',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  accountEmail: Text('https://github.com/Kovshik387',
                      style: TextStyle(color: Colors.white))),
            ),
            ListTile(
              title: const Text("Анекдоты"),
              leading: const Icon(Icons.mood),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/main', (route) => false);
              },
            ),
            ListTile(
              title: const Text("Сохраненные Анекдоты"),
              leading: const Icon(Icons.bookmarks_outlined),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/page', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
