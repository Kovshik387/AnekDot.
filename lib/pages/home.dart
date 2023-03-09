import 'package:anekdot_pars_test/widget.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_date/random_date.dart';
import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
List<String> Anekdot = [];

// ignore: unused_element
bool _isLoading = true;

// Future<List<String>?> getData() async {
//   try {
//     var randomDate = RandomDate.withRange(2014, 2023).random();
//     final DateFormat format = DateFormat('yyyy-MM-dd');
//     String formatedDate = format.format(randomDate);
//     print('Дата\t' + formatedDate);

//     final response = await http.Client().get(
//         Uri.parse('https://www.anekdot.ru/release/anekdot/day/$formatedDate'));

//     if (response.statusCode == 200) {
//       print('Запарсили');
//       var document = parse(response.body);
//       var ctx = document
//           .getElementsByClassName('col-left col-left-margin')
//           .first
//           .children
//           .sublist(1);
//       for (var element in ctx) {
//         if (element.className == 'topicbox') {
//           Anekdot.add(element.children.first.text);
//         }
//       }
//       if (Anekdot.isNotEmpty) print('Внутри есть анекдоты');
//     }
//     return Anekdot.toList();
//   } catch (e) {
//     print('Finding Error: $e');
//     return null;
//   }
// }

// void conv() async {
//   final data = getData();
//   final list = await data;
//   Anekdot = list!;
// }

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get direction => null;

  bool _isLoading = true;
  List<String> Anekdot = [];

  @override
  void initState() {
    //conv();
    getData();
    super.initState();
  }

  getData() async {
    try {
      var randomDate = RandomDate.withRange(2014, 2023).random();
      final DateFormat format = DateFormat('yyyy-MM-dd');
      String formatedDate = format.format(randomDate);
      print('Дата\t' + formatedDate);

      final response = await http.Client().get(Uri.parse(
          'https://www.anekdot.ru/release/anekdot/day/$formatedDate'));

      if (response.statusCode == 200) {
        print('Запарсили');
        var document = parse(response.body);
        var ctx = document
            .getElementsByClassName('col-left col-left-margin')
            .first
            .children
            .sublist(1);
        for (var element in ctx) {
          if (element.className == 'topicbox') {
            Anekdot.add(element.children.first.text);
          }
        }

        setState(() {
          _isLoading = false;
        });

        if (Anekdot.isNotEmpty) print('Внутри есть анекдоты');
      }
      return Anekdot.toList();
    } catch (e) {
      print('Finding Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Анекдоты'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 61, 107),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            if (_isLoading) {
              return const Center(
                  child: Text('Загрузка', textAlign: TextAlign.center));
            } else {
              return Slidable(
                key: Key(Anekdot[index]),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    setState(() {
                      Anekdot.removeAt(0);
                      if (Anekdot.isEmpty) {
                        initState();
                      }
                    });
                  }),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          Anekdot.removeAt(0);
                          if (Anekdot.isEmpty) {
                            initState();
                          }
                        });
                      },
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Сохранить',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: ((() {
                    setState(() {
                      Anekdot.removeAt(0);
                      if (Anekdot.isEmpty) {
                        initState();
                      }
                    });
                  }))),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          Anekdot.removeAt(0);
                          if (Anekdot.isEmpty) {
                            initState();
                          }
                        });
                      },
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete_forever,
                      label: 'Удалить',
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 600,
                  child: Center(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0))),
                      color: const Color.fromARGB(255, 77, 151, 194),
                      shadowColor: Colors.black87,
                      //margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        title: Text(
                          Anekdot[0],
                          style: const TextStyle(fontSize: 24),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
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
