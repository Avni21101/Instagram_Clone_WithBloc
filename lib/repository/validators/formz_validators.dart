import 'package:formz/formz.dart';

enum PasswordValidationError{invalid}

class Password extends FormzInput<String,PasswordValidationError>{
  const Password.dirty([super.value ='']) : super.dirty();
  const Password.pure() : super.pure('');

  static final _passwordRegExp =
  RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value ?? '') ? null : PasswordValidationError.invalid;
  }
}


enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  // for user that entered first time , then there must not error messages therefore pure
  const Email.pure() : super.pure('');

  const Email.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}