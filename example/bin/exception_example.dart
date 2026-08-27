// To run this program navigate to the root of your local copy of the
// package exception_templates and use
//
// # dart example/bin/exception_example.dart
//
// followed by enter.
import 'package:exception_templates/exception_templates.dart';

/// Returns the variable t afer some time. Used to simulate a database or
/// network connection.
Future<T> later<T>(T t) async {
  return await Future.delayed(Duration(milliseconds: 200), () => t);
}

/// Sample class
class UserForm {
  const new({required this.userName, required this.dateOfBirth});

  final String userName;
  final DateTime dateOfBirth;
  int get age => DateTime.now().year - dateOfBirth.year;

  /// Simulates fetching user feedback.
  Future<String> fetchFeedback() async {
    final feedback = await later('We had a good time dining at the ...');
    if (age < 18) {
      throw ExceptionOf<UserForm>(
        message: 'Could not process $userName\'s feedback.',
        invalidState: 'The user is a minor with age: $age.',
        expectedState: 'Only adults are allowed to leave feedback.',
      );
    }
    return feedback;
  }
}

void main(List<String> args) async {
  final userForm = UserForm(
    userName: 'Daniel',
    dateOfBirth: DateTime(2018, 5, 25),
  );
  try {
    final userFeedback = await userForm.fetchFeedback();
    print(userFeedback);
  } on ExceptionOf<UserForm> catch (e) {
    final userFeedback = e.message;
    print('Feedback: $userFeedback\n');
  }
}
