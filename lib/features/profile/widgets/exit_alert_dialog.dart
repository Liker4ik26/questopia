import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../../core/app/styles/dimensions.dart';

class ExitDialogWidget extends StatelessWidget {
  const ExitDialogWidget({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 237,
        decoration: BoxDecoration(
          color: context.color.onSecondary,
          borderRadius: BorderRadius.circular(AppDimensions.medium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              clipBehavior: Clip.hardEdge,
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.onTertiary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.exit_to_app_rounded,
                  color: context.color.primary,
                ).paddingAll(8),
              ),
            ),
            const SizedBox(height: 12),
            Text('Выйти из приложения', style: context.text.rfDewiSemiBold20),
            Text(
              'Вы действительно хотите выйти?',
              style: context.text.rfDewiRegular12.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ).paddingOnly(bottom: 44),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    bgColor: context.color.onTertiary,
                    title: 'Нет',
                    titleColor: context.color.primary.withOpacity(.4),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    onPressed: onPressed,
                    bgColor: context.color.tertiary,
                    title: 'Да',
                    titleColor: context.color.primary,
                  ),
                ),
              ],
            ),
          ],
        ).paddingAll(16),
      ).paddingSymmetric(horizontal: 24),
    );
  }
}
