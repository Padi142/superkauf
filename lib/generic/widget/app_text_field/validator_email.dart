import 'validator_regex.dart';

class ValidatorEmail extends ValidatorRegex {
  static const String ex = '[A-Za-z-0-9.-_]+@[A-Za-z0-9]+\\.[A-Za-z]{2,3}';

  ValidatorEmail({String error = 'error__validate_email'}) : super(ex, error);
}
