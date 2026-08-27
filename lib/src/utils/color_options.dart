enum ColorOutput { on, off }

/// Represents and Ansi colour.
enum AnsiColor(
  /// The String code representing the colour.
  final String code,
) {
  red('\u001B[31m'),
  green('\u001B[32m'),
  blue('\u001B[34m'),
  cyan('\u001B[36m'),
  yellow('\u001B[33m'),
  reset('\u001B[0m');
}

/// Transforms error/exception messages to a colorized output string.
String toColorString({
  Object message = '',
  Object expectedState = '',
  Object invalidState = '',
  ColorOutput colorOutput = ColorOutput.on,
  required Type errorType,
}) {
  final red = (colorOutput == ColorOutput.on) ? AnsiColor.red.code : '';
  final reset = (colorOutput == ColorOutput.on) ? AnsiColor.reset.code : '';
  final green = (colorOutput == ColorOutput.on) ? AnsiColor.green.code : '';
  final yellow = (colorOutput == ColorOutput.on) ? AnsiColor.yellow.code : '';

  final msg = message.toString().isEmpty
      ? ''
      : '$red message: $reset ${Error.safeToString(message)}$reset\n';

  final expected = expectedState.toString().isEmpty
      ? ''
      : ' $green expected state: $reset${Error.safeToString(expectedState)}\n';

  final invalid = invalidState.toString().isEmpty
      ? ''
      : ' $yellow invalid state: $reset${Error.safeToString(invalidState)}\n';

  return '$red$errorType$reset(\n $msg$invalid$expected)';
}
