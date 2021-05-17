import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dev_view_model.dart';

class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  void initState() {
    super.initState();
    var viewModel = Provider.of<DevViewModel>(context, listen: false);
    viewModel.loginSuccessAction.stream.listen((_) {
      print('遷移します');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text('ログイン'),
      onPressed: Provider.of<DevViewModel>(context, listen: false).login,
    );
  }
}
