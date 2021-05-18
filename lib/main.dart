import 'package:flutter/material.dart';
import 'package:mobx_flutter/screens/home.dart';
import 'package:provider/provider.dart';

import 'controllers/controller.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<Controller>(
        create: (_) => Controller(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AulaMobx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Exemplo'),
    );
  }
}
