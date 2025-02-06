import 'package:example/feature/common/validator/validation_error.dart';

class LoginStates {
  final String email;
  final String password;
  final bool showButton;
  final ValidationError? emailError;
  final ValidationError? passwordError;

  LoginStates({
    required this.email,
    required this.password,
    required this.showButton,
    this.emailError,
    this.passwordError,
  });

  factory LoginStates.initial() {
    return LoginStates(
      email: '',
      password: '',
      showButton: false,
    );
  }

  LoginStates copyWith({
    String? email,
    String? password,
    bool? showButton,
    ValidationError? emailError,
    ValidationError? passwordError,
  }) {
    return LoginStates(
      email: email ?? this.email,
      password: password ?? this.password,
      showButton: showButton ?? this.showButton,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}
