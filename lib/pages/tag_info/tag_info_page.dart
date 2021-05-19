import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haniwa_demo/common/snackbar.dart';
import 'tag_info_view_model.dart';

class TagInfoPage extends StatelessWidget {
  static const id = 'tag-info';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TagInfoViewModel())],
      child: TagInfoPageContent(),
    );
  }
}

class TagInfoPageContent extends StatefulWidget {
  @override
  _TagInfoPageContentState createState() => _TagInfoPageContentState();
}

class _TagInfoPageContentState extends State<TagInfoPageContent> {
  @override
  void initState() {
    super.initState();
    var viewModel = Provider.of<TagInfoViewModel>(context, listen: false);
    viewModel.tagIsCorrect.stream
        .listen((_) => showSnackBar(context, 'このタグは正常です'));
    viewModel.tagIsIncorrect.stream
        .listen((message) => showSnackBar(context, message));
  }

  @override
  Widget build(BuildContext context) {
    final TagInfoPageArguments _args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('タグの情報')),
      body: Column(
        children: [
          Text(_args.groupTagId + 'の情報'),
          MaterialButton(
            child: Text('タグを調べる'),
            onPressed: () => Provider.of<TagInfoViewModel>(
              context,
              listen: false,
            ).isTagCorrect(_args.groupTagId),
          ),
        ],
      ),
    );
  }
}

class TagInfoPageArguments {
  final String groupTagId;
  TagInfoPageArguments(this.groupTagId);
}
