import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';


enum SwimLevelValidationError {
  required('Ein Schwimmniveau muss ausgewählt werden.');

  final String message;
  const SwimLevelValidationError(this.message);
}

class SwimLevelModel extends FormzInput<SwimLevelEnum?, SwimLevelValidationError> {
  const SwimLevelModel.pure() : super.pure(null);
  const SwimLevelModel.dirty([super.value]) : super.dirty();

  @override
  SwimLevelValidationError? validator(SwimLevelEnum? value) {
    if (value == null) {
      return SwimLevelValidationError.required;
    }
    // Hier können Sie bei Bedarf weitere Validierungen hinzufügen
    return null;
  }
}
