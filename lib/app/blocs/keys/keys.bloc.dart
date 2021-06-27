import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:hsdoor_app/app/blocs/keys/keys.event.dart';
import 'package:hsdoor_app/app/blocs/keys/keys.state.dart';
import 'package:hsdoor_app/app/config.dart';

class KeysBloc extends Bloc<KeysEvent, KeysState> {
  final Dio client;

  KeysBloc(this.client) : super(KeysInitialState());

  @override
  Stream<KeysState> mapEventToState(KeysEvent event) async* {
    if (event is KeysLoadEvent) {
      yield* _load();
    }
  }

  Stream<KeysState> _load() async* {
    yield KeysLoadingState();

    final url = '${Config.nodeUrl}/keys';
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final keys = response.data['keys'].map((key) => key['holder']).toList();
      final threshold = response.data['threshold'];
      yield KeysLoadedState(
        keys: keys,
        threshold: threshold,
      );
    } else {
      yield KeysErrorState(
        message: 'Failed to load keys, code: ${response.statusCode}',
      );
    }
  }
}
