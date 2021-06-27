import 'package:didkit/didkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        final storage = FlutterSecureStorage();
        final key = await storage.read(key: 'key') ?? '';

        if (key.isEmpty) {
          storage.write(
            key: 'key',
            value: DIDKit.generateEd25519Key(),
          );
        }

        Modular.to.pushReplacementNamed('/wallet');
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              height: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ),
      );
}
