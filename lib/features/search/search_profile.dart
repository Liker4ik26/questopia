import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/card_image.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../core/app/navigation/routes.dart';
import '../home/widgets/quest_card_widget.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: context.color.backgroundColor,
        title: Text(
          'Назад',
          style: context.text.rfDewiRegular16,
        ),
        leading: IconButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: context.color.onSecondary,
          ),
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
          color: context.color.primary,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: Text('Поиск', style: context.text.rfDewiBold28)
                .paddingSymmetric(horizontal: 24),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: CustomTextField(
              textInputAction: TextInputAction.done,
              title: '',
              hint: 'Поиск',
              onChanged: (value) {
                return context.read<SearchBloc>().add(
                      SearchNewsEvent(query: value),
                    );
              },
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: context.color.primary,
                ),
              ),
            ).paddingSymmetric(horizontal: 24),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
          BlocBuilder(
            bloc: context.read<SearchBloc>(),
            builder: (context, state) {
              if (state is SearchInitialState) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      '',
                    ),
                  ),
                );
              }

              if (state is SearchErrorState) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      state.error.toString(),
                      style: context.text.rfDewiBold16,
                    ),
                  ),
                );
              }

              if (state is SearchLoadedState) {
                if (state.quests.isEmpty) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          CardImage(
                            imageUrl:
                                'https://cdn0.iconfinder.com/data/icons/file-and-document-41/100/file_document_doc-23-1024.png',
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.tinyMedium),
                            ),
                            backgroundColor: context.color.secondary,
                            fit: BoxFit.contain,
                          ).paddingSymmetric(vertical: 24),
                          Text(
                            'Ничего не найдено',
                            style: context.text.rfDewiBold16,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SliverSafeArea(
                  top: false,
                  sliver: SliverList.separated(
                    itemCount: state.quests.length,
                    itemBuilder: (context, index) {
                      final quest = state.quests[index];
                      return QuestCardWidget(
                        onTap: () => context.pushNamed(
                          'quests',
                          pathParameters: {'questId': state.quests[index].id},
                        ),
                        questDomain: quest,
                      ).paddingSymmetric(horizontal: 24);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
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
    );
  }
}
