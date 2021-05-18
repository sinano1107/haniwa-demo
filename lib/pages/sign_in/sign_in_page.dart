import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:haniwa_demo/pages/home/home_page.dart';

class SignInPage extends StatefulWidget {
  static const id = 'sign-in';

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (_) => false);
      }
    });
  }

  void _signInAnonymously() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('サインイン')),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              child: Text('匿名でサインイン'),
              onPressed: _signInAnonymously,
            ),
          ],
        ),
      ),
    );
  }
}
