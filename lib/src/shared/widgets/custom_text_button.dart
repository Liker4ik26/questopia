import 'package:flutter/material.dart';
import 'package:questopia/src/shared/extensions/context_extensions.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        overlayColor: MaterialStatePropertyAll(context.color.onTertiary),
      ),
      child: Text(
        title,
        style: context.text.rfDewiSemiBold16
            .copyWith(color: context.color.primary.withOpacity(.4)),
      ),
    );
  }
}
