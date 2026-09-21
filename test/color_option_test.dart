import 'package:ansi_modifier/ansi_modifier.dart';
import 'package:exception_templates/exception_templates.dart';
import 'package:exception_templates/src/utils/color_profile.dart';
import 'package:test/test.dart';

class A;

void main() {
  group('Console output:', () {
    final message = 'message';
    final expectedState = 'expectedState';
    final invalidState = 'invalidState';
    final errorType = ErrorOf<A>;

    test('color on', () {
      expect(
        ErrorOf<A>(),
        '$errorType'.style(ColorProfile.error),
      );
      expect(
        toColorString(
          errorType: errorType,
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        ),
        '\x1B[31mErrorOf<A>\x1B[0m(\n'
        ' \x1B[31m message: \x1B[0m "message"\n'
        ' \x1B[33m invalid state: \x1B[0m"invalidState"\n'
        ' \x1B[32m expected state: \x1B[0m"expectedState"\n'
        ')',
      );
    });
    test('color off', () {
      expect(
        toColorString(errorType: errorType, colorOutput: ColorOutput.off),
        '$errorType(\n )',
      );
      expect(
        toColorString(
          errorType: errorType,
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
          colorOutput: ColorOutput.off,
        ),
        'ErrorOf<A>(\n'
        '  message:  "message"\n'
        '  invalid state: "invalidState"\n'
        '  expected state: "expectedState"\n'
        ')',
      );
    });
  });
}
