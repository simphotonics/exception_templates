import '../exception_types/exception_type.dart';
import '../utils/color_options.dart';

/// Parameterized exception template.
/// The generic type `T` indicates what **type** of error occured.
/// Usage:
/// ```Dart
/// import 'package:exception_templates/exception_templates.dart';
///
/// // Defining an exception type.
/// class DatabaseNotInitialized extends ExceptionType{}
///
/// // Throwing an exception of the newly defined type.
/// throw ExceptionOfType<DatabaseNotInitialized>;
/// ```
class ExceptionOfType<T extends ExceptionType> implements Exception {
  ExceptionOfType({
    this.message = '',
    this.invalidState = '',
    this.expectedState = '',
  });

  /// Message added when the error is thrown.
  final Object message;

  /// Generic object conveying information about the invalid state.
  final Object invalidState;

  /// Generic object conveying information about an expected state.
  final Object expectedState;

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.on;

  /// Type argument of the exception class.
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
