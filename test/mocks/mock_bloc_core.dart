import 'package:aleteo_arquetipo/entities/entity_bloc.dart';

class MockBlocCore<T> extends BlocCore<T> {
  MockBlocCore() : super();
  final Map<String, BlocGeneral<T>> _injector = <String, BlocGeneral<T>>{};
  final Map<String, BlocModule> _moduleInjector = <String, BlocModule>{};

  @override
  BlocGeneral<T> getBloc<T2>(String key) {
    final BlocGeneral<T>? tmp = _injector[key.toLowerCase()];
    if (tmp == null) {
      throw UnimplementedError('The BlocGeneral were not initialized');
    }
    return tmp;
  }

  @override
  V getBlocModule<V>(String key) {
    final BlocModule? tmp = _moduleInjector[key.toLowerCase()];
    if (tmp == null) {
      throw UnimplementedError('The BlocModule were not initialized');
    }
    return _moduleInjector[key.toLowerCase()] as V;
  }

  @override
  void addBlocGeneral(String key, BlocGeneral<T> blocGeneral) {
    _injector[key.toLowerCase()] = blocGeneral;
  }

  @override
  bool get isDisposed => _injector.isEmpty && _moduleInjector.isEmpty;

  @override
  void addBlocModule<BlocType>(String key, BlocModule blocModule) {
    _moduleInjector[key.toLowerCase()] = blocModule;
  }

  @override
  void deleteBlocGeneral(String key) {
    key = key.toLowerCase();
    _injector[key]?.dispose();
    _injector.remove(key);
  }

  @override
  void deleteBlocModule(String key) {
    key = key.toLowerCase();
    _moduleInjector[key]?.dispose();
    _moduleInjector.remove(key);
  }

  @override
  void dispose() {
    _injector.forEach(
      (String key, BlocGeneral<dynamic> value) {
        value.dispose();
      },
    );
    _moduleInjector.forEach(
      (String key, BlocModule value) {
        value.dispose();
      },
    );
    Future<void>.delayed(const Duration(milliseconds: 999), () {
      _injector.clear();
      _moduleInjector.clear();
    });
  }
}
