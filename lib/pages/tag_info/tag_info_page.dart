import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haniwa_demo/common/snackbar.dart';
import 'tag_info_view_model.dart';
import 'components/category_selector.dart';

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

    final _future = Provider.of<TagInfoViewModel>(
      context,
      listen: false,
    ).isTagCorrect(_args.groupTagId);

    return Scaffold(
      appBar: AppBar(title: Text('タグの情報')),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('初期化に失敗しました');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Text(_args.groupTagId + 'の情報'),
                Divider(),
                Text((Provider.of<TagInfoViewModel>(context).category == null)
                    ? 'カテゴリーを調べるには下のボタンを押してください'
                    : Provider.of<TagInfoViewModel>(context).category.name),
                MaterialButton(
                  child: Text('カテゴリーを調べる'),
                  onPressed: Provider.of<TagInfoViewModel>(
                    context,
                    listen: false,
                  ).getCategory,
                ),
                CategorySelector(),
              ],
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class TagInfoPageArguments {
  final String groupTagId;
  TagInfoPageArguments(this.groupTagId);
}
