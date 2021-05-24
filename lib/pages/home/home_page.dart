import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haniwa_demo/common/firebase_dynamic_links.dart';
import 'package:haniwa_demo/pages/sign_in/sign_in_page.dart';
import 'package:haniwa_demo/pages/tag_read/tag_read_page.dart';
import 'package:haniwa_demo/pages/qr_scan/qr_scan_page.dart';

import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  static const id = 'home';

  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, SignInPage.id, (_) => false);
    } catch (e) {
      print('サインアウトに失敗しました');
    }
  }

  void createDynamicLink() async {
    final uri = await createInviteDynamicLink(id: 'xxxxxx');
    print(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => _signOut(context),
        ),
        title: Text('HOME'),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              child: Text('タグを読む'),
              onPressed: () => Navigator.pushNamed(context, TagReadPage.id),
            ),
            MaterialButton(
              child: Text('QRスキャン'),
              onPressed: () => qrPermissionHandler(context),
            ),
            MaterialButton(
              child: Text('DynamicLink作成'),
              onPressed: createDynamicLink,
            ),
          ],
        ),
      ),
    );
  }
}
