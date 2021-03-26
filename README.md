# Exception Templates

[![Dart](https://github.com/simphotonics/exception_templates/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/exception_templates/actions/workflows/dart.yml)


## Introduction

When handling a program exception, the two main concerns are in what *context*
did it occur and what *type* of exception occured.

The library [`exception_templates`][exception_templates] provides
parameterized classes that allow throwing and catching exceptions characterized
by their **type argument**.

Using parameterized exceptions eliminates the need to define library or class specific exceptions
and enables filtering caught exceptions based on their type argument.

To highlight the exception **context** use:
* [`ExceptionOf<T>`][ExceptionOf<T>] and
* [`ErrorOf<T>`][ErrorOf<T>]. In this case, the type argument hints at *where* the exception occured.

To emphasise the exception **type** use:
* [`ExceptionOfType<T>`][ExceptionOfType<T>], where `T extends ExceptionType`,
* [`ErrorOfType<T>`][ErrorOfType<T>] where `T extends ErrorType`.


## Usage

To use this library include [exception_templates] as dependency in your `pubspec.yaml` file.
Colour output can be globally enabled or disabled by setting the static field `colorOutput`
to `ColorOutput.ON` or `ColorOutput.OFF`, respectively.

The program below demonstrates how
to throw and catch objects of type `ErrorOfType<T>` and `ExceptionOfType<T>` where `T` is a generic type.

```Dart

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


```
A typical output produced when running the program above is shown below:
![Console Output](https://github.com/simphotonics/exception_templates/blob/main/images/console_output.svg?sanitize=true)


## Examples

A copy of the program shown in the section above can be found in the folder  [example].


## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/simphotonics/exception_templates/issues

[example]: example

[ExceptionOf<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ExceptionOf-class.html

[ExceptionOfType<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ExceptionOfType-class.html

[ErrorOf<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ErrorOf-class.html

[ErrorOfType<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ErrorOfType-class.html

[exception_templates]: https://pub.dev/packages/exception_templates