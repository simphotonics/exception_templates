import 'color_options.dart';
import 'exception_type.dart';

/// Parameterized exception class.
/// The type argument hints at **where** the exception occured.
class ExceptionOf<T> implements Exception {
  ExceptionOf({
    this.message,
    this.invalidState,
    this.expectedState,
  });

  /// Message added when the error is thrown.
  final Object message;

  /// Generic object conveying information about the invalid state.
  final Object invalidState;

  /// Generic object conveying information about an expected state.
  final Object expectedState;

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.ON;

  /// Type argument of the exception class.
  Type get typeArgument => T;

  @override
  String toString() => toColorString(
        colorOutput: colorOutput,
        message: message,
        expectedState: expectedState,
        invalidState: invalidState,
        errorType: this.runtimeType,
      );
}

/// Parameterized exception template.
/// The generic type `T` hints at **what type** of error occured.
/// Usage:
/// ```Dart
/// // Defining an exception type.
/// class DatabaseNotInitialized extends ExceptionType{}
///
/// // Throwing an exception of the newly defined type.
/// throw ExceptionOfType<DatabaseNotInitialized>
/// ```
class ExceptionOfType<T extends ExceptionType> extends ExceptionOf<T> {
  ExceptionOfType({
    Object message,
    Object invalidState,
    Object expectedState,
  }) : super(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        );
}
