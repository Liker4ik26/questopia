import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/common/widgets/card_image.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/generated/assets.dart';

import '../../core/app/navigation/routes.dart';
import '../../core/common/widgets/svg_icon.dart';
import '../home/widgets/quest_card_widget.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.backgroundColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
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
          ).paddingOnly(left: 16),
        ),
        title: Text('Поиск', style: context.text.rfDewiBold28),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Text('Поиск', style: context.text.rfDewiBold28)
                .paddingSymmetric(horizontal: 24),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(
            child: CustomTextField(
              textInputAction: TextInputAction.done,
              hint: 'Введите название квеста...',
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
                return SliverSafeArea(
                  sliver: SliverFillRemaining(
                    hasScrollBody: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.imagesSearchScreen),
                        const SizedBox(height: 10),
                        Text('Введите название квеста',
                            style: context.text.rfDewiRegular16),
                      ],
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
