import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/common/widgets/custom_button.dart';
import 'package:questopia/core/common/widgets/custom_text_field.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/core/utils/validators.dart';
import 'package:questopia/features/auth/sign_in/bloc/sign_in_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
          BlocConsumer<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInInitialState) {
                return CustomButton(
                  title: context.tr.signScreenLogIn,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInBloc>().add(
                            LogInEvent(
                                email: _email.text, password: _password.text),
                          );
                    }
                  },
                );
              }
              if (state is SignInLoadingState) {
                return CustomButton(
                  child: CircularProgressIndicator(
                    color: context.color.primary,
                  ),
                );
              }
              return CustomButton(
                title: context.tr.signScreenLogIn,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignInBloc>().add(
                          LogInEvent(
                              email: _email.text, password: _password.text),
                        );
                  }
                },
              );
            },
            listener: (context, state) {
              if (state is SignInLoadedState) {
                context.go(Routes.home);
              }
            },
          ).paddingOnly(
            left: 24,
            right: 24,
            bottom: 16,
          ),
          CustomButton(
            title: context.tr.signUpScreenRegister,
            bgColor: context.color.onTertiary,
            onPressed: () => context.push(Routes.signUpRoute),
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
