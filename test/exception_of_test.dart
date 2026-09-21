import 'dart:math';

import 'package:ansi_modifier/ansi_modifier.dart' show Ansi, AnsiOutput;
import 'package:test/test.dart';

import 'package:exception_templates/exception_templates.dart';

class Complex<T extends num> {
  new(this.real, this.imag);
  T real;
  T imag;
}

extension Constants<T extends num> on Complex<T> {
  Complex get i => Complex(0, 1);
  num get r {
    return sqrt(real * real + imag * imag);
  }

  double angle() {
    throw ExceptionOf<Complex>(message: 'Method angle not implemented');
  }
}

void main() {
  group('ExceptionOf:', () {
    test('<Complex>', () {
      try {
        Complex(0.0, -0.5).angle();
      } on ExceptionOf<Complex> catch (e) {
        expect(e.typeArgument, Complex);
      } catch (e) {
        throw Exception('Exception should have been caught already!');
      }
    });
    test('<String>', () {
      try {
        throw ExceptionOf<String>();
      } on ExceptionOf<String> catch (e) {
        expect(e.typeArgument, String);
      }
    });
    test('AnsiOutput.disabled', () {
      Ansi.status = AnsiOutput.disabled;
      expect(
        ExceptionOf<Complex>().toString().substring(0, 'ExceptionOf'.length),
        'ExceptionOf',
        reason:
            'Message starts with the exception type '
            'if colour output is turned off.',
      );
    });

    test('AnsiOutput.enabled', () {
      Ansi.status = AnsiOutput.enabled;
      expect(
        ExceptionOf<Complex>().toString().substring(
          0,
          ColorProfile.error.code.length,
        ),
        ColorProfile.error.code,
        reason:
            'Message start with the colour code '
            'if colour output is turned on',
      );
    });
  });
}
