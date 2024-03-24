import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_export.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
    PrefUtils().init()
  ]).then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocProvider(
          create: (context) => ThemeBloc(
            ThemeState(
              themeType: PrefUtils().getThemeData(),
            ),
          ),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                theme: theme,
                title: 'help_me',
                navigatorKey: NavigatorService.navigatorKey,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalizationDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale(
                    'en',
                    '',
                  ),
                ],
                initialRoute: AppRoutes.initialRoute,
                routes: AppRoutes.routes,
              );
            },
          ),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/Features/dashboard/constants.dart';
import 'package:sell_4_u/Features/dashboard/controllers/MenuAppController.dart';
import 'package:sell_4_u/Features/dashboard/screens/main/main_screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_state.dart';
import 'core/helper/bloc_observe/observe.dart';
import 'core/helper/cache/cache_helper.dart';
import 'core/helper/main/cubit/main_cubit.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp(
    options: Constant.options,
  );

  await CacheHelper.init();
  CacheHelper.getData(key: 'uId');
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
      create: (context) => MainCubit(),
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = MainCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Admin Panel',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.white),
              canvasColor: secondaryColor,
            ),
            home: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuAppController(),
                ),
              ],
              child: MainScreen(),
            ),
          );
        },
      ),
    );
  }
}
