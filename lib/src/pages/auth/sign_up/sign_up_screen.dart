import 'package:flutter/material.dart';
import 'package:questopia/src/pages/auth/sign_up/widgets/sign_up_form.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';
import 'package:questopia/src/shared/extensions/widget_modifier.dart';
import 'package:questopia/src/shared/widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.signUpScreenTitle,
              style: context.text.rfDewiBold28,
            ).paddingAll(24),
            SignUpForm(
              onContinue: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            const Spacer(),
            CustomButton(
              title: context.tr.signUpScreenGetIntoAccount,
              bgColor: context.color.onTertiary,
              onPressed: () {},
            ).paddingOnly(
              left: 24,
              right: 24,
              bottom: 16,
            ),
            CustomButton(
              title: context.tr.signUpScreenRegister,
              onPressed: () {},
            ).paddingOnly(
              left: 24,
              right: 24,
              bottom: 24,
            ),
          ],
        ),
      ),
    );
  }
}
