import 'dart:math';

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
    throw ExceptionOf<Complex>(message: 'Method angle not implemented.');
  }
}

void main() {
  group('ErrorOf:', () {
    test('<Complex>', () {
      final i = Complex(0, 1);
      try {
        i.angle();
      } on ExceptionOf<Complex> catch (e) {
        expect(e.typeArgument, Complex);
        expect(e.message, 'Method angle not implemented.');
        expect(e.invalidState, '');
        expect(e.expectedState, '');
      } catch (e) {
        throw StateError('Error should have been caught already!');
      }
    });
  });
}
