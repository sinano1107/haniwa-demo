import 'package:flutter/material.dart';
import 'package:haniwa_demo/common/nfc_session.dart';

class TagReadPage extends StatelessWidget {
  static const id = 'tag-read';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('タグを読みます')),
      body: Column(
        children: [
          MaterialButton(
            child: Text('スキャン'),
            onPressed: () => startSession(
              handleTag: (_) async {
                return '"タグ 読み込み" 完了';
              },
            ),
          ),
        ],
      ),
    );
  }
}
