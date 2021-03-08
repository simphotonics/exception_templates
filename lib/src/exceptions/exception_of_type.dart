import '../exception_types/exception_type.dart';
import 'exception_of.dart';

/// Parameterized exception template.
/// The generic type `T` indicates what **type** of error occured.
/// Usage:
/// ```Dart
/// // Defining an exception type.
/// class DatabaseNotInitialized extends ExceptionType{}
///
/// // Throwing an exception of the newly defined type.
/// throw ExceptionOfType<DatabaseNotInitialized>
/// ```
class ExceptionOfType<T extends ExceptionType> extends ExceptionOf<T> {
  ExceptionOfType({
    Object message = '',
    Object invalidState = '',
    Object expectedState = '',
  }) : super(
          message: message,
          invalidState: invalidState,
          expectedState: expectedState,
        );
}
