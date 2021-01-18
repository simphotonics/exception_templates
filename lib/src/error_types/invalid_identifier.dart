import 'error_type.dart';

/// [ErrorType] indicating that an invalid Dart identifier
/// was detected.
///
/// Usage:
///
/// ```
/// throw ErrorOfType<InvalidIdentifier>();
/// ```
///
/// Typically used with source code generators where users
/// provide the name of an identifier as `String`.
abstract class InvalidIdentifier extends ErrorType {}
