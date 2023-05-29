import 'package:aleteo_arquetipo/blocs/bloc_processing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BlocProcessing', () {
    late BlocProcessing bloc;

    setUp(() {
      bloc = BlocProcessing();
    });

    test('loadingWithDelay sets processingMsg and clears it after delay',
        () async {
      const String msg = 'Loading...';
      const Duration delay = Duration(seconds: 1);

      // Expect initial processingMsg to be empty
      expect(bloc.procesingMsg, '');

      // Start loading with delay
      bloc.loadingWithDelay(msg, delay.inMilliseconds);

      // Expect processingMsg to be set
      expect(bloc.procesingMsg, msg);

      // Wait for delay to finish
      await Future<void>.delayed(delay);

      // Expect processingMsg to be cleared
      expect(bloc.procesingMsg, '');
    });

    test(
        'loadingWithFutureFunction sets processingMsg and clears it after future completes',
        () async {
      const String msg = 'Loading...';

      // Create a future that completes after a delay
      final Future<String> future = Future<String>.delayed(
        const Duration(milliseconds: 500),
        () => 'Result',
      );

      // Expect initial processingMsg to be empty
      expect(bloc.procesingMsg, '');

      // Start loading with future function
      bloc.loadingWithFutureFunction(msg, future);

      // Expect processingMsg to be set
      expect(bloc.procesingMsg, msg);

      // Wait for future to complete
      await future;

      // Expect processingMsg to be cleared
      expect(bloc.procesingMsg, '');
    });

    test('procesingStream emits values when processingMsg is set', () async {
      const String msg1 = 'Loading 1...';
      const String msg2 = 'Loading 2...';

      final Stream<String> stream = bloc.procesingStream;

      // Expect no values emitted initially
      expect(bloc.procesingMsg.isEmpty, true);

      // Set processingMsg and expect value emitted
      bloc.procesingMsg = msg1;
      expectLater(stream, emitsInOrder(<String>['', msg1]));
      // expect(await stream.first, msg1);

      // Set processingMsg again and expect new value emitted
      bloc.procesingMsg = msg2;
      expectLater(stream, emitsInOrder(<String>['', msg1, msg2]));
      // expect(await stream.first, msg2);
    });

    tearDown(() {
      bloc.dispose();
    });
  });
}
