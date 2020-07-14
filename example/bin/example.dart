// To run this program go to the folder 'error_template/example'
// in your terminal and type
//
// # dart bin/example.dart
//
// followed by enter.

import 'package:error_template/error_template.dart';

// Test class A.
class A {
  // Method that throws parameterized exception.
  void setUp() {
    throw ExceptionOf<A>(
        message: 'Set up failed.',
        expectedState: 'A complete set of adapters.',
        invalidState: 'Adapter x078 is missing.');
  }

  // Method that throws parameterized error.
  void tearDown() {
    throw ErrorOf<A>(
      message: 'An error occured in tearDown().',
    );
  }
}

// Test class B.
class B {}

main(List<String> args) {
  // Catching an ExceptionOf<A>.
  try {
    A().setUp();
  } on ExceptionOf<A> catch (e) {
    print(e);
  }

  // Turning of colour output globally.
  ExceptionOf.colorOutput = ColorOutput.OFF;

  // Catching an ExceptionOf<B>. Colour output switched off.
  try {
    throw ExceptionOf<B>(
      message: 'Something wrong with class B.',
      expectedState: 'Colour output should be switched off.',
    );
  } on ExceptionOf<B> catch (e) {
    print(e);
  } on ExceptionOf<A> catch (e) {
    print('Should not reach here! $e');
  }

  // Throwing an ErrorOf<A>.
  A().tearDown();
}
