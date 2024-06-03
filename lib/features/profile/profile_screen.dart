import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';

import '../../../generated/assets.dart';
import '../../core/app/navigation/routes.dart';
import '../../core/app/styles/dimensions.dart';
import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.color.backgroundColor,
          appBar: AppBar(
            backgroundColor: context.color.backgroundColor,
            actions: [
              IconButton(
                onPressed: () {
                  context.push(Routes.editProfileRoute);
                  context.read<ProfileBloc>().add(
                        const LoadUserEvent(completer: null),
                      );
                },
                icon: SvgIcon(
                  icon: Assets.iconsPen,
                  color: context.color.primary,
                ),
              ).paddingOnly(right: 16),
            ],
            title: Text(
              'Профиль',
              style: context.text.rfDewiBold28,
            ).paddingOnly(
              left: 16,
            ),
          ),
          body: RefreshIndicator(
            color: context.color.tertiary,
            onRefresh: () {
              final completer = Completer();
              context.read<ProfileBloc>().add(
                    LoadUserEvent(completer: completer),
                  );
              return completer.future;
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              bloc: context.read<ProfileBloc>()
                ..add(
                  const LoadUserEvent(completer: null),
                ),
              builder: (context, state) {
                if (state is ProfileLoadedState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        title: 'ФИО',
                        textController:
                            TextEditingController(text: state.user.fio),
                        enabled: false,
                      ).paddingSymmetric(horizontal: 24),
                      const SizedBox(height: 14),
                      CustomTextField(
                        textInputAction: TextInputAction.next,
                        title: 'Почта',
                        textController:
                            TextEditingController(text: state.user.email),
                        enabled: false,
                      ).paddingSymmetric(horizontal: 24),
                      const SizedBox(height: 14),
                      CustomTextField(
                        textInputAction: TextInputAction.done,
                        title: 'Телефон',
                        textController:
                            TextEditingController(text: state.user.phone),
                        enabled: false,
                      ).paddingSymmetric(horizontal: 24),
                      const SizedBox(height: 16),
                      ListTile(
                        onTap: () => context.push(Routes.reservedQuestRoute),
                        leading: SvgIcon(
                          icon: Assets.iconsNarrativeActive,
                          color: context.color.primary,
                        ).paddingOnly(left: 12),
                        trailing: SvgIcon(
                          icon: Assets.iconsChevronLeftSmall,
                          color: context.color.primary,
                        ).paddingOnly(left: 12),
                        title: Text(
                          'Забронировать квесты',
                          style: context.text.rfDewiSemiBold16,
                        ),
                      ),
                      BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                          if (state is LogOutSuccessState) {
                            context.pushReplacement(Routes.signInRoute);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.medium,
                                  ),
                                ),
                                backgroundColor:
                                    context.color.tertiary.withOpacity(.4),
                                content: const Text(
                                  'Вы вышли из системы',
                                ),
                              ),
                            );
                          }
                          if (state is LogOutErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.medium,
                                  ),
                                ),
                                backgroundColor:
                                    context.color.error.withOpacity(.4),
                                content: Text(
                                  'При выходе из аккаунта произошла ошибка: ${state.error.toString()}',
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is ProfileInitialState) {
                            return ListTile(
                              onTap: () {
                                context.pushReplacement(Routes.signInRoute);
                                context
                                    .read<ProfileBloc>()
                                    .add(const LogOutEvent());
                              },
                              leading: SvgIcon(
                                icon: Assets.iconsDoorArrowLeft,
                                color: context.color.primary,
                              ).paddingOnly(left: 12),
                              trailing: SvgIcon(
                                icon: Assets.iconsChevronLeftSmall,
                                color: context.color.primary,
                              ).paddingOnly(left: 12),
                              title: Text(
                                'Выход',
                                style: context.text.rfDewiSemiBold16,
                              ),
                            );
                          }
                          if (state is LogOutLoadingState) {
                            return SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: context.color.primary,
                              ),
                            );
                          }

                          return ListTile(
                            onTap: () {
                              context.pushReplacement(Routes.signInRoute);
                              context
                                  .read<ProfileBloc>()
                                  .add(const LogOutEvent());
                            },
                            leading: SvgIcon(
                              icon: Assets.iconsDoorArrowLeft,
                              color: context.color.primary,
                            ).paddingOnly(left: 12),
                            trailing: SvgIcon(
                              icon: Assets.iconsChevronLeftSmall,
                              color: context.color.primary,
                            ).paddingOnly(left: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.tinyMedium),
                            ),
                            title: Text(
                              'Выход',
                              style: context.text.rfDewiSemiBold16,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                if (state is ProfileErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.error.toString(),
                          style: context.text.rfDewiBold16,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => context.read<ProfileBloc>().add(
                                const LoadUserEvent(completer: null),
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
                return Center(
                  child: CircularProgressIndicator(
                    color: context.color.tertiary,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
