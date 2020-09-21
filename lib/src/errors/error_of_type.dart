import '../error_types/error_type.dart';
import 'error_of.dart';

/// Parameterized error template.
///
/// The generic type `T` indicates what **type** of error occured.
/// Usage:
/// ```Dart
/// // Creating a new [ErrorType].
/// class SerializationFailed extends ErrorType{}
///
/// // Throwing an error of type [ErrorType].
/// throw ErrorOfType<SerializationFailed>;
/// ```
class ErrorOfType<T extends ErrorType> extends ErrorOf<T> {
  ErrorOfType({
    Object message = '',
    Object invalidState = '',
    Object expectedState = '',
  }) : super(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        );
}
