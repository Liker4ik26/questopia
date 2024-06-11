import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/common/widgets/svg_icon.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/features/profile/widgets/exit_alert_dialog.dart';

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
        return Builder(builder: (context) {
          return BlocListener<ProfileBloc, ProfileState>(
            bloc: context.read<ProfileBloc>(),
            listener: (context, state) {
              if (state is LogOutSuccessState) {
                context.pushReplacement(Routes.signInRoute);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.medium,
                      ),
                    ),
                    backgroundColor: context.color.tertiary,
                    content: const Text(
                      'Вы вышли из системы',
                    ),
                  ),
                );
              }
              if (state is LogOutErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.medium,
                      ),
                    ),
                    backgroundColor: context.color.error,
                    content: Text(
                      'При выходе из аккаунта произошла ошибка: ${state.error.toString()}',
                    ),
                  ),
                );
              }
            },
            child: Scaffold(
              backgroundColor: context.color.backgroundColor,
              appBar: AppBar(
                toolbarHeight: 100,
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
                            hint: 'Введите ФИО',
                            textController:
                                TextEditingController(text: state.user.fio),
                            enabled: false,
                          ).paddingSymmetric(horizontal: 24),
                          const SizedBox(height: 14),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            hint: 'Введите почту',
                            textController:
                                TextEditingController(text: state.user.email),
                            enabled: false,
                          ).paddingSymmetric(horizontal: 24),
                          const SizedBox(height: 14),
                          CustomTextField(
                            textInputAction: TextInputAction.done,
                            hint: 'Введите номер телефона',
                            textController:
                                TextEditingController(text: state.user.phone),
                            enabled: false,
                          ).paddingSymmetric(horizontal: 24),
                          const SizedBox(height: 16),
                          ListTile(
                            onTap: () =>
                                context.push(Routes.reservedQuestRoute),
                            leading: SvgIcon(
                              icon: Assets.iconsNarrativeActive,
                              color: context.color.primary,
                            ).paddingOnly(left: 12),
                            trailing: SvgIcon(
                              icon: Assets.iconsChevronLeftSmall,
                              color: context.color.primary,
                            ).paddingOnly(left: 12),
                            title: Text(
                              'Забронированные квесты',
                              style: context.text.rfDewiSemiBold16,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext contextInner) {
                                  return BlocProvider(
                                    create: (context) => ProfileBloc(
                                        userRepository:
                                            context.read<UserRepository>()),
                                    child: ExitDialogWidget(
                                      onPressed: () {
                                        context.read<ProfileBloc>().add(
                                              const LogOutEvent(),
                                            );
                                      },
                                    ),
                                  );
                                },
                              );
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
            ),
          );
        });
      },
    );
  }
}
