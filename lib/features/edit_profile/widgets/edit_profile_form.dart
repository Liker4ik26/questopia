import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/repositories/user/domain/user_domain.dart';
import 'package:questopia/core/utils/validators.dart';
import 'package:questopia/features/edit_profile/bloc/edit_profile_bloc.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fio = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      bloc: context.read<EditProfileBloc>()
        ..add(
          const LoadUserEvent(completer: null),
        ),
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  textController: _fio..text = state.user.fio,
                  hint: 'Введите ФИО',
                  validator: (value) {
                    return emptyValidator(context, value);
                  },
                ).paddingSymmetric(horizontal: 24),
                const SizedBox(height: 14),
                CustomTextField(
                  textInputAction: TextInputAction.done,
                  textController: _phone..text = state.user.phone,
                  textInputType: TextInputType.phone,
                  hint: 'Введите номер телефона',
                  validator: (value) {
                    return mobileValidator(context, value);
                  },
                  inputFormatters: [maskFormatter],
                ).paddingSymmetric(horizontal: 24),
                BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileInitialState) {
                      return CustomButton(
                        title: 'Сохранить',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<EditProfileBloc>().add(
                                  SaveUserEvent(
                                    user: UserDomain(
                                      fio: _fio.text,
                                      phone: _phone.text,
                                    ),
                                  ),
                                );
                          }
                        },
                      );
                    }
                    return CustomButton(
                      title: 'Сохранить',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<EditProfileBloc>().add(
                                SaveUserEvent(
                                  user: UserDomain(
                                    fio: _fio.text,
                                    phone: _phone.text,
                                  ),
                                ),
                              );
                        }
                      },
                    );
                  },
                ).paddingAll(24),
              ],
            ),
          );
        }
        return Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: context.color.tertiary,
            ),
          ),
        );
      },
      listener: (BuildContext context, EditProfileState state) {
        if (state is EditProfileLoadedState) {
          context.pop();
        }
      },
    );
  }
}
