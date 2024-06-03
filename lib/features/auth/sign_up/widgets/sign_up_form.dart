import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/utils/validators.dart';
import 'package:questopia/features/auth/sign_up/bloc/sign_up_bloc.dart';

import '../../../../core/common/widgets/custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            textController: _email,
            textInputAction: TextInputAction.next,
            title: context.tr.signUpScreenEmail,
            validator: (value) {
              return mobileAndEmailValidator(context, value);
            },
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            textController: _password,
            textInputAction: TextInputAction.done,
            title: context.tr.signUpScreenPassword,
            isPassword: true,
            validator: (value) {
              return passwordValidator(
                context,
                value,
              );
            },
          ).paddingSymmetric(horizontal: 24),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
            if (state is SignUpInitialState) {
              return CustomButton(
                title: context.tr.signUpScreenRegister,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpBloc>().add(
                          RegistrationEvent(
                              email: _email.text, password: _password.text),
                        );
                  }
                },
              );
            }
            if (state is SignUpLoadedState) {
              context.go(Routes.home);
            }
            if (state is SignUpLoadingState) {
              return CustomButton(
                child: CircularProgressIndicator(
                  color: context.color.primary,
                ),
              );
            }
            return CustomButton(
              title: context.tr.signUpScreenRegister,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(
                        RegistrationEvent(
                            email: _email.text, password: _password.text),
                      );
                }
              },
            );
          }).paddingOnly(
            left: 24,
            right: 24,
            bottom: 16,
          ),
          CustomButton(
            title: context.tr.signUpScreenGetIntoAccount,
            bgColor: context.color.onTertiary,
            onPressed: () => context.push(Routes.signInRoute),
          ).paddingOnly(
            left: 24,
            right: 24,
            bottom: 16,
          ),
        ],
      ),
    );
  }
}
