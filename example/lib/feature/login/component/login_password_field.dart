import 'package:efficient_builder/efficient_builder.dart';
import 'package:example/feature/common/widgets/custom_text_field.dart';
import 'package:example/feature/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginPasswordField extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginPasswordField({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.viewModel.loginStates.build(
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
            widget.viewModel.onChangedPassword(password: password);
          },
        );
      },
    );
  }
}
