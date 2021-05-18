import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagInfoPage extends StatelessWidget {
  static const id = 'tag-info';

  @override
  Widget build(BuildContext context) {
    final TagInfoPageArguments _args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text(_args.tagId + 'の情報')),
      body: Container(),
    );
  }
}

class TagInfoPageArguments {
  final String tagId;
  TagInfoPageArguments(this.tagId);
}
