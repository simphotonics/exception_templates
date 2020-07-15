# Exception Templates

## Introduction

The library [`exception_templates`][exception_templates] provides
parameterized classes that allow throwing and catching exceptions characterized
by their type argument without the need to define library specific exceptions.

When handling a program exceptions, the two main concerns are in what *context*
did it occur and what *type* of exception occured.

To highlight the exception *context* one may use:
* `ExceptionOf<T>` and
* `ErrorOf<T>`. In this case, the type argument hints at *where* the exception occured.

To emphasise the exception *type* use the classes:
* `ExceptionOfType<T>` and
* `ErrorOfType<T>`. Here, the generic type `T` hints at the *type* of exception that occured.


## Usage

To use this library include [exception_templates] as dependency in your `pubspec.yaml` file. The program below demonstrates how
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

  // Catching an ExceptionOf<B>. Colour output switched off.
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

  // Throwing and catching an ErrorOf<A>.
  try {
    a.tearDown();
  } on ErrorOf<A> catch (e) {
    print('${CYAN}DEMO only, errors should never be caught!');
    print(e);
  }
}

```


## Examples

A copy of the program show in the section above can be found in the folder  [example].


## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/simphotonics/exception_templates/issues
[example]: example
[ExceptionOf]:
[exception_templates]: https://pub.dev/packages/exception_templates