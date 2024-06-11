import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/database/model/quest_entity.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/favourites/bloc/favourites_bloc.dart';
import 'package:questopia/features/favourites/widgets/favourites_card.dart';
import 'package:questopia/generated/assets.dart';

import '../home/widgets/favorites_button.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverToBoxAdapter(
            child: Text('Избранное', style: context.text.rfDewiBold28)
                .paddingSymmetric(horizontal: 24),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          BlocBuilder<FavouritesBloc, FavouritesState>(
            bloc: context.read<FavouritesBloc>()
              ..add(const FavouritesEvent.load()),
            builder: (context, state) {
              return state.maybeMap(
                loaded: (state) {
                  if (state.items.isEmpty) {
                   return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.imagesEmptyFavorite),
                          const SizedBox(height: 10),
                          Text('Пока пусто',
                              style: context.text.rfDewiBold28),
                          const SizedBox(height: 10),
                          Text('Добавьте квест в избранное',
                              style: context.text.rfDewiRegular16),
                        ],
                      ),
                    );
                  }
                  return SliverSafeArea(
                    top: false,
                    sliver: SliverList.separated(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final quest = state.items[index];
                        final isSelected = state.maybeMap(
                          loaded: (state) => state.items
                              .where(
                                  (element) => element.questId == quest.questId)
                              .isNotEmpty,
                          orElse: () => false,
                        );
                        return FavouritesCardWidget(
                          favoriteButton: FavoritesButton(
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
                                            levelOfFear: quest.levelOfFear,
                                            typeOfGame: quest.typeOfGame,
                                            photos: quest.photos,
                                            isNew: quest.isNew,
                                            questId: quest.questId),
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
                                            levelOfFear: quest.levelOfFear,
                                            typeOfGame: quest.typeOfGame,
                                            photos: quest.photos,
                                            isNew: quest.isNew,
                                            questId: quest.questId),
                                      ),
                                    );
                                print('Добавление');
                              }
                            },
                            isLike: isSelected ? true : false,
                          ),
                          onTap: () => context.pushNamed(
                            'quests',
                            pathParameters: {
                              'questId': state.items[index].questId
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
                },
                orElse: () {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text('Добавьте квест',
                          style: context.text.rfDewiBold28),
                    ),
                  );
                },
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 21,
            ),
          ),
        ],
      ),
    );
  }
}
