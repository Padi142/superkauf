enum ValidableParam { text }

abstract class Validator {
  String error;
  Validator(this.error);

  Future<ValidatorResult> validate(Map<ValidableParam, dynamic> params);
}

class ValidatorResult {
  String? error;
  bool valid;
  ValidatorResult(this.valid, this.error);
}
