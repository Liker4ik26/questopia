import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/details_quest/bloc/details_quest_bloc.dart';
import 'package:questopia/features/details_quest/widgets/default_pageview.dart';
import 'package:questopia/features/details_quest/widgets/information_game_block.dart';
import 'package:questopia/features/details_quest/widgets/main_information_block.dart';
import 'package:questopia/features/reservations/reservations_screen.dart';
import 'package:questopia/generated/assets.dart';

import '../../core/common/widgets/card_image.dart';

class DetailsQuestScreen extends StatefulWidget {
  const DetailsQuestScreen({super.key, required this.questId});

  @override
  State<DetailsQuestScreen> createState() => _DetailsQuestScreenState();

  final String questId;
}

class _DetailsQuestScreenState extends State<DetailsQuestScreen> {
  final PageController controller = PageController();
  var questName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.onSecondary,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              BlocBuilder<DetailsQuestBloc, DetailsQuestState>(
                bloc: context.read<DetailsQuestBloc>()
                  ..add(
                    LoadQuestEvent(questId: widget.questId),
                  ),
                builder: (context, state) {
                  if (state is DetailsQuestLoadedState) {
                    return SliverAppBar(
                      pinned: true,
                      leading: IconButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: context.color.backgroundColor,
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
                      ).paddingOnly(left: 16,top: 16),
                      expandedHeight: 300,
                      stretch: true,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: FlexibleSpaceBar(
                        background: DefaultPageView(
                          controller: controller,
                          items: [
                            ...List.generate(
                              state.quest.photos.length,
                              (index) => CardImage(
                                imageUrl: state.quest.photos[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        stretchModes: const [
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle,
                        ],
                      ),
                    );
                  }
                  if (state is DetailsQuestErrorState) {
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
                                context.read<DetailsQuestBloc>().add(
                                      LoadQuestEvent(questId: widget.questId),
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
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.color.tertiary,
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<DetailsQuestBloc, DetailsQuestState>(
                bloc: context.read<DetailsQuestBloc>()
                  ..add(
                    LoadQuestEvent(questId: widget.questId),
                  ),
                builder: (context, state) {
                  if (state is DetailsQuestLoadedState) {
                    questName = state.quest.name;
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          MainInformationBlock(
                            questDomain: state.quest,
                          ),
                          InformationGameBlock(
                            questDomain: state.quest,
                          ),
                        ],
                      ).paddingOnly(bottom: 130),
                    );
                  }
                  if (state is DetailsQuestErrorState) {
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
                                context.read<DetailsQuestBloc>().add(
                                      LoadQuestEvent(questId: widget.questId),
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
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: context.color.tertiary,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: context.color.onSecondary,
              child: SafeArea(
                top: false,
                child: CustomButton(
                  title: 'Забронировать',
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      showDragHandle: true,
                      elevation: 0,
                      backgroundColor: context.color.onSecondary,
                      builder: (context) {
                        return ReservationsScreen(
                          questId: widget.questId,
                          questTitle: questName,
                        );
                      },
                    );
                  },
                ).paddingAll(24),
              ),
            ),
          )
        ],
      ),
    );
  }
}
