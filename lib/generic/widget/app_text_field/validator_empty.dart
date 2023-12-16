import 'validator.dart';

class ValidatorEmpty extends Validator {
  ValidatorEmpty({String error = 'error__validate_empty'}) : super(error);

  @override
  Future<ValidatorResult> validate(Map<ValidableParam, dynamic> params) async {
    final String text = params[ValidableParam.text] as String;
    if (text == null) {
      return ValidatorResult(false, error);
    }

    if (text.isEmpty) {
      return ValidatorResult(false, error);
    } else {
      return ValidatorResult(true, null);
    }
  }
}
