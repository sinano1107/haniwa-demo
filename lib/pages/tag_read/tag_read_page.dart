import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haniwa_demo/common/nfc_session.dart';
import 'tag_read_view_model.dart';

class TagReadPage extends StatelessWidget {
  static const id = 'tag-read';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TagReadViewModel()),
      ],
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('タグを読みます')),
            body: Column(
              children: [
                MaterialButton(
                  child: Text('スキャン'),
                  onPressed: () => startSession(
                    handleTag:
                        Provider.of<TagReadViewModel>(context, listen: false)
                            .handleTag,
                  ),
                ),
                Text(Provider.of<TagReadViewModel>(context).tagId),
              ],
            ),
          );
        },
      ),
    );
  }
}
