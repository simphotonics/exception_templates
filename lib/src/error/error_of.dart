import '../utils/color_option.dart';

/// Parameterized error class.
/// The generic type [T] indicates in which *context* the error occured.
class ErrorOf<T>({
  /// Message added when the error is thrown.
  final Object message = '',

  /// Object conveying information about the invalid state.
  final Object invalidState = '',

  /// Object conveying information about an expected state.
  final Object expectedState = '',
}) extends Error {
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

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.on;
}
