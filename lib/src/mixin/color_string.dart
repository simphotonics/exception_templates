import '../color/color_profile.dart';

import 'package:ansi_modifier/ansi_modifier.dart';

const indent = '\n  ';

mixin ColorString {
  String toColorString({
    Object message = '',
    Object expectedState = '',
    Object invalidState = '',
  }) {
    final b = StringBuffer();
    bool isEmpty = true;
    b.write(runtimeType.toString().style(ColorProfile.error) + '(');

    final safeMessage = Error.safeToString(message);

    if (safeMessage.substring(1, safeMessage.length - 1).isNotEmpty) {
      b.write(
        indent + 'message'.style(ColorProfile.error) + ': ' + safeMessage + ',',
      );
      isEmpty = false;
    }

    final safeInvalidState = Error.safeToString(invalidState);

    if (safeInvalidState.substring(1, safeInvalidState.length - 1).isNotEmpty) {
      b.write(
        indent +
            'invalidState'.style(ColorProfile.invalid) +
            ': ' +
            safeInvalidState +
            ',',
      );
      isEmpty = false;
    }

    final safeExpectedState = Error.safeToString(expectedState);

    if (safeExpectedState
        .substring(1, safeExpectedState.length - 1)
        .isNotEmpty) {
      b.write(
        indent +
            'expectedState'.style(ColorProfile.expected) +
            ': ' +
            safeExpectedState +
            ',',
      );
      isEmpty = false;
    }

    if (isEmpty) {
      b.write(')');
    } else {
      b.write('\n)');
    }

    return b.toString();
  }
}
