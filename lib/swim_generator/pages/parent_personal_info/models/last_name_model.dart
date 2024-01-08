
import 'package:formz/formz.dart';

enum LastNameValidationError {
  required('Nachname can\'t be empty'),
  invalid('Nachname you have entered is not valid.');

  final String message;
  const LastNameValidationError(this.message);
}

class LastNameModel extends FormzInput<String, LastNameValidationError> {
  const LastNameModel.pure() : super.pure('');
  const LastNameModel.dirty([super.value = '']) : super.dirty();

  static final _lastNameRegex =
  RegExp(r"[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");

  @override
  LastNameValidationError? validator(String value) {
    return value.isEmpty
        ? LastNameValidationError.required
        : _lastNameRegex.hasMatch(value)
        ? null
        : LastNameValidationError.invalid;
  }
}