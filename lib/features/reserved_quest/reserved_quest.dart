import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/reserved_quest/bloc/reserved_quest_bloc.dart';
import 'package:questopia/generated/assets.dart';

import 'widgets/reserved_quest_card.dart';

class ReservedQuestScreen extends StatefulWidget {
  const ReservedQuestScreen({super.key});

  @override
  State<ReservedQuestScreen> createState() => _ReservedQuestScreenState();
}

class _ReservedQuestScreenState extends State<ReservedQuestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ReservedQuestBloc, ReservedQuestState>(
        listener: (context, state) {
          if (state is DeleteReservedQuestErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.error.withOpacity(.4),
                content: Text('Произошла ошибка${state.error}'),
              ),
            );
          }
          if (state is DeleteReservedQuestSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.tertiary.withOpacity(.4),
                content: const Text('Бронь была отменена'),
              ),
            );
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: context.color.backgroundColor,
              automaticallyImplyLeading: false,
              pinned: true,
              leadingWidth: 68,
              leading: Center(
                child: IconButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.color.onSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.tinyMedium),
                    ),
                  ),
                  icon: SvgIcon(
                    icon: Assets.iconsChevronLeft,
                    color: context.color.primary,
                  ),
                  onPressed: () => context.pop(),
                ).paddingOnly(left: 24),
              ),
              title: Text('Брони', style: context.text.rfDewiBold28),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 4)),
            BlocBuilder<ReservedQuestBloc, ReservedQuestState>(
              bloc: context.read<ReservedQuestBloc>()
                ..add(
                  const LoadQuestsEvent(
                    completer: null,
                  ),
                ),
              builder: (context, state) {
                if (state is ReservedQuestErrorState) {
                  return SliverFillRemaining(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.error.toString(),
                          style: context.text.rfDewiBold16,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<ReservedQuestBloc>().add(
                                    const LoadQuestsEvent(
                                      completer: null,
                                    ),
                                  ),
                          child: Text(
                            'Перезагрузить',
                            style: context.text.rfDewiBold16
                                .copyWith(color: context.color.tertiary),
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 16),
                  );
                }
                if (state is ReservedQuestLoadedState) {
                  return SliverSafeArea(
                    top: false,
                    sliver: SliverList.separated(
                      itemCount: state.reservedQuests.length,
                      itemBuilder: (context, index) {
                        final quest = state.reservedQuests[index];
                        return ReservedQuestCard(
                          onTap: () => context.pushNamed(
                            'quests',
                            pathParameters: {
                              'questId':
                                  state.reservedQuests[index].idSlot.idQuest.id
                            },
                          ),
                          questDomain: quest,
                        ).paddingSymmetric(horizontal: 24);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                  );
                }

                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: context.color.tertiary,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
