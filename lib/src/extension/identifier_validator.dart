import '../../exception_templates.dart' show InvalidIdentifier;
import '../error/error_of_type.dart' show ErrorOfType;

extension IdentifierValidator on String {
  /// A set of words that are considered reserved. Note:
  /// The Dart analyzer is less restrictive as to what words can be
  /// used as an identifier name.
  static const reservedWords = {
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
    'of',
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
  String get toLibraryName {
    final pattern = RegExp(r'(?<=[a-z])[A-Z]');
    final libraryName = replaceAllMapped(pattern, (Match m) => '_${m[0]}');
    return libraryName.toLowerCase();
  }

  /// Returns `true` if `this` is a valid Dart variable identifier, and `false`
  /// otherwise. Returns `false` if `this` is a word found in the set
  /// [reservedWords].
  bool get isValidIdentifier {
    // Contains only valid characters and starts with a non-numeric character.
    final regExp = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*');
    final match = regExp.stringMatch(this);
    if (match != this) return false;
    if (reservedWords.contains(this)) {
      return false;
    } else {
      return true;
    }
  }

  /// Throws an `ErrorOfType<InvalidIdentifier>` if [input] is not a
  /// valid Dart identifier.
  void validate() {
    if (!isValidIdentifier) {
      throw ErrorOfType<InvalidIdentifier>(
        message: 'Unsuitable identifier found.',
        expectedState: 'Valid Dart identifier.',
        invalidState: '\'$this\'',
      );
    }
  }
}
