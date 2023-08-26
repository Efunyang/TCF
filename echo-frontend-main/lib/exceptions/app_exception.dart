import 'package:echo_frontend/localization/string_hardcoded.dart';

sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

// Auth
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException() : super('email-already-in-use', 'Email already in use'.hcd);
}

class WeakPasswordException extends AppException {
  WeakPasswordException() : super('weak-password', 'Password is too weak'.hcd);
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('wrong-password', 'Wrong password'.hcd);
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found'.hcd);
}
