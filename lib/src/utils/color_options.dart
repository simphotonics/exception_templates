library color_options;

enum ColorOutput { ON, OFF }

/// Ansi color modifier: Reset to default.
const String RESET = '\u001B[0m';

/// Ansi color modifier.
const String BLUE = '\u001B[34m';

/// Ansi color modifier.
const String CYAN = '\u001B[36m';

/// Ansi color modifier.
const String GREEN = '\u001B[32m';

/// Ansi color modifier.
const String RED = '\u001B[31m';

/// Ansi color modifier.
const String YELLOW = '\u001B[33m';

/// Transforms error/exception messages to an output string.
String toColorString(
    {Object message = '',
    Object expectedState = '',
    Object invalidState = '',
    ColorOutput colorOutput = ColorOutput.ON,
    required Type errorType}) {
  final red = (colorOutput == ColorOutput.ON) ? RED : '';
  final reset = (colorOutput == ColorOutput.ON) ? RESET : '';
  final green = (colorOutput == ColorOutput.ON) ? GREEN : '';
  final yellow = (colorOutput == ColorOutput.ON) ? YELLOW : '';

  final msg = message.toString().isEmpty
      ? ''
      : Error.safeToString(message) + reset + '\n';

  final expected = expectedState.toString().isEmpty
      ? ''
      : ' $green Expected state: $reset' +
          Error.safeToString(expectedState) +
          '\n';

  final invalid = invalidState.toString().isEmpty
      ? ''
      : ' $yellow Invalid state: $reset' +
          Error.safeToString(invalidState) +
          '\n';

  return '$red$errorType: ' + msg + invalid + expected + '\n';
}
