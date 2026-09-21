import '../utils/color_profile.dart';

import 'package:ansi_modifier/ansi_modifier.dart';

mixin ColorString {
  String toColorString({
    Object message = '',
    Object expectedState = '',
    Object invalidState = '',
  }) {
    return '$runtimeType ${Error.safeToString(message)} \n'.style(
          ColorProfile.error,
        ) +
        '${Error.safeToString(invalidState)} \n'.style(ColorProfile.invalid) +
        '${Error.safeToString(expectedState)} \n'.style(ColorProfile.expected);
  }
}
 