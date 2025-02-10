import 'package:efficient_builder/efficient_builder.dart';
import 'package:example/feature/common/widgets/custom_text_field.dart';
import 'package:example/feature/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginEmailField extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginEmailField({
    super.key,
    required this.viewModel,
  });

  @override
  State<LoginEmailField> createState() => _LoginEmailFieldState();
}

class _LoginEmailFieldState extends State<LoginEmailField> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EfficientBuilder(
      buildWhen: (p, n) {
        return p.emailError != n.emailError;
      },
      valueListenable: widget.viewModel.loginStates,
      builder: (context, state, _) {
        return CustomTextField(
          controller: _emailController,
          textFieldName: 'Email',
          textFieldType: TextFieldType.email,
          errorText: state.emailError?.getError(),
          onChanged: (email) => widget.viewModel.onChangedEmail(email: email),
        );
      },
    );
  }
}
