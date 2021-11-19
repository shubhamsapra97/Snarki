import 'package:form_field_validator/form_field_validator.dart';
import 'package:formz/formz.dart';



class Email extends FormzInput<String, String> {
  Email.pure() : super.pure('');

  Email.dirty({String value = ''}) : super.dirty(value);

  final _emailValidator = PatternValidator(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      errorText: 'Enter a valid email address');

  get emailValidator => _emailValidator;

  @override
  String? validator(String value) {
    return _emailValidator.call(value);
  }
}

class Password extends FormzInput<String, String> {
  Password.pure() : super.pure('');

  Password.dirty({String value = ''}) : super.dirty(value);

  static final _lengthValidator = MinLengthValidator(8,
      errorText: 'Password must be at least 8 digits long');

  final _passwordValidator = MultiValidator([
    _lengthValidator,
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'Passwords must have at least one special character')
  ]);

  get passwordValidator => _passwordValidator;

  @override
  String? validator(String value) {
    return _passwordValidator.call(value);
  }
}

class RePassword extends FormzInput<String, String> {
  final String password;
  RePassword.pure({this.password = ''}) : super.pure('');

  RePassword.dirty({this.password = '', String value = ''}) : super.dirty(value);

  final _matchValidator = MatchValidator(errorText: "Passwords dont match");

  get matchValidator => _matchValidator;

  @override
  String? validator(String value) {
    return _matchValidator.validateMatch(value, password);
  }
}

class Name extends FormzInput<String, String> {
  Name.pure() : super.pure('');

  Name.dirty({String value = ''}) : super.dirty(value);

  static final _nameValidator =
      RequiredValidator(errorText: 'this field is required');
  get nameValidator => _nameValidator;
  @override
  String? validator(String value) {
    return _nameValidator.call(value);
  }
}
