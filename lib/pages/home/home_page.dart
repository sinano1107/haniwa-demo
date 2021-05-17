import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const id = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                child: Text('どっかへのぼたん'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
