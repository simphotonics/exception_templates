/// [String] functions used by source code generators.
library validators;

import 'dart:collection' show UnmodifiableListView;

import '../errors/error_of_type.dart';
import '../error_types/invalid_identifier.dart';

/// Returns a list of Dart keywords.
final dartKeywords = UnmodifiableListView<String>([
  'abstract',
  'as',
  'assert',
  'async',
  'await',
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
  'extends,',
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
  'while',
  'with',
  'yield',
]);

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

/// Returns `true` if [input] is valid Dart variable identifier.
bool isValidIdentifier(String input) {
  // Contains only valid characters and starts with a non-numeric character.
  final regExp = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*');
  final match = regExp.stringMatch(input);
  if (match != input) return false;
  if (dartKeywords.contains(input)) {
    return false;
  } else {
    return true;
  }
}

/// Throws an `ErrorOfType<InvalidIdentifier>` if [input] is not a valid Dart identifier.
void validateIdentifier(String input) {
  if (!isValidIdentifier(input)) {
    throw ErrorOfType<InvalidIdentifier>(
        message: 'Unsuitable identifier found.',
        expectedState: 'Valid Dart identifier.',
        invalidState: '\'$input\'');
  }
}
