import 'package:email_validator/email_validator.dart';

class TextFormValidator {
  static String? validateFieldEmpty(String? validate, {String? message}) {
    if ((validate ?? "").isEmpty) {
      return message ?? "The Field shouldn't be empty";
    }

    return null;
  }

  static String? validateFieldEmail(String? validate, {String? message}) {
    if (!EmailValidator.validate(validate ?? "")) {
      return message ?? "Email invalid";
    }

    if ((validate ?? "").isEmpty) {
      return message ?? "The Field shouldn't be empty";
    }

    return null;
  }

  static String? validateVinCode(String? validate, {String? message}) {
    if ((validate ?? "").length < 17) {
      return message ?? "VIN should contain 17 characters";
    }

    if ((validate ?? "").isEmpty) {
      return message ?? "The Field shouldn't be empty";
    }

    return null;
  }
}
