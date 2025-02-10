import 'package:example/feature/login/component/login_button.dart';
import 'package:example/feature/login/component/login_email_field.dart';
import 'package:example/feature/login/component/login_password_field.dart';
import 'package:example/feature/login/login_view_model.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginScreen> {
  final _viewModel = LoginViewModel();

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
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
          LoginEmailField(viewModel: _viewModel),
          const SizedBox(height: 24),
          LoginPasswordField(viewModel: _viewModel),
          const SizedBox(height: 40),
          LoginButton(viewModel: _viewModel),
        ],
      ),
    );
  }
}
