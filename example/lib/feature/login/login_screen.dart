import 'package:efficient_builder/efficient_builder.dart';
import 'package:example/feature/common/widgets/custom_text_field.dart';
import 'package:example/feature/common/widgets/primary_button.dart';
import 'package:example/feature/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginScreen> {
  final _viewModel = LoginViewModel();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _viewModel.onDispose();
    super.dispose();
  }

  void onTapLogIn() {
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SIGN IN"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          _buildEmailField(context),
          const SizedBox(height: 24),
          _buildPasswordField(context),
          const SizedBox(height: 40),
          _buildLogInButton(context),
        ],
      ),
    );
  }

  ///Example Usage of Efficient Builder......We can give a condition to it. It will rebuild the UI, according that condition.
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

  ///Build method is a extension of ValueListenable....It also usage Efficient builder but reduces some code.
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

  ///Build for is also extension of ValueListenable......It takes a value. It will update the UI according to
  ///this value. When the state of this changes. It will rebuild.
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
}
