import 'package:flutter/material.dart';

class ErrorCommon extends StatelessWidget {
  final String error;
  const ErrorCommon({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(error: error),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String error;
  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error),
    );
  }
}
