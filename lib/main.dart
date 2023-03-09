import 'package:flutter/material.dart';
import 'package:anekdot_pars_test/pages/home.dart';
// import 'package:hello_flutter/pages/main_screen.dart';
// import 'package:hello_flutter/pages/pageAll.dart';

void main() {
  runApp(const MainPrek());
}

class MainPrek extends StatelessWidget {
  const MainPrek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue),
      initialRoute: '/page', 
      routes: {
        '/main': (context) => Home(), 
        '/page': (context) => Home(),
      },
    ));
  }
}
