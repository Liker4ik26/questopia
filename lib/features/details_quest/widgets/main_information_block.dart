import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';
import 'package:questopia/generated/assets.dart';

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
        Text(
          'Организатор: ${questDomain.organization.name}',
          style: context.text.rfDewiSemiBold14,
        ).paddingSymmetric(horizontal: 24),
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
        const SizedBox(height: 16),
        Row(
          children: [
            RatingBar(
              itemSize: 16,
              initialRating: 3.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: SvgIcon(
                  icon: Assets.iconsFullStar,
                  color: context.color.onPrimary,
                ),
                half: SvgIcon(
                  icon: Assets.iconsHalfStar,
                  color: context.color.onPrimary,
                ),
                empty: SvgIcon(
                  icon: Assets.iconsFullStar,
                  color: context.color.primary.withOpacity(.12),
                ),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 2),
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(width: 8),
            Text(
              '5,0',
              style: context.text.rfDewiSemiBold12,
            ),
            const SizedBox(width: 8),
            Text(
              '325 оценок',
              style: context.text.rfDewiSemiBold12.copyWith(
                color: context.color.primary.withOpacity(.5),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 27),
      ],
    );
  }
}
