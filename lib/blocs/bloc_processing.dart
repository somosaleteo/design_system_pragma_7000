import '../entities/entity_bloc.dart';

class BlocProcessing extends BlocModule {
  static const String name = 'procesingName';
  final BlocGeneral<String> _blocProcessing = BlocGeneral<String>('');

  String get procesingMsg => _blocProcessing.value;
  bool get isProcessing => procesingMsg.isNotEmpty;

  Stream<String> get procesingStream => _blocProcessing.stream;

  set procesingMsg(String msg) {
    _blocProcessing.value = msg;
  }

  void loadingWithDelay(String msg, int milliseconds) {
    procesingMsg = msg;
    Future<void>.delayed(Duration(milliseconds: milliseconds), () {
      procesingMsg = '';
    });
  }

  Future<void> loadingWithFutureFunction(
    String msg,
    Future<String?> function,
  ) async {
    procesingMsg = msg;
    await function;
    procesingMsg = '';
  }

  @override
  void dispose() {
    _blocProcessing.dispose();
  }
}
