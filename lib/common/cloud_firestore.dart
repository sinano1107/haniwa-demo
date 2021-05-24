import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haniwa_demo/models/group.dart';
import 'package:haniwa_demo/models/tag.dart';
import 'package:haniwa_demo/models/category.dart';

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
      return Tag(
        tagId: tagId,
        category: documentSnapshot['category'],
      );
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

// タグに紐付いているカテゴリを取得
Future<Category> getCategoryWithTag(String groupId, String tagId) async {
  final tag = await getTag(groupId, tagId);
  if (tag == null) return null;

  final then = (DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      return Category(
        categoryId: documentSnapshot.id,
        name: documentSnapshot['name'],
      );
    } else {
      print('カテゴリが存在しませんでした');
      return null;
    }
  };

  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('categories')
      .doc(tag.category)
      .get()
      .then(then);
}

// グループの全カテゴリを取得
Future<List<Category>> getCategoriesWithGroup(String groupId) async {
  final then = (QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map(
          (category) => Category(
            categoryId: category.id,
            name: category['name'],
          ),
        )
        .toList();
  };

  return FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('categories')
      .get()
      .then(then);
}

// タグのカテゴリIDを変更
Future editCategoryIdInTag(
    String groupId, String tagId, String newCategoryId) async {
  await FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('tags')
      .doc(tagId)
      .update({'category': newCategoryId}).then((_) => print('カテゴリID編集完了'));
}
