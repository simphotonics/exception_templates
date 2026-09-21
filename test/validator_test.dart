import 'package:exception_templates/exception_templates.dart';
import 'package:test/test.dart';

void main() {
  group('identifier:', () {
    test('isValid', () {
      expect('async'.isValidIdentifier, isFalse);
      expect('input'.isValidIdentifier, isTrue);
      expect('OUT*'.isValidIdentifier, isFalse);
      expect('_\$i'.isValidIdentifier, isTrue);
    });
    test('async', () {
      expect(
        IdentifierValidator.reservedWords,
        isA<Set<String>>().having(
          (set) => set.contains('async'),
          'contains(async)',
          isTrue,
        ),
      );
    });
    test('className->libraryName', () {
      expect('StandardUserForm'.toLibraryName, 'standard_user_form');
      expect('STANDARDUserForm'.toLibraryName, 'standarduser_form');
      expect('standardUserForm'.toLibraryName, 'standard_user_form');
    });
  });
}
