// To run this program go to the folder 'error_template/example'
// in your terminal and type
//
// # dart bin/example.dart
//
// followed by enter.
import 'package:exception_templates/exception_templates.dart';

// Defining error/exception types:
class FailedToSerializeObject extends ErrorType{}
class InvalidDataFound extends ExceptionType{}

// Test class A.
class A {
  Object data;
  // Method that throws parameterized exception.
  void setUp() {
    data = List<int>.filled(3, 37);
    throw ExceptionOf<A>(
        message: 'Set up failed.',
        expectedState: 'A complete set of adapters.',
        invalidState: 'Adapter x078 is missing.');
  }

  // Method that throws parameterized error.
  void tearDown() {
    throw ErrorOfType<FailedToSerializeObject>(
        message: 'An error occured in tearDown().',
        expectedState: 'All objects are serialized and stored.',
        invalidState: 'Failed to serialize object $data.');
  }
}

// Test class B.
class B {
  B(this.data);
  final int data;
}

final a = A();

main(List<String> args) {
  // Catching an ExceptionOf<A>.
  try {
    a.setUp();
  } on ExceptionOf<A> catch (e) {
    print(e);
  }

  // Turning of colour output globally.
  ExceptionOf.colorOutput = ColorOutput.OFF;

  // Catching an ExceptionOfType<InvalidDataFound>. Colour output switched off.
  try {
    throw ExceptionOfType<InvalidDataFound>(
        message: 'Something went wrong with class B.',
        expectedState: 'data > 0.',
        invalidState: 'data == null');
  } on ExceptionOfType catch (e) {
    print('// Switching of colour output.');
    print(e);
  } on ExceptionOf<A> catch (e) {
    print('Should not reach here! $e');
  }

  // Throwing and catching an ErrorOf<FailedToSerializeObject>.
  try {
    a.tearDown();
  } on ErrorOfType<FailedToSerializeObject> catch (e) {
    print('${CYAN}DEMO only, errors should never be caught!');
    print(e);
  }
}
