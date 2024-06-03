import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/filters/widgets/category_chip.dart';
import 'package:questopia/features/filters/widgets/checkbox_button.dart';
import 'package:questopia/features/filters/widgets/filter_block.dart';

import '../../core/app/styles/dimensions.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.onSecondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.medium),
          topRight: Radius.circular(AppDimensions.medium),
        ),
      ),
      alignment: Alignment.center,
      child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: .9,
          minChildSize: .6,
          snap: true,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  backgroundColor: context.color.onSecondary,
                  flexibleSpace: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Фильтры',
                        style: context.text.rfDewiBold28,
                      ),
                      const Spacer(),
                      IconButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: context.color.onTertiary,
                            foregroundColor: context.color.primary),
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 24),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Тип игры',
                    widgets: [
                      CheckboxButton(
                          title: 'Квест в реальности',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Перфоманс',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Экшн-игра',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'VR-квест',
                          value: false,
                          onChanged: (bool) {}),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Жанр/Категория',
                    widgets: [
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 12,
                        children: [
                          CategoryChip(text: 'Страшные', selected: true),
                          CategoryChip(text: 'Антуражные', selected: false),
                          CategoryChip(text: 'Для детей', selected: false),
                          CategoryChip(text: 'Сложные', selected: false),
                          CategoryChip(text: 'Для новичков', selected: true),
                        ],
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Данные о событии',
                    widgets: [
                      CustomTextField(
                        bgColor: context.color.onTertiary,
                        textInputAction: TextInputAction.next,
                        title: 'Дата',
                        hint: 'Выберите дату',
                        textInputType: TextInputType.datetime,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.calendar_month,
                            color: context.color.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        bgColor: context.color.onTertiary,
                        textInputAction: TextInputAction.next,
                        title: 'Время',
                        hint: 'Выберите время',
                        textInputType: TextInputType.datetime,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.access_time,
                            color: context.color.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        bgColor: context.color.onTertiary,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        title: 'Количество человек',
                        hint: '3',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        ],
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Цена',
                    widgets: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              bgColor: context.color.onTertiary,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              title: 'От',
                              hint: '0 ₽ ',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: CustomTextField(
                              bgColor: context.color.onTertiary,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              title: 'До',
                              hint: '1000 ₽ ',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[0-9.]")),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Возраст',
                    widgets: [
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          CheckboxButton(
                              title: 'Любой',
                              value: false,
                              onChanged: (bool) {}),
                          CheckboxButton(
                              title: '18+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '16+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '14+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '12+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '10+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '8+', value: false, onChanged: (bool) {}),
                          CheckboxButton(
                              title: '6+', value: false, onChanged: (bool) {}),
                        ],
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Уровень страха',
                    widgets: [
                      CheckboxButton(
                          title: 'Любой', value: false, onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Не страшный',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Страшный',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Немного страшный',
                          value: false,
                          onChanged: (bool) {}),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 24,
                  ),
                ),
                SliverToBoxAdapter(
                  child: FilterBlock(
                    title: 'Уровень сложности',
                    widgets: [
                      CheckboxButton(
                          title: 'Любой', value: false, onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Простые ',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Средней сложности',
                          value: false,
                          onChanged: (bool) {}),
                      CheckboxButton(
                          title: 'Сложные', value: false, onChanged: (bool) {}),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 36,
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SafeArea(
                    child: CustomButton(title: 'Показать'),
                  ).paddingAll(24),
                ),
              ],
            );
          }),
    );
  }
}
