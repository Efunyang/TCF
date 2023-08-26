import 'package:echo_frontend/localization/string_hardcoded.dart';
import 'package:echo_frontend/utils/string_validators.dart';

/// Mixin class to be used for client-side email & password validation
mixin LoginValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordSignInSubmitValidator = NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSubmitPassword(String password) {
    return passwordSignInSubmitValidator.isValid(password);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText = email.isEmpty ? 'Email can\'t be empty'.hcd : 'Invalid email'.hcd;
    return showErrorText ? errorText : null;
  }

  String? passwordErrorText(String password) {
    final bool showErrorText = !canSubmitPassword(password);
    final String errorText = password.isEmpty ? 'Password can\'t be empty'.hcd : 'Password is too short'.hcd;
    return showErrorText ? errorText : null;
  }
}
