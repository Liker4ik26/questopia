import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:questopia/features/edit_profile/widgets/edit_profile_form.dart';

import '../../core/app/styles/dimensions.dart';
import '../../core/common/widgets/svg_icon.dart';
import '../../generated/assets.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: context.color.backgroundColor,
        automaticallyImplyLeading: false,
        leadingWidth: 68,
        leading: Center(
          child: IconButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: context.color.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.tinyMedium),
              ),
            ),
            icon: SvgIcon(
              icon: Assets.iconsChevronLeft,
              color: context.color.primary,
            ),
            onPressed: () => context.pop(),
          ).paddingOnly(left: 24),
        ),
        title: Text('Редактирование', style: context.text.rfDewiBold28),
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileErrorState) {
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
                  'При сохранении произошла ошибка: ${state.error.toString()}',
                ),
              ),
            );
            print(state.error.toString());
          }
          if (state is EditProfileLoadedState) {
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
                  'Данные успешно обновлены',
                ),
              ),
            );
          }
        },
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
