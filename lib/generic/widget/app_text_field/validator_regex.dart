import 'validator.dart';

class ValidatorRegex extends Validator {
  String regEx = '';

  ValidatorRegex(this.regEx, String error) : super(error);

  @override
  Future<ValidatorResult> validate(Map<ValidableParam, dynamic> params) async {
    final String text = params[ValidableParam.text] as String;
    if (text == null) {
      return ValidatorResult(true, null);
    }

    if (text.isEmpty) {
      return ValidatorResult(true, null);
    }

    final RegExp regExp = RegExp(regEx);

    if (!regExp.hasMatch(text)) {
      return ValidatorResult(false, error);
    } else {
      return ValidatorResult(true, null);
    }
  }
}
