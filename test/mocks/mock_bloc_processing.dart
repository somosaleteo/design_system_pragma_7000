import 'dart:async';

import 'package:aleteo_arquetipo/blocs/bloc_processing.dart';

class MockBlocProcessing extends BlocProcessing {
  @override
  void loadingWithDelay(String msg, int milliseconds) {}

  @override
  Future<void> loadingWithFutureFunction(
    String msg,
    Future<String?> function,
  ) async {}
}

class MockBlocProcessing2 extends MockBlocProcessing {
  final StreamController<String> _processingController =
      StreamController<String>.broadcast();

  @override
  Stream<String> get procesingStream => _processingController.stream;
  String _msg = '';

  @override
  bool get isProcessing => _msg.isNotEmpty;

  void emitProcessingEvent(String message) {
    _msg = message;
    _processingController.add(message);
  }

  void close() {
    _processingController.close();
  }
}
