import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:questopia/features/edit_profile/widgets/edit_profile_form.dart';

import '../../core/app/styles/dimensions.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.error.withOpacity(.4),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.tertiary.withOpacity(.4),
                content: const Text(
                  'Данные успешно обновлены',
                ),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Редактирование', style: context.text.rfDewiBold28)
                  .paddingSymmetric(horizontal: 24),
              const EditProfileForm(),
            ],
          ),
        ),
      ),
    );
  }
}
