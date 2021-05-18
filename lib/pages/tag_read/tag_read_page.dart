import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haniwa_demo/common/nfc_session.dart';
import 'package:haniwa_demo/pages/tag_info/tag_info_page.dart';
import 'tag_read_view_model.dart';

class TagReadPage extends StatelessWidget {
  static const id = 'tag-read';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TagReadViewModel()),
      ],
      child: TagReadContent(),
    );
  }
}

class TagReadContent extends StatefulWidget {
  @override
  _TagReadContentState createState() => _TagReadContentState();
}

class _TagReadContentState extends State<TagReadContent> {
  @override
  void initState() {
    super.initState();
    var viewModel = Provider.of<TagReadViewModel>(context, listen: false);
    viewModel.tagReadSuccessAction.stream.listen((tagId) {
      print('tagId: $tagId');
      Navigator.of(context).pushNamed(
        TagInfoPage.id,
        arguments: TagInfoPageArguments(tagId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('タグを読みます')),
      body: Column(
        children: [
          MaterialButton(
            child: Text('スキャン'),
            onPressed: () => startSession(
              handleTag: Provider.of<TagReadViewModel>(context, listen: false)
                  .handleTag,
            ),
          ),
        ],
      ),
    );
  }
}
