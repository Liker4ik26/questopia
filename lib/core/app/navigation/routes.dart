import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:questopia/core/common/main/main_wrapper.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository.dart';
import 'package:questopia/core/repositories/quests/data/quests_repository.dart';
import 'package:questopia/core/repositories/reserved_quest/data/reserved_quest_repository.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:questopia/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:questopia/features/favourites/favourites_screen.dart';
import 'package:questopia/features/home/bloc/home_bloc.dart';
import 'package:questopia/features/home/home_screen.dart';
import 'package:questopia/features/profile/bloc/profile_bloc.dart';
import 'package:questopia/features/reservations/blocs/reserved_slots/reserved_slots_bloc.dart';
import 'package:questopia/features/reserved_quest/bloc/reserved_quest_bloc.dart';
import 'package:questopia/features/reserved_quest/reserved_quest.dart';
import 'package:questopia/features/search/bloc/search_bloc.dart';

import '../../../features/auth/sign_in/bloc/sign_in_bloc.dart';
import '../../../features/auth/sign_in/sign_in_screen.dart';
import '../../../features/auth/sign_up/sign_up_screen.dart';
import '../../../features/details_quest/bloc/details_quest_bloc.dart';
import '../../../features/details_quest/details_quest_screen.dart';
import '../../../features/edit_profile/edit_profile_screen.dart';
import '../../../features/profile/profile_screen.dart';
import '../../../features/search/search_profile.dart';

export 'package:go_router/go_router.dart';

abstract class Routes {
  const Routes._();

  static const home = '/';
  static const questRoute = '/quests/:questId';
  static const signInRoute = '/sign_in';
  static const signUpRoute = '/sign_up';
  static const detailsQuestRoute = '/details_quest';
  static const profileRoute = '/profile';
  static const editProfileRoute = '/edit_profile';
  static const reservedQuestRoute = '/reserved_quest_route';
  static const searchRoute = '/search';
  static const favouritesRoute = '/favourites';

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
    // redirect: (context, state) {
    //   BlocSelector<AppUserCubit, AppUserState, bool>(
    //     selector: (state) {
    //       return state is AppUserLoggedIn;
    //     },
    //     builder: (context, isLoggedIn) {
    //       if (isLoggedIn) {
    //         return home;
    //       }
    //       return GoRoute(path: signInRoute;
    //     },
    //   );
    //   return null;
    // },
    routes: [
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                pageBuilder: _defaultPageBuilder(MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => HomeBloc(
                        questRepository: context.read<QuestRepository>(),
                      ),
                    ),
                  ],
                  child: const HomeScreen(),
                )),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: favouritesRoute,
                pageBuilder: _defaultPageBuilder(
                  const FavouritesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: profileRoute,
                pageBuilder: _defaultPageBuilder(
                  BlocProvider(
                    create: (context) => ProfileBloc(
                        userRepository: context.read<UserRepository>()),
                    child: const ProfileScreen(),
                  ),
                ),
              ),
            ],
          ),
        ],
        builder: (context, state, navigationShell) {
          return MainWrapper(
            child: navigationShell,
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: editProfileRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) =>
                EditProfileBloc(userRepository: context.read<UserRepository>()),
            child: const EditProfileScreen(),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: reservedQuestRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) => ReservedQuestBloc(
                reservedQuestRepository:
                    context.read<ReservedQuestRepository>()),
            child: const ReservedQuestScreen(),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: searchRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) =>
                SearchBloc(questRepository: context.read<QuestRepository>()),
            child: const SearchScreen(),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: signInRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) =>
                SignInBloc(authRepository: context.read<AuthRepository>()),
            child: const SignInScreen(),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: signUpRoute,
        pageBuilder: _defaultPageBuilder(
          BlocProvider(
            create: (context) => SignUpBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: const SignUpScreen(),
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: questRoute,
        name: 'quests',
        pageBuilder: (context, state) {
          return _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ReservedSlotsBloc(
                      slotsRepository: context.read<SlotsRepository>()),
                ),
                BlocProvider(
                  create: (context) => DetailsQuestBloc(
                    questRepository: context.read<QuestRepository>(),
                  ),
                ),
              ],
              child: DetailsQuestScreen(
                  questId: state.pathParameters['questId']!),
            ),
          );
        },
      ),
    ],
  );
}
