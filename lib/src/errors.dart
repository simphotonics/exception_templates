import 'color_options.dart';

class ErrorOf<T> extends Error {
  ErrorOf({
    this.message,
    this.invalidState,
    this.expectedState,
    this.showStackTrace = false,
  });

  /// Message added when the error is thrown.
  final Object message;

  /// Generic object conveying information about the invalid state.
  final Object invalidState;

  /// Generic object conveying information about an expected state.
  final Object expectedState;

  /// Whether to add the stack trace to the printed error message.
  final bool showStackTrace;

  /// Whether to enable color output.
  static ColorOutput colorOutput = ColorOutput.ON;

  /// Type argument of the error class.
  Type get typeArgument => T;

  @override
  String toString() {
    final msg = (message == null) ? '' : Error.safeToString(message) + '\n';

    final expected = (expectedState == null)
        ? ''
        : ' Expected: ' + Error.safeToString(expectedState) + '\n';

    final found = (invalidState == null)
        ? ''
        : ' Found: ' + Error.safeToString(invalidState) + '\n';

    final red = (colorOutput == ColorOutput.ON) ? RED : '';
    final reset = (colorOutput == ColorOutput.ON) ? RESET : '';
    final yellow = (colorOutput == ColorOutput.ON) ? YELLOW : '';

    return '$red${this.runtimeType}: $reset' +
        msg +
        found +
        expected +
        '\n' +
        '${yellow}StackTrace: $reset\n' +
        super.stackTrace.toString();
  }
}
