import 'package:efficient_builder/efficient_builder.dart';
import 'package:example/feature/common/widgets/primary_button.dart';
import 'package:example/feature/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginButton({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return viewModel.loginStates.buildFor(
      select: (state) => state.showButton,
      builder: (context, state) {
        return PrimaryButton(
          label: "LOG IN",
          onPressed: () {
            viewModel.onTapLoginButton();
          },
          minWidth: double.infinity,
          isDisabled: !state.showButton,
        );
      },
    );
  }
}
