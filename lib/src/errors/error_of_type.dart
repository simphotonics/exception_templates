import '../error_types/error_type.dart';
import '../utils/color_options.dart';

/// Parameterized error template.
///
/// The generic type `T` indicates what **type** of error occured.
/// Usage:
/// ```Dart
/// // Creating a new [ErrorType].
/// class SerializationFailed extends ErrorType{}
///
/// // Throwing an error of type [ErrorType].
/// throw ErrorOfType<SerializationFailed>;
/// ```
class ErrorOfType<T extends ErrorType> extends Error {
  ErrorOfType({
    this.message = '',
    this.invalidState = '',
    this.expectedState = '',
  });

  /// Optional message added when the error is thrown.
  final Object message;

  /// Generic object conveying information about the invalid state.
  final Object invalidState;

  /// Generic object conveying information about an expected state.
  final Object expectedState;

  /// Set to `ColorOutput.ON` to enable color output to terminal.
  static ColorOutput colorOutput = ColorOutput.on;

  /// Type argument of the error class.
  Type get typeArgument => T;

  @override
  String toString() => toColorString(
        colorOutput: colorOutput,
        message: message,
        expectedState: expectedState,
        invalidState: invalidState,
        errorType: runtimeType,
      );
}
