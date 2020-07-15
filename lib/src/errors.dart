import 'color_options.dart';
import 'error_type.dart';

/// Parameterized error template.
/// The generic type `T` hints at **where** the error occured.
class ErrorOf<T> extends Error {
  ErrorOf({
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

  /// Type argument of the error class.
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

/// Parameterized error template.
/// The generic type `T` indicates what **type** of error occured.
/// Usage:
/// ```Dart
/// // Creating a new [ErrorType].
/// class SerializationFailed extends ErrorType{}
///
/// // Throwing an error of type [ErrorType].
/// throw ErrorOfType<SerializationFailed>;
/// ```
class ErrorOfType<T extends ErrorType> extends ErrorOf<T> {
  ErrorOfType({
    Object message,
    Object invalidState,
    Object expectedState,
  }) : super(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        );
}
