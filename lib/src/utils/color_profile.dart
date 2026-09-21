import 'package:ansi_modifier/ansi_modifier.dart';

/// Defines styles and colors used to print benchmark reports to a terminal.
abstract class ColorProfile {
  /// Style of an error message part showing an error or exception.
  static FontModifier error = Ansi.redBright;

  /// Style of a message part showing details of an invalid state.
  static FontModifier invalid = Ansi.yellowBright;

  /// Style of the message showing details of an expected state.
  static FontModifier expected = Ansi.greenBright;
}
