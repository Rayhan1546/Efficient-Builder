# Efficient Builder
*An Enhanced Alternative to ValueListenableBuilder*

Efficient Builder offers a more robust alternative to Flutter's ValueListenableBuilder, enhancing how widgets react to state changes. It overcomes common limitations associated with ValueNotifier by implementing a separation technique that extracts states from the ViewModel into a distinct class. Additionally, it resolves issues related to unnecessary rebuilding and state changes, providing more granular control over UI states.

## Features

* **Controlled Widget Rebuilds**
   * Fine-grained control over which widgets rebuild and when
   * Optimize performance by preventing unnecessary rebuilds

* **Clean Architecture Support**
   * Separate state definitions from ViewModel logic
   * Maintain clear boundaries between UI, state, and business logic

* **Simple Integration**
   * Minimal setup required
   * Works seamlessly with existing Flutter projects

* **Type-safe State Management**
   * Full type safety for your states
   * Compile-time error catching


## Getting started

1.Add the package to your pubspec.yaml:

```yaml
dependencies:
  efficient_builder: ^1.0.1
```

2.Import it in your code:

```dart
import 'package:efficient_builder/efficient_builder.dart';
```

## Usage

**Define Your State**

```dart
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
```

**Make ViewModel**

```dart
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

```

### Efficient Builder

``` dart
  Widget _buildEmailField(BuildContext context) {
    return EfficientBuilder(
      buildWhen: (p, n) {
        return p.emailError != n.emailError;
      },
      valueListenable: _viewModel.loginStates,
      builder: (context, state, _) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.emailError?.getError(),
          onChanged: (email) => _viewModel.onChangedEmail(email: email),
        );
      },
    );
  }
```

### Build Method Extension

``` dart 
  Widget _buildPasswordField(BuildContext context) {
    return _viewModel.loginStates.build(
      buildWhen: (p, n) {
        return p.passwordError != n.passwordError;
      },
      builder: (context, state) {
        return CustomTextField(
          controller: _passwordController,
          textFieldName: 'Password',
          errorText: state.passwordError?.getError(),
          textFieldType: TextFieldType.password,
          onChanged: (password) {
            _viewModel.onChangedPassword(password: password);
          },
        );
      },
    );
  }
```


### BuildFor Extension

```dart
  Widget _buildLogInButton(BuildContext context) {
    return _viewModel.loginStates.buildFor(
      select: (state) => state.showButton,
      builder: (context, state) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () {
            onTapLogIn();
            _viewModel.onTapLoginButton();
          },
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
```


