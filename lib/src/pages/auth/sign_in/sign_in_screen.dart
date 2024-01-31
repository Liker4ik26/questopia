import 'package:flutter/material.dart';
import 'package:questopia/src/shared/widgets/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomTextField(
        textInputAction: TextInputAction.done,
        hintText: 'Email',
        title: 'Email',
      ),
    );
  }
}
