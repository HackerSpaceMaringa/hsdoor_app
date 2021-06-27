import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatelessWidget {
  final String data;

  QrCodePage({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImage(
          data: data,
          version: QrVersions.auto,
          size: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
