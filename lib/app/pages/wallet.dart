import 'package:didkit/didkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hsdoor_app/app/blocs/keys/keys.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late String did;
  late KeysBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = Modular.get<KeysBloc>();
    bloc.add(KeysLoadEvent());

    Future.delayed(
      const Duration(milliseconds: 1000),
      () async {
        final storage = FlutterSecureStorage();
        final key = await storage.read(key: 'key');

        if (key == null || key.isEmpty) {
          did = 'Failed to load your key';
        } else {
          did = DIDKit.keyToDID('key', key);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(did),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text('Copy'),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: did),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Text('QRCode'),
                      onPressed: () {
                        Modular.to.pushNamed('/qrcode', arguments: did);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
