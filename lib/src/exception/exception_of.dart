import '../utils/color_option.dart';

/// Parameterized exception class.
/// The type argument indicates in which context the exception occured.
class ExceptionOf<T>({
  /// Message added when the error is thrown.
  final Object message = '',

  /// Object conveying information about the invalid state.
  final Object invalidState = '',

  /// Object conveying information about an expected state.
  final Object expectedState = '',
}) implements Exception {
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

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.on;
}
