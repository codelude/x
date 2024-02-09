import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/api/auth.api.dart';
import 'package:twitter/app/auth/view/login.view.dart';
import 'package:twitter/app/home/view/home.view.dart';
import 'package:twitter/core/core.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    return AuthController(
      authAPI: ref.watch(authAPIProvider),
    );
  },
);

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI})
      : _authAPI = authAPI,
        super(false);
  // is Loading

  Future<User?> currentUser() => _authAPI.currentUser();

  void signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, "Account created! Please Login.");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginView(),
          ),
        );
      },
    );
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    final res = await _authAPI.login(
      email: email,
      password: password,
    );
    state = false;
    res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeView(),
          ),
        );
      },
    );
  }
}
