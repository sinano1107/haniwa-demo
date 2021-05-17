import 'dart:async';
import 'package:flutter/cupertino.dart';

class DevViewModel extends ChangeNotifier {
  //-------------------------------
  var _loginSuccessAction = StreamController<String>();
  StreamController<String> get loginSuccessAction => _loginSuccessAction;

  void login() {
    // 1.5秒delayしてなんちゃってログインを表現
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      // ログインに成功した！
      // イベントを通知して終わり
      _loginSuccessAction.sink.add("");
    });
  }

  //-------------------------------

  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    this._counter++;
    notifyListeners();
  }

  //-------------------------------

  @override
  void dispose() {
    // LoginViewModelがdisposeされたタイミングで必ずStreamはcloseする
    _loginSuccessAction.close();

    super.dispose();
  }
}
