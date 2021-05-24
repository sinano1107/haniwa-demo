import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../tag_info_view_model.dart';
import 'package:haniwa_demo/common/cloud_firestore.dart';

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TagInfoViewModel>(context, listen: false);

    if (Provider.of<TagInfoViewModel>(context).category != null) {
      return FutureBuilder(
        future: _buildItems(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DropdownButton(
              value: provider.category.categoryId,
              items: snapshot.data,
              onChanged: (value) => _onChanged(value, provider),
            );
          }

          return CircularProgressIndicator();
        },
      );
    } else {
      return Container();
    }
  }

  Future<List<DropdownMenuItem<String>>> _buildItems(
    BuildContext context,
  ) async {
    return (await getCategoriesWithGroup(
      Provider.of<TagInfoViewModel>(context).groupId,
    ))
        .map(
          (category) => DropdownMenuItem(
            value: category.categoryId,
            child: Text(
              category.name,
            ),
          ),
        )
        .toList();
  }

  void _onChanged(String categoryId, TagInfoViewModel provider) async {
    await editCategoryIdInTag(provider.groupId, provider.tagId, categoryId);
    provider.getCategory();
  }
}
