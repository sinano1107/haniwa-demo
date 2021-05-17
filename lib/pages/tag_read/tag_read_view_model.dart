import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nfc_manager/nfc_manager.dart';

class TagReadViewModel extends ChangeNotifier {
  String _tagId = 'まだ読み込んでいません';
  String get tagId => _tagId;

  Future<String> handleTag(NfcTag tag) async {
    try {
      String newTagId = 'tagIdを見つけられませんでした';

      final ndef = Ndef.from(tag);
      final list = Iterable.generate(ndef.cachedMessage?.records?.length ?? 0);
      for (final i in list) {
        final record = ndef.cachedMessage.records[i];
        // テキストのデータだった場合
        if (record.type.length == 1 && record.type.first == 0x54) {
          final languageCodeLength = record.payload.first;
          final text =
              utf8.decode(record.payload.sublist(1 + languageCodeLength));
          newTagId = text;
          break;
        }
      }

      this._tagId = newTagId;
      notifyListeners();
      return '読み込み完了';
    } catch (e) {
      print('タグの情報を解釈できませんでした: $e');
    }
  }
}
