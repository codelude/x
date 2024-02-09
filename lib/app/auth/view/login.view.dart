import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/app/auth/controller/auth.controller.dart';
import 'package:twitter/app/auth/view/signup.view.dart';
import 'package:twitter/app/auth/widget/auth.field.dart';
import 'package:twitter/common/loading.common.dart';
import 'package:twitter/constants/ui.constant.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthField(
                      controller: emailController,
                      hintText: "Enter Your Email ID",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthField(
                      controller: passwordController,
                      hintText: "Enter Your Password",
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FilledButton(
                      onPressed: onLogin,
                      child: const Text("Login"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignUpView()));
                      },
                      child: const Text("Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
