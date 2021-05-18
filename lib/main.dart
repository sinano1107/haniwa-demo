import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'pages/dev/dev_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'pages/home/home_page.dart';
import 'pages/tag_read/tag_read_page.dart';
import 'pages/tag_info/tag_info_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // 初期化失敗時
        if (snapshot.hasError) {
          return Text('初期化に失敗しました');
        }

        // 初期化成功時
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: (FirebaseAuth.instance.currentUser != null)
                ? HomePage.id
                : SignInPage.id,
            routes: {
              DevPage.id: (_) => DevPage(title: '開発ページ'),
              SignInPage.id: (_) => SignInPage(),
              HomePage.id: (_) => HomePage(),
              TagReadPage.id: (_) => TagReadPage(),
              TagInfoPage.id: (_) => TagInfoPage(),
            },
          );
        }

        // ローディング
        return Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
