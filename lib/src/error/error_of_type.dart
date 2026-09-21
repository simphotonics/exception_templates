import 'package:exception_templates/src/mixin/color_string.dart';

import 'error_type.dart';
import '../utils/color_option.dart';

/// Parameterized error class, where the generic
/// type [T] indicates what *type* of error occured.
/// ```Dart
/// // Usage:
/// /// Creating a new [ErrorType].
/// class SerializationFailed extends ErrorType;
///
/// /// Throwing an error of type [ErrorType].
/// throw ErrorOfType<SerializationFailed>;
/// ```
class ErrorOfType<T extends ErrorType>({
  /// Optional message added when the error is thrown.
  final Object message = '',

  /// Object conveying information about an invalid state.
  final Object invalidState = '',

  /// Object conveying information about an expected state.
  final Object expectedState = '',
}) extends Error with ColorString {
  /// The type argument of the error class.
  Type get typeArgument => T;

  @override
  String toString() => toColorString(
    message: message,
    expectedState: expectedState,
    invalidState: invalidState,
  );

  /// Set to `ColorOutput.ON` to enable color output to terminal.
  static ColorOutput colorOutput = ColorOutput.on;
}
