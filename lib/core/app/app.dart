import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:questopia/core/app/styles/themes.dart';
import 'package:questopia/core/common/cubit/auth/auth_cubit.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository.dart';
import 'package:questopia/core/repositories/auth/data/auth_repository_impl.dart';
import 'package:questopia/core/repositories/auth/data/remote/supabase_api.dart';
import 'package:questopia/core/repositories/local_database/data/local_database_repository.dart';
import 'package:questopia/core/repositories/local_database/data/local_database_repository_impl.dart';
import 'package:questopia/core/repositories/quests/data/quests_repository_impl.dart';
import 'package:questopia/core/repositories/quests/data/remote/quests_api.dart';
import 'package:questopia/core/repositories/reserved_quest/data/reserved_quest_repository.dart';
import 'package:questopia/core/repositories/slots/data/remote/slots_api.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository.dart';
import 'package:questopia/core/repositories/slots/data/slots_repository_impl.dart';
import 'package:questopia/core/repositories/user/data/remote/user_api.dart';
import 'package:questopia/core/repositories/user/data/user_repository.dart';
import 'package:questopia/core/repositories/user/data/user_repository_impl.dart';
import 'package:questopia/features/favourites/bloc/favourites_bloc.dart';

import '../../features/reserved_quest/bloc/reserved_quest_bloc.dart';
import '../repositories/quests/data/quests_repository.dart';
import '../repositories/reserved_quest/data/remote/reserved_quests_api.dart';
import '../repositories/reserved_quest/data/reserved_quest_repository_impl.dart';
import 'navigation/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(supabaseApi: GetIt.I.get<SupabaseApi>()),
        ),
        RepositoryProvider<QuestRepository>(
          create: (context) =>
              QuestRepositoryImpl(questApi: GetIt.I.get<QuestApi>()),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepositoryImpl(userApi: GetIt.I.get<UserApi>()),
        ),
        RepositoryProvider<SlotsRepository>(
          create: (context) =>
              SlotsRepositoryImpl(slotsApi: GetIt.I.get<SlotsApi>()),
        ),
        RepositoryProvider<ReservedQuestRepository>(
          create: (context) => ReservedQuestRepositoryImpl(
              reservedQuestApi: GetIt.I.get<ReservedQuestApi>()),
        ),
        RepositoryProvider<LocalDatabaseRepository>(
          create: (context) => LocalDatabaseRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FavouritesBloc(
              localDatabaseRepository: context.read<LocalDatabaseRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ReservedQuestBloc(
                reservedQuestRepository:
                    context.read<ReservedQuestRepository>()),
          ),
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
        ],
        child: KeyboardDismisser(
          gestures: const [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection
          ],
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              Routes.router(context).refresh();
            },
            builder: (context, state) {
              return MaterialApp.router(
                theme: AppThemes.dark,
                debugShowCheckedModeBanner: false,
                routerConfig: Routes.router(context),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          ),
        ),
      ),
    );
  }
}
