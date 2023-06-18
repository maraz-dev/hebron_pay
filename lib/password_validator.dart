/// Password Validation
String? validatePassword(String field) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.%^]).{8,}$';

  if (field.isEmpty) {
    return 'Password field cannot be empty';
  } else {
    if (field.length < 8) {
      return 'Password is too short';
    } else if (!hasLowercase(field)) {
      return 'Password must have an lowercase letter';
    } else if (!hasUppercase(field)) {
      return 'Password must have an uppercase letter';
    } else if (!hasSpecialCharacter(field)) {
      return 'Password must have a special character';
    } else if (!hasANumber(field)) {
      return 'Password must have a Number';
    } else {
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(field)) {
        return null;
      } else {
        return 'Invalid password format';
      }
    }
  }
}

bool has8Characters(String field) {
  if (field.length < 8) return false;

  return true;
}

bool hasLowercase(String field) {
  String pattern = r'^(?=.*?[a-z])';

  RegExp regExp = RegExp(pattern);

  if (regExp.hasMatch(field)) return true;

  return false;
}

bool hasANumber(String field) {
  String pattern = r'^(?=.*?[0-9])';

  RegExp regExp = RegExp(pattern);

  if (regExp.hasMatch(field)) return true;

  return false;
}

bool hasUppercase(String field) {
  String pattern = r'^(?=.*?[A-Z])';

  RegExp regExp = RegExp(pattern);

  if (regExp.hasMatch(field)) return true;

  return false;
}

bool hasSpecialCharacter(String field) {
  String pattern = r'^(?=.*?[!@#\$&*~.%^])';

  RegExp regExp = RegExp(pattern);

  if (regExp.hasMatch(field)) return true;

  return false;
}
