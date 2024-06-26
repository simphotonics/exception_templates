import '../error/error_of_type.dart';
import '../error/invalid_identifier.dart';

const reservedWords = {
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'base',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'late',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'required',
  'rethrow',
  'return',
  'sealed',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'when',
  'while',
  'with',
  'yield',
};

/// Converts a capital camel case Dart class name
/// to a lower case underscore separated Dart library name.
String classNameToLibraryName(String className) {
  final pattern = RegExp(r'(?<=[a-z])[A-Z]');
  final libraryName = className.replaceAllMapped(
    pattern,
    (Match m) => '_${m[0]}',
  );
  return libraryName.toLowerCase();
}

/// Returns `true` if [input] is a valid Dart variable identifier.
bool isValidIdentifier(String input) {
  // Contains only valid characters and starts with a non-numeric character.
  final regExp = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*');
  final match = regExp.stringMatch(input);
  if (match != input) return false;
  if (reservedWords.contains(input)) {
    return false;
  } else {
    return true;
  }
}

/// Throws an `ErrorOfType<InvalidIdentifier>` if [input] is not a
/// valid Dart identifier.
void validateIdentifier(String input) {
  if (!isValidIdentifier(input)) {
    throw ErrorOfType<InvalidIdentifier>(
        message: 'Unsuitable identifier found.',
        expectedState: 'Valid Dart identifier.',
        invalidState: '\'$input\'');
  }
}
