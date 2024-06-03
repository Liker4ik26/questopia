import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/quests/domain/quest_domain.dart';
import 'package:questopia/generated/assets.dart';

class InformationGameBlock extends StatelessWidget {
  const InformationGameBlock({super.key, required this.questDomain});

  final QuestDomain questDomain;

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.fromDateTime(
        DateTime.parse("2022-03-09 ${questDomain.time}"));
    int minutes = time.hour * 60 + time.minute;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Информация об игре',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              'Время игры',
              style: context.text.rfDewiSemiBold16,
            ),
            const Spacer(),
            Text(
              '$minutes минут',
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(vertical: 12.5, horizontal: 24),
        Row(
          children: [
            Text(
              'Количество человек',
              style: context.text.rfDewiSemiBold16,
            ),
            const Spacer(),
            Text(
              '${questDomain.numberOfPlayerMin} - ${questDomain.numberOfPlayerMax}',
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(vertical: 12.5, horizontal: 24),
        Row(
          children: [
            Text(
              'Уровень сложности',
              style: context.text.rfDewiSemiBold16,
            ),
            const Spacer(),
            SvgIcon(
              icon: Assets.iconsKey,
              color: context.color.primary,
            ),
            const SizedBox(width: 8),
            Text(
              '${questDomain.difficultyLevel} из 4',
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(vertical: 12.5, horizontal: 24),
        Row(
          children: [
            Text(
              'Уровень страха',
              style: context.text.rfDewiSemiBold16,
            ),
            const Spacer(),
            SvgIcon(
              icon: Assets.iconsSkull,
              color: context.color.primary,
            ),
            const SizedBox(width: 8),
            Text(
              '${questDomain.levelOfFear} из 4',
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(vertical: 12.5, horizontal: 24),
        Row(
          children: [
            Text(
              'Возрастное ограничение',
              style: context.text.rfDewiSemiBold16,
            ),
            const Spacer(),
            Text(
              '${questDomain.ageLimit} +',
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(vertical: 12.5, horizontal: 24),
        const SizedBox(height: 24),
        Text(
          'Цены',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 16),
        Text(
          questDomain.priceQuest,
          style: context.text.rfDewiRegular14,
          softWrap: true,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 16),
        Text(
          'Описание',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 16),
        Text(
          questDomain.description,
          style: context.text.rfDewiRegular14,
          softWrap: true,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 16),
        Text(
          'Адрес:',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: Assets.iconsPlace,
              color: context.color.primary,
            ).paddingOnly(right: 12),
            Text(
              questDomain.organization.address,
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 22),
        Text(
          'Контакты',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: Assets.iconsPhone,
              color: context.color.primary,
            ).paddingOnly(right: 12),
            Text(
              questDomain.organization.phone,
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 22),
        Text(
          'В квесте есть',
          style: context.text.rfDewiSemiBold20,
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 20),
        questDomain.organization.wifi == true
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgIcon(
                    icon: Assets.iconsWifi,
                    color: context.color.primary,
                  ).paddingOnly(right: 12),
                  Text(
                    'WIFI',
                    style: context.text.rfDewiSemiBold16,
                  ),
                ],
              ).paddingOnly(left: 24, right: 24,bottom: 22)
            : const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: Assets.iconsCar,
              color: context.color.primary,
            ).paddingOnly(right: 12),
            Text(
              questDomain.organization.parkingPlace,
              style: context.text.rfDewiSemiBold16,
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: Assets.iconsArmchair,
              color: context.color.primary,
            ).paddingOnly(right: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Зал ожидания',
                    style: context.text.rfDewiSemiBold16,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    questDomain.organization.waitingRoom,
                    softWrap: true,
                    style: context.text.rfDewiRegular14
                        .copyWith(color: context.color.primary.withOpacity(.4)),
                  ),
                ],
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 24),
      ],
    );
  }
}
