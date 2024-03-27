import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/Features/dashboard/constants.dart';

import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_state.dart';

import 'Admin/Features/Block-user-feature/view/screens/Block-user-Screen.dart';
import 'Features/dashboard/controllers/MenuAppController.dart';
import 'Features/dashboard/screens/main/main_screen.dart';
import 'core/helper/bloc_observe/observe.dart';
import 'core/helper/cache/cache_helper.dart';
import 'core/helper/main/cubit/main_cubit.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp(
    options: Constant.options,
  );

  await CacheHelper.init();
  CacheHelper.getData(key: 'uId');

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp(
    language: CacheHelper.getData(key: 'language') ?? 'en',
  ));
}

class MyApp extends StatelessWidget {
  String language;

  MyApp({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()
        ..changeAppLang(fromSharedLang: language),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Admin Panel',

            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuAppController(),
                ),
              ],
              child: MainScreen(),
            ),
            locale:Locale("en"),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}