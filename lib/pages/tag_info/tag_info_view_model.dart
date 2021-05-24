import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haniwa_demo/models/category.dart';
import 'package:haniwa_demo/common/cloud_firestore.dart';

class TagInfoViewModel extends ChangeNotifier {
  String _groupId;
  String get groupId => _groupId;
  String _tagId;
  String get tagId => _tagId;

  var _tagIsCorrect = StreamController<String>();
  StreamController<String> get tagIsCorrect => _tagIsCorrect;

  var _tagIsIncorrect = StreamController<String>();
  StreamController<String> get tagIsIncorrect => _tagIsIncorrect;

  // タグが正常かつこのユーザーと関連しているか調べる
  Future isTagCorrect(String groupTagId) async {
    // 入力がフォーマットに沿っているか
    final ids = groupTagId.split('-');
    if (ids.length != 2) {
      _tagIsIncorrect.sink.add('このタグは不正です:0');
      throw Error();
    }

    // 入力が空ではないか
    final groupId = ids[0];
    final tagId = ids[1];
    if (groupId.isEmpty || tagId.isEmpty) {
      _tagIsIncorrect.sink.add('このタグは不正です:1');
      throw Error();
    }

    // グループが存在するか
    final group = await getGroup(groupId);
    if (group == null) {
      _tagIsIncorrect.sink.add('グループが存在しません');
      throw Error();
    }

    // ユーザーがそのグループのメンバーか
    final uid = FirebaseAuth.instance.currentUser.uid;
    if (!group.members.contains(uid)) {
      _tagIsIncorrect.sink.add('グループのメンバーではありません');
      throw Error();
    }

    final tag = await getTag(groupId, tagId);
    if (tag == null) {
      _tagIsIncorrect.sink.add('タグが存在しません');
      throw Error();
    }

    // 正常
    _tagIsCorrect.sink.add('');
    _groupId = groupId;
    _tagId = tagId;
  }

  //--------------------------------------------------------------

  Category _category;
  Category get category => _category;
  void getCategory() async {
    final category = await getCategoryWithTag(
      _groupId,
      _tagId,
    );

    _category = category;
    notifyListeners();
  }

  //--------------------------------------------------------------

  @override
  void dispose() {
    _tagIsCorrect.close();
    _tagIsIncorrect.close();
    super.dispose();
  }
}
