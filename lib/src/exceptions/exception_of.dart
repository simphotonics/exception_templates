import '../utils/color_options.dart';

/// Parameterized exception class.
/// The type argument indicates in which context the exception occured.
class ExceptionOf<T> implements Exception {
  ExceptionOf({
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
  static ColorOutput colorOutput = ColorOutput.ON;

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
