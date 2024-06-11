import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:questopia/core/app/app.dart';
import 'package:questopia/core/database/model/quest_entity.dart';
import 'package:questopia/core/repositories/auth/data/remote/supabase_api.dart';
import 'package:questopia/core/repositories/quests/data/remote/quests_api.dart';
import 'package:questopia/core/repositories/reserved_quest/data/remote/reserved_quests_api.dart';
import 'package:questopia/core/repositories/slots/data/remote/slots_api.dart';
import 'package:questopia/core/repositories/user/data/remote/user_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Hive.initFlutter();

  Hive.registerAdapter(QuestEntityAdapter());
  await Hive.openBox<QuestEntity>('quest_box');
  await Permission.location.isDenied.then((value) {
    if (value) {
      Permission.location.request();
    }
  });
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  GetIt.I.registerLazySingletonAsync<Supabase>(
    () => Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    ),
  );
  await GetIt.I.getAsync<Supabase>();
  GetIt.I.isReady<Supabase>();

  GetIt.I
    ..registerLazySingleton(
      () => SupabaseApi(
        supabase: GetIt.I.get<Supabase>(),
        url: dotenv.env['SUPABASE_URL']!,
        apiKey: dotenv.env['SUPABASE_ANON_KEY']!,
      ),
    )
    ..registerLazySingleton(
      () => QuestApi(
        supabase: GetIt.I.get<Supabase>(),
        url: dotenv.env['SUPABASE_URL']!,
        apiKey: dotenv.env['SUPABASE_ANON_KEY']!,
      ),
    )
    ..registerLazySingleton(
      () => UserApi(
        supabase: GetIt.I.get<Supabase>(),
        url: dotenv.env['SUPABASE_URL']!,
        apiKey: dotenv.env['SUPABASE_ANON_KEY']!,
      ),
    )
    ..registerLazySingleton(
      () => SlotsApi(
        supabase: GetIt.I.get<Supabase>(),
        url: dotenv.env['SUPABASE_URL']!,
        apiKey: dotenv.env['SUPABASE_ANON_KEY']!,
      ),
    )
    ..registerLazySingleton(
      () => ReservedQuestApi(
        supabase: GetIt.I.get<Supabase>(),
        url: dotenv.env['SUPABASE_URL']!,
        apiKey: dotenv.env['SUPABASE_ANON_KEY']!,
      ),
    );

  runApp(const App());
}
