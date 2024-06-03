import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:questopia/core/app/navigation/routes.dart';
import 'package:questopia/core/app/styles/dimensions.dart';
import 'package:questopia/core/extensions/context_extensions.dart';
import 'package:questopia/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:questopia/features/auth/sign_up/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.backgroundColor,
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpErrorState) {
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
          if (state is SignUpLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.medium,
                  ),
                ),
                backgroundColor: context.color.tertiary.withOpacity(.4),
                content: Text(
                  context.tr.signUpScreenYouRegistered,
                ),
              ),
            );
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.signUpScreenTitle,
                style: context.text.rfDewiBold28,
              ).paddingAll(24),
              const SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}
