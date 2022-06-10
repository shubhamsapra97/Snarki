import 'package:email_validator/email_validator.dart';

class Validator {
  static bool isEmail(String email) => EmailValidator.validate(email);

// Making Form Email Validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is a required field';
    bool isEmail(String email) => EmailValidator.validate(email);
    String? msg = null;
    if (!isEmail(value.trim())) {
      msg = 'Please enter a valid email';
    }
    return msg;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    } else if (value.length < 4) {
      return 'Name must be more than 4 characters';
    }
    return null;
  }
}