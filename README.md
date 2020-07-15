# Exception Templates

## Introduction

The library [`exception_templates`][exception_templates] provides
the parameterized classes:
* `ExceptionOf<T>` and  `ErrorOf<T>`,
* `ExceptionOfType<T>` and `ErrorOfType<T>`.

These classes allow throwing and catching exceptions characterized
by their type argument without the need to define library specific exceptions.

When handling errors and exceptions, the two main concerns are *in what context*
did it occur and what *type* of error occured.

In `ExceptionOf<T>` and  `ErrorOf<T>` the type argument hints at the *context* the exception occured in, whereas in `ExceptionOfType<T>` and `ErrorOfType<T>` the generic type `T` hints at the *type* of exception that occured.

## Usage

To use this library include [exception_templates] as dependency in your `pubspec.yaml` file. The program below demonstrates how
to throw and catch objects of type `ExceptionOf<T>` where `T` is a generic type.
Colour output can be globally enabled or disabled by setting the static field `colorOutput`.


```Dart

```


## Examples

A copy of the program show in the section above can be found in the folder  [example].


## Features and bugs

Please file feature requests and bugs at the [issue tracker].

[issue tracker]: https://github.com/simphotonics/exception_templates/issues
[example]: example
[ExceptionOf]:
[exception_templates]: https://pub.dev/packages/exception_templates