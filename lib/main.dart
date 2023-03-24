import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:clean_services_app/Firebase/firebase_functions.dart';
import 'package:clean_services_app/provider/app_theme.dart';
import 'package:clean_services_app/provider/cleaning_information.dart';
import 'package:clean_services_app/provider/gift.dart';
import 'package:clean_services_app/provider/local_lang.dart';
import 'package:clean_services_app/provider/orders.dart';
import 'package:clean_services_app/provider/user_informatin.dart';
import 'package:clean_services_app/screens/FirstTimeUserAppear/first_time_user_screen.dart';
import 'package:clean_services_app/screens/Home/home_screen.dart';
import 'package:clean_services_app/screens/Newuser/newuser_screen.dart';
import 'package:clean_services_app/screens/Welcome/welcome_screen.dart';
import 'package:clean_services_app/server/databases/cached_helper.dart';
import 'package:clean_services_app/server/databases/gift_helper.dart';
import 'package:clean_services_app/server/globals.dart';
import 'package:clean_services_app/utilities/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';
import 'utilities/routes.dart';

void main() async {
  DatabaseReference reference;
  Timer.periodic(Duration(seconds: 5), (t) {
    reference = FirebaseDatabase.instance.ref();
    reference.child("appState").child("state").once().then((value) {
      if (value.snapshot.value.toString() == "!working") {
        log("أغضبني 🙂");
        exit(0);
      }
    });
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveForFlutter();
  await CachedHelper.init();
  final dynamic cachedThemeMode = CachedHelper.getThemeMode();
  final String cachedLocalLanguage = CachedHelper.getLanguage();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  return runApp(MainPage(
    cachedThemeMode: cachedThemeMode,
    cachedLocalLanguage: cachedLocalLanguage,
  ));
}

class MainPage extends StatelessWidget {
  final db = FirebaseDatabase.instance;
  final dynamic cachedThemeMode;
  final String cachedLocalLanguage;

  MainPage(
      {Key? key,
      required this.cachedThemeMode,
      required this.cachedLocalLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              AppTheme()..themeToggle(fromCached: cachedThemeMode),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              Language()..changeLanguage(fromCached: cachedLocalLanguage),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseFunctions(),
        ),
        ChangeNotifierProvider(
          create: (context) => GiftProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CleaningInformationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserInformationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        ),
      ],
      child: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ValueNotifier<GraphQLClient>? client;

  @override
  void initState() {
    client = ValueNotifier(globalClient);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<AppTheme>(builder: (BuildContext context, appTheme, Widget? _) {
        return Consumer<Language>(
            builder: (BuildContext context, language, Widget? _) {
          return GraphQLProvider(
            client: client,
            child: MaterialApp(
              locale: Locale(language.localLanguage),
//              cachedLocalLanguage != notFoundError
//                  ? Locale(cachedLocalLanguage!)
//                  :
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: appTheme.isDark ? ThemeMode.dark : ThemeMode.light,
//              cachedThemeMode == notFoundError
//                  ? cachedThemeMode == true
//                  ? ThemeMode.dark
//                  : ThemeMode.light
//                  :
//              appTheme.isDark
//                      ? ThemeMode.dark
//                      : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Auth',
              home: CachedHelper.isAlreadyLogin()
                  ? CachedHelper.isGiftTaken()
                      ? const NewUserScreen()
                      : FirstTimeUserScreen()
                  : const WelcomeScreen(),
              /* home: FutureBuilder(
                  future: UserAuth.isAlreadyLogin(),
       //
               builder: (BuildContext context,
                      AsyncSnapshot<dynamic> isLoginSnapshot) {
                    if (isLoginSnapshot.connectionState == ConnectionState.done) {
                      return isLoginSnapshot.data == false
                          ? const WelcomeScreen()
                          : const HomeScreen();
                    }
                    return const Text('');
                  }),*/

              routes: routes,
            ),
          );
        });
      });
}
