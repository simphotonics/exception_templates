import 'package:ansi_modifier/ansi_modifier.dart';

/// Defines the font style and color used to generated colorized console
/// output.
abstract class ColorProfile {
  /// Style of an error message part showing an error or exception.
  static FontModifier error = Ansi.redBright;

  /// Style of a message part showing details of an invalid state.
  static FontModifier invalid = Ansi.yellowBright;

  /// Style of the message showing details of an expected state.
  static FontModifier expected = Ansi.greenBright;
}
