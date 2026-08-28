import 'package:test/test.dart';

import 'package:exception_templates/exception_templates.dart';

class InvalidDataFound extends ExceptionType;

void main() {
  group('ExceptionOfType:', () {
    test('<InvalidDataFound>', () {
      try {
        throw ExceptionOfType<InvalidDataFound>();
      } on ExceptionOfType catch (e) {
        expect(e.typeArgument, InvalidDataFound);
        expect(e.message, '');
        expect(e.invalidState, '');
        expect(e.expectedState, '');
      } catch (e) {
        throw Exception('Exception should have been caught already!');
      }
    });
  });
}
