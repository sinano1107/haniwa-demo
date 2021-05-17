import 'package:flutter/material.dart';
import 'pages/dev/dev_page.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: {
        'dev': (_) => DevPage(title: '開発ページ'),
        'home': (_) => HomePage(),
      },
    );
  }
}
