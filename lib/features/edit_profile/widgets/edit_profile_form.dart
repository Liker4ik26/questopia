import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 24),
          CustomTextField(
            textInputAction: TextInputAction.next,
            textController: _fio,
            title: 'ФИО',
            validator: (value) {
              return emptyValidator(context, value);
            },
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(height: 14),
          CustomTextField(
            textInputAction: TextInputAction.done,
            textController: _phone,
            prefixText: '+7 ',
            hint: '(000) 000-00-00',
            title: 'Телефон',
            validator: (value) {
              return mobileValidator(context, '+7 $value');
            },
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: 'RU',
              ),
            ],
          ).paddingSymmetric(horizontal: 24),
          BlocConsumer<EditProfileBloc, EditProfileState>(
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
                                phone: '+7 ${_phone.text}',
                              ),
                            ),
                          );
                    }
                  },
                );
              }
              if (state is EditProfileLoadingState) {
                return CustomButton(
                  child: CircularProgressIndicator(
                    color: context.color.primary,
                  ),
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
                              phone: '+7 ${_phone.text}',
                            ),
                          ),
                        );
                  }
                },
              );
            },
            listener: (BuildContext context, EditProfileState state) {
              if (state is EditProfileLoadedState) {
                context.pop();
              }
            },
          ).paddingAll(24),
        ],
      ),
    );
  }
}
