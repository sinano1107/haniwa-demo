import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:haniwa_demo/common/snackbar.dart';
import 'package:haniwa_demo/pages/tag_info/tag_info_page.dart';

class QRScanPage extends StatefulWidget {
  static const id = 'qr_scan';

  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> with ReassembleHandler {
  QRViewController _qrController;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  bool _isQRScanned = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrController?.pauseCamera();
    }
    _qrController?.resumeCamera();
  }

  @override
  void dispose() {
    _qrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QRコードスキャン')),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: _buildQRView(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQRView(BuildContext context) {
    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 16,
        borderLength: 24,
        borderWidth: 8,
      ),
    );
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() => _qrController = qrController);
    // QR読み込みをlistenする
    qrController.scannedDataStream.listen((scanData) {
      // QRのデータが取得できない場合SnackBar表示
      if (scanData.code == null) showSnackBar(context, 'QRのデータを取得できませんでした');
      // 次の画面へ遷移
      _transitionToNextScreen(scanData.code);
    });
  }

  Future<void> _transitionToNextScreen(String data) async {
    if (!_isQRScanned) {
      // カメラを一時停止
      _qrController?.pauseCamera();
      _isQRScanned = true;
      // 次の画面へ遷移
      final i = data.indexOf('id%3D') + 5;
      final groupTagId = data.substring(i, i + 41);
      Navigator.pushNamed(
        context,
        TagInfoPage.id,
        arguments: TagInfoPageArguments(groupTagId),
      ).then(
        // 遷移先画面から戻った場合カメラを再開
        (_) {
          _qrController?.resumeCamera();
          _isQRScanned = false;
        },
      );
    }
  }
}

Future<void> qrPermissionHandler(BuildContext context) async {
  if (await Permission.camera.request().isGranted) {
    Navigator.pushNamed(context, QRScanPage.id);
  } else {
    await showRequestPermissionDialog(context);
  }
}

Future<void> showRequestPermissionDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('カメラを許可してください'),
        content: Text('QRコードを読み取るためにカメラを利用します'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.popUntil(
              context,
              (route) => route.isFirst,
            ),
            child: Text('キャンセル'),
          ),
          ElevatedButton(
            onPressed: () async {
              openAppSettings();
            },
            child: Text('設定'),
          ),
        ],
      );
    },
  );
}
