import 'package:formz/formz.dart';

enum FirstNameValidationError {
  required('Vorname can\'t be empty'),
  invalid('Vorname you have entered is not valid.');

  final String message;
  const FirstNameValidationError(this.message);
}

class FirstNameModel extends FormzInput<String, FirstNameValidationError> {
  const FirstNameModel.pure() : super.pure('');
  const FirstNameModel.dirty([super.value = '']) : super.dirty();

  static final _firstNameRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  FirstNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FirstNameValidationError.required;
    }
    if (!_firstNameRegex.hasMatch(value)) {
      return FirstNameValidationError.invalid;
    }
    return null; // Kein Fehler
  }
}
