import 'package:exception_templates/exception_templates.dart';
import 'package:test/test.dart';

void main() {
  group('identifier:', () {
    test('isValid', () {
      expect(isValidIdentifier('async'), isFalse);
      expect(isValidIdentifier('input'), isTrue);
      expect(isValidIdentifier('OUT*'), isFalse);
      expect(isValidIdentifier('_\$i'), isTrue);
    });
    test('async', () {
      expect(
        reservedWords,
        isA<Set<String>>().having(
          (set) => set.contains('async'),
          'contains(async)',
          isTrue,
        ),
      );
    });
    test('className->libraryName', () {
      expect(classNameToLibraryName('StandardUserForm'), 'standard_user_form');
      expect(classNameToLibraryName('STANDARDUserForm'), 'standarduser_form');
    });
  });
}
