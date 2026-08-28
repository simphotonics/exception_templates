import 'package:test/test.dart';

import 'package:exception_templates/exception_templates.dart';

// Defining error type.
class FailedToSerializeObject extends ErrorType;

void main() {
  group('ErrorOfType:', () {
    test('<FailedToSerializeObject>', () {
      try {
        throw ErrorOfType<FailedToSerializeObject>(
          message: 'Serialization failed.',
        );
      } on ErrorOfType catch (e) {
        expect(e.typeArgument, FailedToSerializeObject);
        expect(e.message, 'Serialization failed.');
        expect(e.invalidState, '');
        expect(e.expectedState, '');
      } catch (e) {
        throw Exception('Error should have been caught already!');
      }
    });
  });
}
