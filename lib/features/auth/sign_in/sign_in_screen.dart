import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:questopia/features/auth/sign_in/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.backgroundColor,
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.error.withOpacity(.4),
                content: Text(
                  context.tr.signUpScreenErrorHasOccurred +
                      state.error.toString() +
                      context.tr.signUpScreenRetry,
                ),
              ),
            );
          }
          if (state is SignInLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.tertiary.withOpacity(.4),
                content: const Text('Успешная авторизация'),
              ),
            );
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.signScreenTitle,
                style: context.text.rfDewiBold28,
              ).paddingAll(24),
              const SignInForm(),
            ],
          ),
        ),
      ),
    );
  }
}
