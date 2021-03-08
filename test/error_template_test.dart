import 'dart:math';

import 'package:test/test.dart';

import 'package:exception_templates/exception_templates.dart' as et;

// Defining error/exception types:
class FailedToSerializeObject extends et.ErrorType {}

class InvalidDataFound extends et.ExceptionType {}

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
    throw et.ExceptionOf<Complex>(
      message: 'Method angle not implemented',
    );
  }
}

void main() {
  group('ExceptionOf:', () {
    test('<Complex>', () {
      try {
        Complex(0.0, -0.5).angle();
      } on et.ExceptionOf<Complex> catch (e) {
        expect(e.typeArgument, Complex);
      } catch (e) {
        throw Exception('Exception should have been caught already!');
      }
    });
    test('<String>', () {
      try {
        throw et.ExceptionOf<String>();
      } on et.ExceptionOf<String> catch (e) {
        expect(e.typeArgument, String);
      }
    });
    test('Testing colour output', () {
      et.ExceptionOf.colorOutput = et.ColorOutput.OFF;
      expect(
          et.ExceptionOf<Complex>()
              .toString()
              .substring(0, 'ExceptionOf'.length),
          'ExceptionOf',
          reason: 'Message starts with the exception type '
              'if colour output is turned off.');
      et.ExceptionOf.colorOutput = et.ColorOutput.ON;
      expect(
        et.ExceptionOf<Complex>().toString().substring(0, et.RED.length),
        et.RED,
        reason: 'Message start with the colour code '
            'if colour output is turned on',
      );
    });
  });

  group('ExceptionOfType:', () {
    test('<InvalidDataFound>', () {
      try {
        throw et.ExceptionOfType<InvalidDataFound>();
      } on et.ExceptionOfType catch (e) {
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
        throw et.ErrorOf<Complex>(
          message: 'Error',
          invalidState: invalid,
          expectedState: zero,
        );
      } on et.ErrorOf<Complex> catch (e) {
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
        throw et.ErrorOfType<FailedToSerializeObject>(
            message: 'Serialization failed.');
      } on et.ErrorOfType catch (e) {
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
