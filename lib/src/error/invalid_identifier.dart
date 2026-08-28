import 'error_type.dart';

/// Error indicating that an invalid Dart identifier
/// was detected.
/// Typically used with source code generators where users
/// provide the name of an identifier as a [String] or [Symbol].
/// ```
/// // Usage:
/// throw ErrorOfType<InvalidIdentifier>();
/// ```
final class InvalidIdentifier extends ErrorType;
