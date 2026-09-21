import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:exception_templates/exception_templates.dart';
import 'package:test/test.dart';

class A;

void main() {
  group('Console output color on:', () {
    final message = 'message';
    final expectedState = 'expectedState';
    final invalidState = 'invalidState';
    final errorType = ErrorOf<A>;

    test('no message', () {
      expect(
        ErrorOf<A>().toString(),
        '$errorType'.style(ColorProfile.error) + '()',
      );
    });

    test('only message', () {
      expect(
        ErrorOf<A>(message: message).toString(),
        '\x1B[91mErrorOf<A>\x1B[0m(\n'
        '  \x1B[91mmessage\x1B[0m: "message",\n'
        ')',
      );
    });
    test('message, invalidState, expectedState', () {
      expect(
        ErrorOf<A>(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        ).toString(),
        '\x1B[91mErrorOf<A>\x1B[0m(\n'
        '  \x1B[91mmessage\x1B[0m: "message",\n'
        '  \x1B[93minvalidState\x1B[0m: "invalidState",\n'
        '  \x1B[92mexpectedState\x1B[0m: "expectedState",\n'
        ')',
      );
    });
  });
  group('Console output color off:', () {
    final message = 'message';
    final expectedState = 'expectedState';
    final invalidState = 'invalidState';
    final errorType = ErrorOf<A>;

    test('plain', () {
      Ansi.status = AnsiOutput.disabled;
      expect(ErrorOf<A>().toString(), '$errorType()');
    });

    test('only message', () {
      expect(
        ErrorOf<A>(message: message).toString(),
        'ErrorOf<A>(\n'
        '  message: "message",\n'
        ')',
      );
    });
    test('message, invalidState, expectedState', () {
      expect(
        ErrorOf<A>(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        ).toString(),
        'ErrorOf<A>(\n'
        '  message: "message",\n'
        '  invalidState: "invalidState",\n'
        '  expectedState: "expectedState",\n'
        ')',
      );
    });
  });
}
