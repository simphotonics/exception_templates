# Exception Templates

[![Dart](https://github.com/simphotonics/exception_templates/actions/workflows/dart.yml/badge.svg)](https://github.com/simphotonics/exception_templates/actions/workflows/dart.yml)


## Introduction

While it is possible to throw any object in Dart, production code typically contains
custom error and exception classes that
extend [`Error`][Error] and implement [`Exception`][Exception].

An alternative approach consists in using exceptions with parameterized type.
The library [`exception_templates`][exception_templates] provides
parameterized classes that allow throwing errors/exceptions and filtering caught exceptions characterized
by their **type argument**.

In the following sections the term *exception* stands for exception/error
with the understanding that in general exceptions should be handled while errors should lead to the
termination of the program.



## Usage
To use this library include [exception_templates] as dependency in your `pubspec.yaml` file.

### Highlighting the Exception Context
To highlight the **context** in which the exception/error occured use the classes
[`ExceptionOf<T>`][ExceptionOf<T>] and [`ErrorOf<T>`][ErrorOf<T>].
Hereby, the type argument indicates that the exception occured within a method of the class `T`.
In this case, there is no need to define class specific exceptions. See example below.

```Dart
// To run this program navigate to the root of your local copy of the
// package exception_templates and use
//
// # dart example/bin/exception_example.dart
//
// followed by enter.
import 'package:exception_templates/exception_templates.dart';

/// Returns the variable t afer some time. Used to simulate a database or
/// network connection.
Future<T> later<T>(T t) async {
  return await Future.delayed(Duration(milliseconds: 200), () => t);
}

/// Sample class
class UserForm {
  const UserForm(this.userName);

  final String userName;

  /// Simulates fetching user feedback from a database or network connection.
  Future<String> fetchFeedback() async {
    final feedback = await later('');
    if (feedback.isEmpty) {
      throw ExceptionOf<UserForm>(
        message: 'Could not process $userName\'s feedback.',
        invalidState: 'String found: $feedback',
        expectedState: 'A non-empty String.',
      );
    }
    return feedback;
  }
}

void main(List<String> args) async {
  final userForm = UserForm('Daniel');
  try {
    final userFeedback = await userForm.fetchFeedback();
    print(userFeedback);
  } on ExceptionOf<UserForm> catch (e) {
    final userFeedback = e.message;
    print('Feedback: $userFeedback\n');
  }
}
```

### Highlighting the Exception Type
To emphasise the exception **type** use:
* [`ExceptionOfType<T>`][ExceptionOfType<T>], where `T extends ExceptionType`,
* [`ErrorOfType<T>`][ErrorOfType<T>] where `T extends ErrorType`.

The program below demonstrates how
to throw an error of type `ErrorOfType<LengthMismatch>`.

```Dart
// To run this program navigate to the root of your local copy of the
// package exception_templates and use
//
// # dart example/bin/error_example.dart
//
// followed by enter.
import 'package:exception_templates/exception_templates.dart';

// Defining error types:
class LengthMismatch extends ErrorType {}

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
  print('b - a = ${b - a}');
  print('c - b = ${c - b}');
}

```
A typical output produced when running the program above is displayed below (the stack trace is not shown):
![Console Output](https://github.com/simphotonics/exception_templates/raw/main/images/console_output.svg?sanitize=true)


Note: Colour output can be globally enabled or disabled by setting
the static variable `colorOutput`
to `ColorOutput.on` or `ColorOutput.off`, respectively:
```Dart
import 'package:exception_templates/exception_templates.dart';

/// Turning off color output, e.g. if the terminal does not support it.
void main(List<String> args) {
  ErrorOfType.colorOutput = ColorOutput.off;
  ExceptionOfType.colorOutput = ColorOutput.off;
}
```


## Utility Functions

The library includes the utility functions [`validateIdentifier`][validateIdentifier] and [`isValidIdentifier`][isValidIdentifier].

The function [`validateIdentifier`][validateIdentifier] throws an error of
type `ErrorOfType<InvalidIdentifier>`
if the String argument is a Dart keyword or an invalid Dart variable or function name.

## Examples

A copy of the programs shown in the section above can be found in the folder  [example].


## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/simphotonics/exception_templates/issues

[example]: example

[Error]: https://api.dart.dev/stable/dart-core/Error-class.html

[Exception]: https://api.dart.dev/stable/dart-core/Exception-class.html

[ExceptionOf<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ExceptionOf-class.html

[ExceptionOfType<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ExceptionOfType-class.html

[ErrorOf<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ErrorOf-class.html

[ErrorOfType<T>]: https://pub.dev/documentation/exception_templates/latest/exception_templates/ErrorOfType-class.html

[exception_templates]: https://pub.dev/packages/exception_templates

[isValidIdentifier]: https://pub.dev/documentation/exception_templates/latest/exception_templates/isValidIdentifier.html

[validateIdentifier]: https://pub.dev/documentation/exception_templates/latest/exception_templates/validateIdentifier.html
