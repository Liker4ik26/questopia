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
                      leading: IconButton(
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
                      ),
                      expandedHeight: 300,
                      stretch: true,
                      backgroundColor: context.color.backgroundColor,
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
              // SliverToBoxAdapter(
              //   child: Row(
              //     children: [
              //       Text(
              //         'Отзывы',
              //         style: context.text.rfDewiSemiBold16,
              //       ),
              //       const Spacer(),
              //       TextButton(
              //         onPressed: () {},
              //         child: Text(
              //           'Оставить отзыв',
              //           style: context.text.rfDewiSemiBold16.copyWith(
              //             color: context.color.tertiary,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ).paddingSymmetric(horizontal: 24),
              // ),
              // SliverToBoxAdapter(
              //     child:
              //     const SizedBox(height: 18).paddingSymmetric(horizontal: 24)),
              // SliverToBoxAdapter(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: context.color.onTertiary,
              //       borderRadius: BorderRadius.circular(AppDimensions.tinyMedium),
              //     ),
              //     child: Row(
              //       children: [
              //         Text(
              //           '5.0',
              //           style: context.text.rfDewiSemiBold20.copyWith(fontSize: 48),
              //         ),
              //         const SizedBox(width: 12),
              //         Column(
              //           children: [
              //             RatingBar(
              //               itemSize: 16,
              //               initialRating: 3.5,
              //               direction: Axis.horizontal,
              //               allowHalfRating: true,
              //               itemCount: 5,
              //               ratingWidget: RatingWidget(
              //                 full: SvgIcon(
              //                   icon: Assets.iconsFullStar,
              //                   color: context.color.onPrimary,
              //                 ),
              //                 half: SvgIcon(
              //                   icon: Assets.iconsHalfStar,
              //                   color: context.color.onPrimary,
              //                 ),
              //                 empty: SvgIcon(
              //                   icon: Assets.iconsFullStar,
              //                   color: context.color.primary.withOpacity(.12),
              //                 ),
              //               ),
              //               itemPadding: const EdgeInsets.symmetric(horizontal: 2),
              //               onRatingUpdate: (rating) {},
              //             ),
              //             const SizedBox(height: 8),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   '5,0',
              //                   style: context.text.rfDewiSemiBold12,
              //                 ),
              //                 const SizedBox(width: 8),
              //                 Text(
              //                   '325 оценок',
              //                   style: context.text.rfDewiSemiBold12.copyWith(
              //                       color: context.color.primary.withOpacity(.4)),
              //                 ),
              //                 const SizedBox(width: 8),
              //               ],
              //             )
              //           ],
              //         )
              //       ],
              //     ).paddingSymmetric(
              //       horizontal: 16,
              //       vertical: 8,
              //     ),
              //   ).paddingSymmetric(horizontal: 24),
              // ),
              // SliverToBoxAdapter(
              //     child:
              //     const SizedBox(height: 60).paddingSymmetric(horizontal: 24)),
              // SliverToBoxAdapter(
              //   child: SafeArea(
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: context.color.onTertiary,
              //         borderRadius: BorderRadius.circular(AppDimensions.tinyMedium),
              //       ),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               ClipRRect(
              //                 child: CardImage(
              //                   height: 40,
              //                   width: 40,
              //                   borderRadius:
              //                   BorderRadius.circular(AppDimensions.circle),
              //                   imageUrl:
              //                   'https://mykaleidoscope.ru/x/uploads/posts/2022-10/1666362646_46-mykaleidoscope-ru-p-blagodarnost-emotsiya-vkontakte-48.jpg',
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //               const SizedBox(width: 16),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     'Филипп Жмудин',
              //                     style: context.text.rfDewiSemiBold16,
              //                     softWrap: true,
              //                     maxLines: 2,
              //                   ),
              //                   const SizedBox(height: 6),
              //                   Row(
              //                     children: [
              //                       RatingBar(
              //                         itemSize: 16,
              //                         initialRating: 3.5,
              //                         direction: Axis.horizontal,
              //                         allowHalfRating: true,
              //                         itemCount: 5,
              //                         ratingWidget: RatingWidget(
              //                           full: SvgIcon(
              //                             icon: Assets.iconsFullStar,
              //                             color: context.color.onPrimary,
              //                           ),
              //                           half: SvgIcon(
              //                             icon: Assets.iconsHalfStar,
              //                             color: context.color.onPrimary,
              //                           ),
              //                           empty: SvgIcon(
              //                             icon: Assets.iconsFullStar,
              //                             color: context.color.onPrimary
              //                                 .withOpacity(.4),
              //                           ),
              //                         ),
              //                         itemPadding:
              //                         const EdgeInsets.symmetric(horizontal: 2),
              //                         onRatingUpdate: (rating) {},
              //                       ),
              //                       const SizedBox(width: 4),
              //                       Text(
              //                         '24.04.2024',
              //                         style: context.text.rfDewiRegular10.copyWith(
              //                           color:
              //                           context.color.primary.withOpacity(.4),
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ).paddingSymmetric(
              //             horizontal: 16,
              //             vertical: 8,
              //           ),
              //           Text(
              //             'Отличный квест! Море эмоций, интересные загадки, демон крут!) Атмосфера шик, советую к прохождению)',
              //             style: context.text.rfDewiRegular14.copyWith(
              //               color: context.color.primary.withOpacity(.4),
              //             ),
              //           ).paddingOnly(left: 16, right: 16, top: 12, bottom: 16),
              //         ],
              //       ),
              //     ).paddingSymmetric(horizontal: 24),
              //   ),
              // ),
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
