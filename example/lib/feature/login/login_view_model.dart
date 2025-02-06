import 'package:example/feature/common/validator/email_validator.dart';
import 'package:example/feature/common/validator/password_validator.dart';
import 'package:example/feature/common/validator/validation_error.dart';
import 'package:example/feature/login/state/login_states.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel {
  final _loginStates = ValueNotifier<LoginStates>(LoginStates.initial());

  LoginStates get _states => _loginStates.value;

  ValueListenable<LoginStates> get loginStates => _loginStates;

  void onChangedEmail({required String? email}) {
    final emailError = EmailValidator.getEmailValidation(email);

    _loginStates.value = _states.copyWith(
      emailError: emailError,
      email: email,
    );

    _checkUpdateButtonState();
  }

  void onChangedPassword({required String? password}) {
    final passwordError = PasswordValidator.getValidationError(password);

    _loginStates.value = _states.copyWith(
      passwordError: passwordError,
      password: password,
    );

    _checkUpdateButtonState();
  }

  void _checkUpdateButtonState() {
    final hasAllFieldsFilled = _states.email.isNotEmpty && _states.password.isNotEmpty;

    final hasNoErrors = _states.emailError == ValidationError.none &&
        _states.passwordError == ValidationError.none;

    _loginStates.value = _states.copyWith(
      showButton: hasNoErrors && hasAllFieldsFilled,
    );
  }

  void onTapLoginButton() {
    _loginStates.value = _states.copyWith(
      showButton: false,
    );
  }

  void onDispose() {
    _loginStates.dispose();
  }
}
