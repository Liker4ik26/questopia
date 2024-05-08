import 'package:flutter/material.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';
import 'package:questopia/src/shared/extensions/widget_modifier.dart';
import 'package:questopia/src/shared/utils/validators.dart';
import 'package:questopia/src/shared/widgets/custom_text_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm(
      {super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(
            textInputAction: TextInputAction.next,
            title: context.tr.signScreenEmail,
            validator: (value) {
              return emptyValidator(
                context,
                value,
              );
            },
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            textInputAction: TextInputAction.done,
            title: context.tr.signScreenPassword,
            validator: (value) {
              return emptyValidator(
                context,
                value,
              );
            },
          ).paddingSymmetric(horizontal: 24),
        ],
      ),
    );
  }
}
