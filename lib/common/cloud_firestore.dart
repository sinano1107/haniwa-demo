import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haniwa_demo/models/group.dart';
import 'package:haniwa_demo/models/tag.dart';

// グループを取得
Future<Group> getGroup(String groupId) {
  final then = (DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      return Group(
        name: documentSnapshot['name'],
        members: documentSnapshot['members'],
      );
    } else {
      print('グループが存在しませんでした');
      return null;
    }
  };

  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .get()
      .then(then);
}

// タグを取得
Future<Tag> getTag(String groupId, String tagId) {
  final then = (DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      return Tag();
    } else {
      print('タグが存在しませんでした');
      return null;
    }
  };

  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('tags')
      .doc(tagId)
      .get()
      .then(then);
}
