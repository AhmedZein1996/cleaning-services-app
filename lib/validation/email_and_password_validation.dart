
import 'package:clean_services_app/utilities/constants.dart';

final RegExp validCharacters = RegExp(r'^[a-zA-Z0-9_\-=\@,\.;]+$');

class EPValidation {
  static String isEmailValid(String email) {
    if (validCharacters.hasMatch(email)) {
      if (email.contains("@")) {
        return kValidEmailMessage;
      } else {
        return kInvalidEmailMessage;
      }
    } else {
      return kInvalidEmailBecauseSpecialCharMessage;
    }
  }

  static String isPasswordValid(String password) {
    if (password.length > 7) {
      return kValidPasswordMessage;
    } else {
      return kInvalidPasswordMessage;
    }
  }
}
