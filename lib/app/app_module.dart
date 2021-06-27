import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hsdoor_app/app/blocs/keys/keys.dart';
import 'package:hsdoor_app/app/pages/qrcode.dart';
import 'package:hsdoor_app/app/pages/splash.dart';
import 'package:hsdoor_app/app/pages/wallet.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => KeysBloc(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => SplashPage(),
        ),
        ChildRoute(
          '/wallet',
          child: (_, __) => WalletPage(),
        ),
        ChildRoute(
          '/qrcode',
          child: (_, args) => QrCodePage.QrCodePage(
            data: args.data!,
          ),
        ),
      ];
}
