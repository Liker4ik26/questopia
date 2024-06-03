import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questopia/core/common/widgets/card_image.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';

import '../../../../generated/assets.dart';
import '../../../core/app/styles/dimensions.dart';
import 'details_button.dart';

class QuestCardWidget extends StatelessWidget {
  const QuestCardWidget(
      {super.key,
      required this.onTap,
      required this.questDomain,
      this.onClickFavorite,
      this.onClickDelete,
      this.favoriteButton});

  final void Function() onTap;
  final void Function()? onClickFavorite;
  final void Function()? onClickDelete;
  final QuestDomain questDomain;
  final Widget? favoriteButton;

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.fromDateTime(
        DateTime.parse("2022-03-09 ${questDomain.time}"));
    int minutes = time.hour * 60 + time.minute;
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: context.color.tertiary),
        borderRadius: BorderRadius.circular(AppDimensions.medium),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.medium),
        onTap: onTap,
        child: Stack(
          children: [
            CardImage(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.tinyMedium),
              ),
              backgroundColor: context.color.secondary,
              fit: BoxFit.cover,
              imageUrl: questDomain.photos.first,
            ),
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.tinyMedium),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    .1,
                    .7,
                  ],
                  colors: [
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.6),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DetailsButton(text: 'от ${questDomain.price} ₽'),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 50,
                        child: DetailsButton(text: '${questDomain.ageLimit} +'),
                      ),
                      const Spacer(),
                      favoriteButton != null
                          ? favoriteButton!
                          : const SizedBox(),
                    ],
                  ).paddingOnly(left: 13, right: 16, bottom: 8),
                  questDomain.isNew == true
                      ? Container(
                          decoration: BoxDecoration(
                            color: context.color.tertiary.withOpacity(.6),
                            borderRadius: const BorderRadius.only(
                              topRight:
                                  Radius.circular(AppDimensions.extraSmall),
                              bottomRight:
                                  Radius.circular(AppDimensions.extraSmall),
                            ),
                          ),
                          child: Text(
                            'Новинка',
                            style: context.text.rfDewiRegular16,
                          ).paddingSymmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                        ).paddingSymmetric(vertical: 8)
                      : const SizedBox(),
                  const Spacer(),
                  Text(
                    questDomain.typeOfGame.nameOfType,
                    style: context.text.rfDewiRegular12.copyWith(
                      color: context.color.primary.withOpacity(.46),
                    ),
                  ).paddingOnly(
                    left: 13,
                    right: 16,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    questDomain.name,
                    style: context.text.rfDewiBold20,
                  ).paddingOnly(
                    left: 13,
                    right: 16,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 38,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      children: [
                        DetailsButton(
                            icon: Assets.iconsClock,
                            onPressed: () {},
                            text: '$minutes'),
                        DetailsButton(
                            icon: Assets.iconsStart,
                            onPressed: () {},
                            text: '5,0'),
                        DetailsButton(
                            icon: Assets.iconsUser,
                            onPressed: () {},
                            text:
                                '${questDomain.numberOfPlayerMin}-${questDomain.numberOfPlayerMax}'),
                        DetailsButton(
                            icon: Assets.iconsSkull,
                            onPressed: () {},
                            text: '${questDomain.levelOfFear} из 4'),
                        DetailsButton(
                            icon: Assets.iconsKey,
                            onPressed: () {},
                            text: '${questDomain.difficultyLevel} из 4'),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(
                top: 13,
                bottom: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
