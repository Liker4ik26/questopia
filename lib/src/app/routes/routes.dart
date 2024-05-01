import 'package:flutter/material.dart';
import 'package:questopia/src/app/routes/routes.dart';
import 'package:questopia/src/pages/auth/sign_in/sign_in_screen.dart';

export 'package:go_router/go_router.dart';

abstract class Routes {
  const Routes._();
  static const signInRoute = '/signIn';
  static const mainRoute = '/main';

  static CustomTransitionPage _buildPageWithDefaultTransition<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    fullscreenDialog = false,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      fullscreenDialog: fullscreenDialog,
      transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
          ) {
        animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  static Page<dynamic> Function(BuildContext, GoRouterState)
  _defaultPageBuilder<T>(Widget child) => (context, state) {
    return _buildPageWithDefaultTransition<T>(
      context: context,
      state: state,
      child: child,
    );
  };

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: signInRoute,
    navigatorKey: _rootNavigatorKey,
    // refreshListenable: Get.find<AuthController>().isLoggedIn,
    // redirect: (context, state) {
    //   final controller = Get.find<AuthController>();
    //   final loggedIn = controller.isLoggedIn.value;
    //   final profileNotFilled = controller.profileNotFilled;
    //   final authType = controller.authType;
    //
    //   final newPath = state.uri.path;
    //
    //   print(
    //     'logged in: $loggedIn, notFilled: $profileNotFilled, authType: $authType',
    //   );
    //
    //   print(newPath);
    //   final inviterId = state.uri.queryParameters['ref'];
    //   if (inviterId != null) {
    //     print('inviterId: $inviterId');
    //   }
    //   if (!loggedIn || authType == AuthType.guest && inviterId != null) {
    //     if (newPath != splashRoute) {
    //       Get.find<AuthController>().guestLogin(inviterId);
    //     }
    //     return splashRoute;
    //   }
    //   // if the user is not logged in, they need to login
    //   final loggingIn = newPath == signInRoute ||
    //       newPath == confirmationRoute ||
    //       newPath == personalInformationRoute;
    //   if (!loggedIn || authType == AuthType.guest) {
    //     return loggingIn ? null : signInRoute;
    //   }
    //
    //   if (profileNotFilled) {
    //     return loggingIn ? null : personalInformationRoute;
    //   }
    //
    //   // Redirect to settings if user is not loaded todo load user in that route
    //   if (Get.find<ProfileScreenController>().user.data == null &&
    //       newPath == profilePersonalInfoRoute) {
    //     return profileSettingsRoute;
    //   }
    //
    //   if (loggedIn && authType != AuthType.guest && loggingIn) {
    //     return mainRoute;
    //   }
    //
    //   // no need to redirect at all
    //   return null;
    // },
    routes: [
      GoRoute(
        path: signInRoute,
        pageBuilder: _defaultPageBuilder(const SignInScreen()),
      ),
    ],
  );
}
