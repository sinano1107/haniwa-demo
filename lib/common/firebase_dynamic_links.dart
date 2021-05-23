import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future<Uri> createInviteDynamicLink({String id}) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://sinano1107.page.link',
    link: Uri.parse('https://qiita.com/?id=$id'),
    // iOS用の設定
    iosParameters: IosParameters(
      bundleId: 'com.sinano1107.haniwa-dev',
      appStoreId: '962194608',
    ),
  );
  var dynamicUrl = await parameters.buildUrl();
  return dynamicUrl;
}
