import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nfc_manager/nfc_manager.dart';

class TagReadViewModel extends ChangeNotifier {
  //-------------------------------------

  // ignore: close_sinks
  var _tagReadSuccessAction = StreamController<String>();
  StreamController<String> get tagReadSuccessAction => _tagReadSuccessAction;

  //-------------------------------------

  Future<String> handleTag(NfcTag tag) async {
    try {
      String tagId;

      // tagId(最初のtext)を検索
      final ndef = Ndef.from(tag);
      final list = Iterable.generate(ndef.cachedMessage?.records?.length ?? 0);
      for (final i in list) {
        final record = ndef.cachedMessage.records[i];
        // テキストのデータだった場合
        if (record.type.length == 1 && record.type.first == 0x54) {
          final languageCodeLength = record.payload.first;
          final text =
              utf8.decode(record.payload.sublist(1 + languageCodeLength));
          tagId = text;
          break;
        }
      }

      // tagIdが存在したら流し込む
      if (tagId != null)
        _tagReadSuccessAction.sink.add(tagId);
      else
        print('タグが存在しませんでした');
      return '読み込み完了';
    } catch (e) {
      print('タグの情報を解釈できませんでした: $e');
      return '読み込み失敗';
    }
  }
}
