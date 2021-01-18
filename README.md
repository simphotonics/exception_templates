# Exception Templates

[![Build Status](https://travis-ci.com/simphotonics/exception_templates.svg?branch=master)](https://travis-ci.com/simphotonics/exception_templates)


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

The program below demonstrates how
to throw and catch objects of type `ExceptionOf<T>` where `T` is a generic type.
Colour output can be globally enabled or disabled by setting the static field `colorOutput`
to `ColorOutput.ON` or `ColorOutput.OFF`, respectively,


```Dart
import 'package:exception_templates/exception_templates.dart';

// Defining error/exception types:
class FailedToSerializeObject extends ErrorType{}
class InvalidDataFound extends ExceptionType{}

// Test class A.
class A {
  Object data;
  // Throwing a parameterized exception.
  // The type argument <A> highlights where the exception occurred.
  void setUp() {
    data = List<int>.filled(3, 37);
    throw ExceptionOf<A>(
        message: 'Set up failed.',
        expectedState: 'A complete set of adapters.',
        invalidState: 'Adapter x078 is missing.');
  }

  // Throwing a parameterized error.
  // The type argument <FailedToSerializeObject> highlights
  // what kind of error occurred.
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

// Executable ------------------------------------------
main(List<String> args) {
  // Catching an ExceptionOf<A>.
  try {
    a.setUp();
  } on ExceptionOf<A> catch (e) {
    print(e);
  }

  // Turning off colour output globally.
  ExceptionOf.colorOutput = ColorOutput.OFF;

  // Catching an ExceptionOfType<InvalidDataFound>.
  // Colour output is switched off.
  try {
    throw ExceptionOfType<InvalidDataFound>(
        message: 'Something went wrong with class B.',
        expectedState: 'data > 0.',
        invalidState: 'data == null');
  } on ExceptionOfType<InvalidDataFound> catch (e) {
    print('// Switching of colour output.');
    print(e);
  } on ExceptionOf<A> catch (e) {
    print('Should not reach here! $e');
  }

  // Throwing and catching an ErrorOfType<FailedToSerializeObject>.
  try {
    a.tearDown();
  } on ErrorOfType<FailedToSerializeObject> catch (e) {
    print('${CYAN}DEMO only, errors should never be caught!');
    print(e);
  }
}

```
A typical output produced when running the program above is shown below:
![Console Output](https://raw.githubusercontent.com/simphotonics/exception_templates/master/images/console_output.svg?sanitize=true)


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