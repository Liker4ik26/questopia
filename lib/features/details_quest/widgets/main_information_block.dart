import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';

class MainInformationBlock extends StatelessWidget {
  const MainInformationBlock({super.key, required this.questDomain});

  final QuestDomain questDomain;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          questDomain.name,
          style: context.text.rfDewiBold28,
        ).paddingSymmetric(
          horizontal: 24,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Организатор: ${questDomain.organization.name}',
              style: context.text.rfDewiSemiBold14,
            ).paddingSymmetric(horizontal: 24),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: context.color.onTertiary,
            borderRadius: BorderRadius.circular(AppDimensions.extraSmall),
          ),
          child: Text(
            questDomain.typeOfGame.nameOfType,
            style: context.text.rfDewiSemiBold12,
          ).paddingSymmetric(
            horizontal: 12,
            vertical: 7,
          ),
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 27),
      ],
    );
  }
}
