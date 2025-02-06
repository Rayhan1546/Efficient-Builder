enum ValidationError {
  none,
  invalidEmail,
  requiredField,
  passwordEmpty,
  passwordNotMatched,
  passwordContainsSpace,
  passwordNoDigit,
  passwordNoUppercase,
  passwordNoLowercase,
  passwordNoSpecialChar,
  passwordTooShort;

  String? getError() {
    switch (this) {
      case ValidationError.none:
        return null;
      case ValidationError.invalidEmail:
        return "Please enter a valid email address";
      case ValidationError.requiredField:
        return "This field is required";
      case ValidationError.passwordEmpty:
        return "Password cannot be empty";
      case ValidationError.passwordNotMatched:
        return "Passwords do not match";
      case ValidationError.passwordContainsSpace:
        return "Password cannot contain spaces";
      case ValidationError.passwordNoDigit:
        return "Password must contain at least one number";
      case ValidationError.passwordNoUppercase:
        return "Password must contain at least one uppercase letter";
      case ValidationError.passwordNoLowercase:
        return "Password must contain at least one lowercase letter";
      case ValidationError.passwordNoSpecialChar:
        return "Password must contain at least one special character";
      case ValidationError.passwordTooShort:
        return "Password must be at least 8 characters long";
    }
  }
}
