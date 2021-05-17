import 'package:flutter/material.dart';
import 'package:haniwa_demo/pages/tag_read/tag_read_page.dart';

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
                child: Text('タグを読む'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(TagReadPage.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
