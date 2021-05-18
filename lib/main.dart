import 'package:flutter/material.dart';

import 'pages/dev/dev_page.dart';
import 'pages/home/home_page.dart';
import 'pages/tag_read/tag_read_page.dart';
import 'pages/tag_info/tag_info_page.dart';

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
      initialRoute: HomePage.id,
      routes: {
        DevPage.id: (_) => DevPage(title: '開発ページ'),
        HomePage.id: (_) => HomePage(),
        TagReadPage.id: (_) => TagReadPage(),
        TagInfoPage.id: (_) => TagInfoPage(),
      },
    );
  }
}
