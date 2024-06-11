import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/filters/bloc/filter_bloc.dart';
import 'package:questopia/features/home/bloc/home_bloc.dart';
import 'package:questopia/features/home/widgets/custom_chip.dart';
import 'package:questopia/features/home/widgets/favorites_button.dart';
import 'package:questopia/features/home/widgets/quest_card_widget.dart';

import '../../../generated/assets.dart';
import '../../core/app/navigation/routes.dart';
import '../../core/database/model/quest_entity.dart';
import '../favourites/bloc/favourites_bloc.dart';
import '../filters/filter_screen.dart';

enum TypeQuest {
  all('Все'),
  scary('Страшные'),
  forChildren('Для детей'),
  forBeginners('Для новичков'),
  entourage('Антуражные');

  const TypeQuest(this.value);

  final String value;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set filters = {};

  TypeQuest selectedCategory = TypeQuest.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            toolbarHeight: 100,
            backgroundColor: context.color.backgroundColor,
            pinned: true,
            title: Text(
              'Квесты в Омске',
              style: context.text.rfDewiBold28
                  .copyWith(color: context.color.primary),
            ).paddingOnly(left: 12),
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    showDragHandle: true,
                    elevation: 0,
                    useRootNavigator: true,
                    backgroundColor: context.color.onSecondary,
                    builder: (innerContext) {
                      return FilterScreen(
                        homeBloc: context.read<HomeBloc>(),
                        filterBloc: context.read<FilterBloc>(),
                      );
                    },
                  );
                },
                icon: SvgIcon(
                  icon: Assets.iconsFilter,
                  color: context.color.primary,
                ),
              ),
              IconButton(
                onPressed: () => context.push(Routes.searchRoute),
                icon: SvgIcon(
                  icon: Assets.iconsSearch,
                  color: context.color.primary,
                ),
              ).paddingOnly(right: 24),
            ],
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 30),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CustomChip(
                          text: TypeQuest.values[index].value,
                          selected: TypeQuest.values[index] == selectedCategory,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedCategory = TypeQuest.values[index];
                              } else {
                                selectedCategory = TypeQuest.all;
                              }
                            });
                          },
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemCount: TypeQuest.values.length),
              ).paddingOnly(bottom: 16),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 21,
            ),
          ),
        ],
        body: RefreshIndicator(
          color: context.color.tertiary,
          onRefresh: () {
            final completer = Completer();
            context.read<HomeBloc>().add(
                  LoadQuestsEvent(
                      completer: completer, type: selectedCategory.value),
                );
            return completer.future;
          },
          child: CustomScrollView(
            slivers: [
              BlocBuilder<HomeBloc, HomeState>(
                bloc: context.read<HomeBloc>()
                  ..add(
                    LoadQuestsEvent(
                        completer: null, type: selectedCategory.value),
                  ),
                builder: (context, state) {
                  print(state);
                  if (state is HomeErrorState) {
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
                            onPressed: () => context.read<HomeBloc>().add(
                                  LoadQuestsEvent(
                                      completer: null,
                                      type: selectedCategory.value),
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

                  if (state is HomeLoadedState) {
                    return SliverSafeArea(
                      top: false,
                      sliver: SliverList.separated(
                        itemCount: state.quests.length,
                        itemBuilder: (context, index) {
                          final quest = state.quests[index];
                          return QuestCardWidget(
                            favoriteButton:
                                BlocBuilder<FavouritesBloc, FavouritesState>(
                              bloc: context.read<FavouritesBloc>()
                                ..add(const FavouritesEvent.load()),
                              builder: (context, favoriteState) {
                                final isSelected = favoriteState.maybeMap(
                                  loaded: (state) => state.items
                                      .where((element) =>
                                          element.questId == quest.id)
                                      .isNotEmpty,
                                  orElse: () => false,
                                );
                                return FavoritesButton(
                                  onPressed: () {
                                    if (isSelected) {
                                      context.read<FavouritesBloc>().add(
                                            FavouritesEvent.delete(
                                              index: QuestEntity(
                                                  price: quest.price,
                                                  name: quest.name,
                                                  ageLimit: quest.ageLimit,
                                                  numberOfPlayerMax:
                                                      quest.numberOfPlayerMax,
                                                  numberOfPlayerMin:
                                                      quest.numberOfPlayerMin,
                                                  time: quest.time,
                                                  difficultyLevel:
                                                      quest.difficultyLevel,
                                                  levelOfFear:
                                                      quest.levelOfFear,
                                                  typeOfGame: quest
                                                      .typeOfGame.nameOfType,
                                                  photos: quest.photos.first,
                                                  isNew: quest.isNew,
                                                  questId: quest.id),
                                            ),
                                          );
                                      print('Удаление');
                                    } else {
                                      context.read<FavouritesBloc>().add(
                                            FavouritesEvent.add(
                                              entity: QuestEntity(
                                                  price: quest.price,
                                                  name: quest.name,
                                                  ageLimit: quest.ageLimit,
                                                  numberOfPlayerMax:
                                                      quest.numberOfPlayerMax,
                                                  numberOfPlayerMin:
                                                      quest.numberOfPlayerMin,
                                                  time: quest.time,
                                                  difficultyLevel:
                                                      quest.difficultyLevel,
                                                  levelOfFear:
                                                      quest.levelOfFear,
                                                  typeOfGame: quest
                                                      .typeOfGame.nameOfType,
                                                  photos: quest.photos.first,
                                                  isNew: quest.isNew,
                                                  questId: quest.id),
                                            ),
                                          );
                                      print('Добавление');
                                    }
                                  },
                                  isLike: isSelected ? true : false,
                                );
                              },
                            ),
                            onTap: () => context.pushNamed(
                              'quests',
                              pathParameters: {
                                'questId': state.quests[index].id
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
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
