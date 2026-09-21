/// Enables/disables terminal colour output.
enum ColorOutput { on, off }

/// Represents an Ansi escape code.
enum Ansi(
  /// The String code representing the colour.
  final String code,
) {
  red('\u001B[31m'),
  green('\u001B[32m'),
  blue('\u001B[34m'),
  cyan('\u001B[36m'),
  yellow('\u001B[33m'),
  reset('\u001B[0m'),
}

/// Transforms error/exception messages to a colorized output string.
String toColorString1({
  Object message = '',
  Object expectedState = '',
  Object invalidState = '',
  ColorOutput colorOutput = ColorOutput.on,
  required Type errorType,
}) {
  final green = (colorOutput == ColorOutput.on) ? Ansi.green.code : '';
  final red = (colorOutput == ColorOutput.on) ? Ansi.red.code : '';
  final reset = (colorOutput == ColorOutput.on) ? Ansi.reset.code : '';
  final yellow = (colorOutput == ColorOutput.on) ? Ansi.yellow.code : '';

  final msg = message.toString().isEmpty
      ? ''
      : '$red message: $reset ${Error.safeToString(message)}\n';

  final expected = expectedState.toString().isEmpty
      ? ''
      : ' $green expected state: $reset${Error.safeToString(expectedState)}\n';

  final invalid = invalidState.toString().isEmpty
      ? ''
      : ' $yellow invalid state: $reset${Error.safeToString(invalidState)}\n';

  return '$red$errorType$reset(\n $msg$invalid$expected)';
}
