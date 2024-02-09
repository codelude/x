import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter/app/auth/controller/auth.controller.dart';
import 'package:twitter/app/auth/view/signup.view.dart';
import 'package:twitter/app/home/view/home.view.dart';
import 'package:twitter/common/common.dart';
import 'package:twitter/theme/app.theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (error, st) => ErrorCommon(
              error: error.toString(),
            ),
            loading: () => const LoadingCommon(),
          ),
    );
  }
}
