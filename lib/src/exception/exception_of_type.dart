import '../mixin/color_string.dart';
import 'exception_type.dart';
import '../utils/color_option.dart';

/// Parameterized exception class.
/// The generic type [T] indicates what *type* of error occured.
/// ```Dart
/// // Usage:
/// import 'package:exception_templates/exception_templates.dart';
///
/// // Defining an exception type.
/// class DatabaseNotInitialized extends ExceptionType{}
///
/// // Throwing an exception of the newly defined type.
/// throw ExceptionOfType<DatabaseNotInitialized>;
/// ```
class ExceptionOfType<T extends ExceptionType>({
  /// Message added when the error is thrown.
  final Object message = '',

  /// Object conveying information about the invalid state.
  final Object invalidState = '',

  /// Object conveying information about an expected state.
  final Object expectedState = '',
}) with ColorString implements Exception {
  /// Type argument of the exception class.
  Type get typeArgument => T;

  @override
  String toString() => toColorString(
    message: message,
    expectedState: expectedState,
    invalidState: invalidState,
  );

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.on;
}
