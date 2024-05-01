import 'package:flutter/material.dart';
import 'package:questopia/src/pages/auth/sign_in/widgets/sign_in_form.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';
import 'package:questopia/src/shared/extensions/widget_modifier.dart';
import 'package:questopia/src/shared/widgets/custom_button.dart';
import 'package:questopia/src/shared/widgets/custom_text_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.signScreenTitle,
              style: context.text.rfDewiBold28,
            ).paddingAll(24),
            SignInForm(
              onContinue: () {},
            ),
            const SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:
                  CustomTextButton(title: context.tr.signScreenForgotPassword),
            ).paddingSymmetric(horizontal: 24),
            const Spacer(),
            CustomButton(
              title: context.tr.signScreenLogIn,
              onPressed: () {},
            ).paddingAll(24),
          ],
        ),
      ),
    );
  }
}
