// To run this program navigate to the root of your local copy of the
// package exception_templates and use
//
// # dart example/bin/example.dart
//
// followed by enter.
import 'package:exception_templates/exception_templates.dart';

// Defining error types:
class LengthMismatch extends ErrorType {}

// Defining exception types:
class EmptyUserInput extends ExceptionType {}

extension Subtraction on List<num> {
  /// Subtracts two numerical lists of same length.
  List<num> operator -(List<num> other) {
    if (length != other.length) {
      throw ErrorOfType<LengthMismatch>(
          message: 'Could not calculate: $this - $other.',
          invalidState: 'Length of $this does not match length of $other.',
          expectedState: 'Two operands with the same length.');
    }
    return List<num>.generate(length, (i) => this[i] - other[i]);
  }
}

void main(List<String> args) {
  final a = [1, 2];
  final b = [3, 4];
  final c = [...b, 5];

  // Catching an ErrorOfType<LenghtMismatch>.
  // Demo only! Errors should not be caught, while exceptions should be caught.
  try {
    print('b - a = ${b - a}');
    print('c - b = ${c - b}');
  } on ErrorOfType<LengthMismatch> catch (e) {
    print(e);
  }

  // Catching an ExceptionOfType<EmptyUserFeedback>.
  var userFeedback = '';
  try {
    throw ExceptionOfType<EmptyUserInput>(
      message: 'Could not process user feedback.',
      expectedState: 'A non-empty String.',
    );
  } on ExceptionOfType<EmptyUserInput> catch (e) {
    userFeedback = '${e.message} User did not leave a message.';
    print('Feedback: $userFeedback\n');
  }
}
