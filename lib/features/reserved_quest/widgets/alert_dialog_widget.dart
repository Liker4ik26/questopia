import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/extensions/widget_extensions.dart';
import 'package:questopia/generated/assets.dart';

import '../../../core/repositories/reserved_quest/domain/reserved_quest.dart';
import '../bloc/reserved_quest_bloc.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key, required this.reservedSlotsQuestDomain});

  final ReservedSlotsQuestDomain reservedSlotsQuestDomain;

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
                child: SvgIcon(
                  icon: Assets.iconsClose,
                  color: Colors.white.withOpacity(.6),
                ).paddingAll(8),
              ),
            ),
            const SizedBox(height: 12),
            Text('Отменить квест', style: context.text.rfDewiSemiBold20),
            Text(
              'Вы действительно хотите отменить квест?',
              style: context.text.rfDewiRegular12.copyWith(
                color: context.color.primary.withOpacity(.4),
              ),
            ).paddingOnly(bottom: 44),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    bgColor: context.color.tertiary,
                    title: 'Нет',
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: BlocBuilder<ReservedQuestBloc, ReservedQuestState>(
                    builder: (context, state) {
                      if (state is ReservedQuestInitialState) {
                        return CustomButton(
                          onPressed: () {
                            context.read<ReservedQuestBloc>().add(
                                DeleteReservedQuestEvent(
                                    reservedQuest: reservedSlotsQuestDomain));
                          },
                          bgColor: context.color.onTertiary,
                          title: 'Да',
                          titleColor: context.color.primary.withOpacity(.4),
                        );
                      }
                      if (state is DeleteReservedQuestLoadingState) {
                        return CustomButton(
                          child: CircularProgressIndicator(
                            color: context.color.primary,
                          ),
                        );
                      }
                      if (state is DeleteReservedQuestSuccessState) {
                        context.pop();
                      }
                      return CustomButton(
                        onPressed: () {
                          context.read<ReservedQuestBloc>().add(
                                DeleteReservedQuestEvent(
                                    reservedQuest: reservedSlotsQuestDomain),
                              );
                        },
                        bgColor: context.color.onTertiary,
                        title: 'Да',
                        titleColor: context.color.primary.withOpacity(.4),
                      );
                    },
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
