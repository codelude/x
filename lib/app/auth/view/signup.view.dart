import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/app/auth/controller/auth.controller.dart';
import 'package:twitter/app/auth/view/login.view.dart';
import 'package:twitter/app/auth/widget/auth.field.dart';
import 'package:twitter/common/common.dart';
import 'package:twitter/constants/ui.constant.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoaing = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: appbar,
      body: isLoaing
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    AuthField(
                      controller: emailController,
                      hintText: "Enter Your Email ID",
                    ),
                    AuthField(
                      controller: passwordController,
                      hintText: "Enter Your Password",
                    ),
                    FilledButton(
                        onPressed: onSignUp, child: const Text("Sign Up")),
                    const SizedBox(
                      height: 60,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginView()));
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
