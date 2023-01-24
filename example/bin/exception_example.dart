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
  const UserForm(this.userName);

  final String userName;

  /// Simulates fetching user feedback from a database or network connection.
  Future<String> fetchFeedback() async {
    final feedback = await later('');
    if (feedback.isEmpty) {
      throw ExceptionOf<UserForm>(
        message: 'Could not process $userName\'s feedback.',
        invalidState: 'String found: $feedback',
        expectedState: 'A non-empty String.',
      );
    }
    return feedback;
  }
}

void main(List<String> args) async {
  final userForm = UserForm('Daniel');
  try {
    final userFeedback = await userForm.fetchFeedback();
    print(userFeedback);
  } on ExceptionOf<UserForm> catch (e) {
    final userFeedback = e.message;
    print('Feedback: $userFeedback\n');
  }
}
