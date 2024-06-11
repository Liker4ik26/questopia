import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/utils/validators.dart';
import 'package:questopia/features/filters/bloc/filter_bloc.dart';
import 'package:questopia/features/filters/widgets/category_chip.dart';
import 'package:questopia/features/filters/widgets/checkbox_button.dart';
import 'package:questopia/features/filters/widgets/filter_block.dart';
import 'package:questopia/features/home/bloc/home_bloc.dart';

import '../../core/app/styles/dimensions.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen(
      {super.key, required this.homeBloc, required this.filterBloc});

  final HomeBloc homeBloc;
  final FilterBloc filterBloc;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> types = [];
  List<String> categories = [];
  List<int> age = [];
  List<int> levelOfFear = [];
  List<int> difficultyLevel = [];
  TextEditingController countPlayer = TextEditingController(text: '2');
  TextEditingController priceStart = TextEditingController(text: '2000');
  TextEditingController priceEnd = TextEditingController(text: '10000');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isCheckedAnyAge = false;

  bool isChecked18 = false;
  bool isChecked16 = false;
  bool isChecked14 = false;
  bool isChecked12 = false;
  bool isChecked10 = false;
  bool isChecked8 = false;
  bool isChecked7 = false;
  bool isCheckedAnyScary = false;
  bool isCheckedNotScary = false;
  bool isCheckedLittleScary = false;
  bool isCheckedScaryLevel = false;
  bool isCheckedVeryScary = false;
  bool isCheckedAnyComplexity = false;
  bool isCheckedEasy = false;
  bool isCheckedMiddle = false;
  bool isCheckedAboveAverage = false;
  bool isCheckedHard = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.homeBloc,
        ),
        BlocProvider.value(
          value: widget.filterBloc,
        ),
      ],
      child: Builder(
        builder: (context) {
          return Stack(
            children: [
              BlocBuilder<FilterBloc, FilterState>(
                bloc: widget.filterBloc,
                builder: (context, state) {
                  types = state.types;
                  categories = state.categories;
                  countPlayer =
                      TextEditingController(text: state.countPlayer.toString());
                  priceStart =
                      TextEditingController(text: state.priceStart.toString());
                  priceEnd =
                      TextEditingController(text: state.priceEnd.toString());
                  age = state.age;
                  difficultyLevel = state.levelDifficulties;
                  levelOfFear = state.levelScary;

                  return SafeArea(
                    child: Container(
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
                                            backgroundColor:
                                                context.color.onTertiary,
                                            foregroundColor:
                                                context.color.primary),
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
                                          value: types
                                              .contains('Квест в реальности'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (types.contains(
                                                  'Квест в реальности')) {
                                                types.remove(
                                                    'Квест в реальности');
                                              } else {
                                                types.add('Квест в реальности');
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Перформанс',
                                          value: types.contains('Перформанс'),
                                          onChanged: (value) {
                                            setState(() {
                                              if (types
                                                  .contains('Перформанс')) {
                                                types.remove('Перформанс');
                                              } else {
                                                types.add('Перформанс');
                                              }
                                            });
                                          }),
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
                                    title: 'Жанр/Категория',
                                    widgets: [
                                      Wrap(
                                        direction: Axis.horizontal,
                                        spacing: 12,
                                        children: [
                                          CategoryChip(
                                            text: 'Страшные',
                                            selected:
                                                categories.contains('Страшные'),
                                            onSelected: (value) {
                                              setState(() {
                                                if (categories
                                                    .contains('Страшные')) {
                                                  categories.remove('Страшные');
                                                } else {
                                                  categories.add('Страшные');
                                                }
                                              });
                                            },
                                          ),
                                          CategoryChip(
                                              text: 'Антуражные',
                                              selected: categories
                                                  .contains('Антуражные'),
                                              onSelected: (value) {
                                                setState(() {
                                                  if (categories
                                                      .contains('Антуражные')) {
                                                    categories
                                                        .remove('Антуражные');
                                                  } else {
                                                    categories
                                                        .add('Антуражные');
                                                  }
                                                });
                                              }),
                                          CategoryChip(
                                              text: 'Для детей',
                                              selected: categories
                                                  .contains('Для детей'),
                                              onSelected: (value) {
                                                setState(() {
                                                  if (categories
                                                      .contains('Для детей')) {
                                                    categories
                                                        .remove('Для детей');
                                                  } else {
                                                    categories.add('Для детей');
                                                  }
                                                });
                                              }),
                                          CategoryChip(
                                            text: 'Для новичков',
                                            selected: categories
                                                .contains('Для новичков'),
                                            onSelected: (value) {
                                              setState(() {
                                                if (categories
                                                    .contains('Для новичков')) {
                                                  categories
                                                      .remove('Для новичков');
                                                } else {
                                                  categories
                                                      .add('Для новичков');
                                                }
                                              });
                                            },
                                          ),
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
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        FilterBlock(
                                          title: 'Количество игроков',
                                          widgets: [
                                            const SizedBox(height: 14),
                                            CustomTextField(
                                              textController: countPlayer,
                                              bgColor: context.color.onTertiary,
                                              textInputAction:
                                                  TextInputAction.next,
                                              validator: (value) {
                                                return emptyValidator(
                                                    context, value);
                                              },
                                              textInputType:
                                                  TextInputType.phone,
                                              hint:
                                                  'Введите количество человек',
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r"[0-9.]")),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        FilterBlock(
                                          title: 'Цена',
                                          widgets: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    bgColor: context
                                                        .color.onTertiary,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textInputType:
                                                        TextInputType.number,
                                                    textController: priceStart,
                                                    hint: 'От',
                                                    validator: (value) {
                                                      return emptyValidator(
                                                          context, value);
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r"[0-9.]")),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Expanded(
                                                  child: CustomTextField(
                                                    bgColor: context
                                                        .color.onTertiary,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    textController: priceEnd,
                                                    textInputType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      return emptyValidator(
                                                          context, value);
                                                    },
                                                    hint: 'До',
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                              r"[0-9.]")),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
                                              value: isCheckedAnyAge,
                                              onChanged: (value) {
                                                setState(() {
                                                  isCheckedAnyAge = value!;
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '18+',
                                              value: age.contains(18),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(18)) {
                                                    age.remove(18);
                                                  } else {
                                                    age.add(18);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '16+',
                                              value: age.contains(16),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(16)) {
                                                    age.remove(16);
                                                  } else {
                                                    age.add(16);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '14+',
                                              value: age.contains(14),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(14)) {
                                                    age.remove(14);
                                                  } else {
                                                    age.add(14);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '12+',
                                              value: age.contains(12),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(12)) {
                                                    age.remove(12);
                                                  } else {
                                                    age.add(12);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '10+',
                                              value: age.contains(10),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(10)) {
                                                    age.remove(10);
                                                  } else {
                                                    age.add(10);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '8+',
                                              value: age.contains(8),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(8)) {
                                                    age.remove(8);
                                                  } else {
                                                    age.add(8);
                                                  }
                                                });
                                              }),
                                          CheckboxButton(
                                              title: '7+',
                                              value: age.contains(7),
                                              onChanged: (value) {
                                                setState(() {
                                                  if (age.contains(7)) {
                                                    age.remove(7);
                                                  } else {
                                                    age.add(7);
                                                  }
                                                });
                                              }),
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
                                          title: 'Любой',
                                          value: isCheckedAnyScary,
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckedAnyScary = value!;
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Не страшный',
                                          value: levelOfFear.contains(0),
                                          onChanged: (value) {
                                            setState(() {
                                              if (levelOfFear.contains(0)) {
                                                levelOfFear.remove(0);
                                              } else {
                                                levelOfFear.add(0);
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Немного страшный',
                                          value: isCheckedLittleScary,
                                          onChanged: (value) {
                                            setState(() {
                                              if (levelOfFear.contains(1)) {
                                                levelOfFear.remove(1);
                                                isCheckedLittleScary = false;
                                              } else {
                                                levelOfFear.add(1);
                                                isCheckedLittleScary = true;
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Страшный',
                                          value: levelOfFear.contains(3),
                                          onChanged: (value) {
                                            setState(() {
                                              if (levelOfFear.contains(3)) {
                                                levelOfFear.remove(3);
                                              } else {
                                                levelOfFear.add(3);
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Очень страшный',
                                          value: levelOfFear.contains(4),
                                          onChanged: (value) {
                                            setState(() {
                                              if (levelOfFear.contains(4)) {
                                                levelOfFear.remove(4);
                                              } else {
                                                levelOfFear.add(4);
                                              }
                                            });
                                          }),
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
                                          title: 'Любой',
                                          value: isCheckedAnyComplexity,
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckedAnyComplexity = value!;
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Простые ',
                                          value: isCheckedEasy,
                                          onChanged: (value) {
                                            setState(() {
                                              if (difficultyLevel.contains(1)) {
                                                difficultyLevel.remove(1);
                                                isCheckedEasy = false;
                                              } else {
                                                difficultyLevel.add(1);
                                                isCheckedEasy = true;
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Средней сложности',
                                          value: isCheckedMiddle,
                                          onChanged: (value) {
                                            setState(() {
                                              if (difficultyLevel.contains(2)) {
                                                difficultyLevel.remove(2);
                                                isCheckedMiddle = false;
                                              } else {
                                                difficultyLevel.add(2);
                                                isCheckedMiddle = true;
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Сложный',
                                          value: isCheckedAboveAverage,
                                          onChanged: (value) {
                                            setState(() {
                                              if (difficultyLevel.contains(3)) {
                                                difficultyLevel.remove(3);
                                                isCheckedAboveAverage = false;
                                              } else {
                                                difficultyLevel.add(3);
                                                isCheckedAboveAverage = true;
                                              }
                                            });
                                          }),
                                      CheckboxButton(
                                          title: 'Очень Сложный',
                                          value: isCheckedHard,
                                          onChanged: (value) {
                                            setState(() {
                                              if (difficultyLevel.contains(4)) {
                                                difficultyLevel.remove(4);
                                                isCheckedHard = false;
                                              } else {
                                                difficultyLevel.add(4);
                                                isCheckedHard = true;
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                const SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: 36,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Container(
                    color: context.color.onSecondary,
                    child: CustomButton(
                      title: 'Показать',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<FilterBloc>().add(
                                FilterChangedEvent(
                                  types: types,
                                  priceStart: int.parse(priceStart.text),
                                  priceEnd: int.parse(priceEnd.text),
                                  age: age,
                                  levelScary: levelOfFear,
                                  levelDifficulties: difficultyLevel,
                                  categories: categories,
                                  countPlayer: int.parse(countPlayer.text),
                                ),
                              );
                          print(types);
                          context.read<HomeBloc>().add(
                                LoadFilterQuestsEvent(
                                  types: types,
                                  priceStart: int.parse(priceStart.text),
                                  priceEnd: int.parse(priceEnd.text),
                                  age: age,
                                  levelScary: levelOfFear,
                                  levelDifficulties: difficultyLevel,
                                  categories: categories,
                                  countPlayer: int.parse(countPlayer.text),
                                ),
                              );
                          context.pop();
                        }
                      },
                    ).paddingAll(24),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
