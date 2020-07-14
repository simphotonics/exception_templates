# Exception Templates

## Introduction

The library [`exception_templates`][exception_templates] provides parameterized classes based on Dart `Exception` and `Error`.
The classes allow throwing and catching exceptions characterized by their type argument without the need to create library specific implementations.

## Usage

To use this library include [exception_templates] as dependency in your `pubspec.yaml` file. The program below demonstrates how
to throw and catch objects of type `ExceptionOf<T>`.
Colour output can be globally enabled or disabled by setting the field `colorOutput`. 


```Dart
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

```


## Examples

A copy of the program show in the section above can be found in the folder  [example].


## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/simphotonics/exception_templates/issues
[example]: example
[ExceptionOf]:
[exception_templates]: https://pub.dev/packages/exception_templates