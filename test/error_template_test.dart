import 'dart:math';

import 'package:test/test.dart';

import 'package:exception_templates/exception_templates.dart';

// Defining error/exception types:
class FailedToSerializeObject extends ErrorType {}

class InvalidDataFound extends ExceptionType {}

class Complex<T extends num> {
  Complex(this.real, this.imag);
  T real;
  T imag;
}

extension Constants<T extends num> on Complex<T> {
  Complex get i => Complex(0, 1);
  num get r {
    return sqrt(real * real + imag * imag);
  }

  double angle() {
    throw ExceptionOf<Complex>(
      message: 'Method angle not implemented',
    );
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
    test('Testing colour output', () {
      ExceptionOf.colorOutput = ColorOutput.OFF;
      expect(
          ExceptionOf<Complex>().toString().substring(0, 'ExceptionOf'.length),
          'ExceptionOf',
          reason: 'Message starts with the exception type '
              'if colour output is turned off.');
      ExceptionOf.colorOutput = ColorOutput.ON;
      expect(
        ExceptionOf<Complex>().toString().substring(0, RED.length),
        RED,
        reason: 'Message start with the colour code '
            'if colour output is turned on',
      );
    });
  });

  group('ExceptionOfType:', () {
    test('<InvalidDataFound>', () {
      try {
        throw ExceptionOfType<InvalidDataFound>();
      } on ExceptionOfType catch (e) {
        expect(e.typeArgument, InvalidDataFound);
        expect(e.message, '');
        expect(e.invalidState, '');
        expect(e.expectedState, '');
      } catch (e) {
        throw Exception('Exception should have been caught already!');
      }
    });
  });
  group('ErrorOf:', () {
    test('<Complex>', () {
      final zero = Complex(0, 0);
      final invalid = Complex(0, 0.0);
      try {
        throw ErrorOf<Complex>(
          message: 'Error',
          invalidState: invalid,
          expectedState: zero,
        );
      } on ErrorOf<Complex> catch (e) {
        expect(e.typeArgument, Complex);
        expect(e.message, 'Error');
        expect(e.invalidState, invalid);
        expect(e.expectedState, zero);
      } catch (e) {
        throw Exception('Error should have been caught already!');
      }
    });
  });

  group('ErrorOfType:', () {
    test('<FailedToSerializeObject>', () {
      try {
        throw ErrorOfType<FailedToSerializeObject>(
            message: 'Serialization failed.');
      } on ErrorOfType catch (e) {
        expect(e.typeArgument, FailedToSerializeObject);
        expect(e.message, 'Serialization failed.');
        expect(e.invalidState, '');
        expect(e.expectedState, '');
      } catch (e) {
        throw Exception('Error should have been caught already!');
      }
    });
  });
}
