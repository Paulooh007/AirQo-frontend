import 'package:app/providers/LocalProvider.dart';
import 'package:app/screens/home_page.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/rest_api.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_constants.dart';
import 'languages/CustomLocalizations.dart';
import 'languages/lg_intl.dart';
import 'on_boarding/spash_screen.dart';
import 'providers/ThemeProvider.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: ColorConstants.appBodyColor,
  //   statusBarColor: ColorConstants.appBodyColor,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  //   systemNavigationBarDividerColor: ColorConstants.appBodyColor,
  //   // systemNavigationBarIconBrightness: Brightness.dark,
  // ));

  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp().then((value) => {
  //       // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler),
  //
  //       FirebaseMessaging.onMessage
  //           .listen(FbNotifications().foregroundMessageHandler)
  //     });

  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);

  runApp(AirQoApp(themeController: themeController));
}

class AirQoApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => LocaleProvider()),
  //       ChangeNotifierProvider(create: (_) => ThemeProvider()),
  //     ],
  //     builder: (context, child) {
  //       final provider = Provider.of<LocaleProvider>(context);
  //       final themeProvider = Provider.of<ThemeProvider>(context);
  //       // themeProvider.loadActiveThemeData(context);
  //       // Provider.of<ThemeProvider>(context)
  //       //     .loadActiveThemeData(context);
  //       return MaterialApp(
  //         localizationsDelegates: [
  //           CustomLocalizations.delegate,
  //           GlobalMaterialLocalizations.delegate,
  //           GlobalWidgetsLocalizations.delegate,
  //           GlobalCupertinoLocalizations.delegate,
  //           LgMaterialLocalizations.delegate,
  //         ],
  //         // supportedLocales: L10n.all,
  //         // localeResolutionCallback: (locale, supportedLocales) {
  //         //   for (var supportedLocale in supportedLocales) {
  //         //     if (supportedLocale.languageCode.toLowerCase().trim() ==
  //         //         locale!.languageCode.toLowerCase().trim()) {
  //         //       return supportedLocale;
  //         //     }
  //         //   }
  //         //   return supportedLocales.first;
  //         // },
  //         supportedLocales: [const Locale('en'), const Locale('lg')],
  //         locale: provider.locale,
  //         title: appName,
  //         // theme: lightTheme(),
  //         theme: themeProvider.getTheme(),
  //         home: SplashScreen(),
  //       );
  //     },
  //   );
  // }

  final ThemeController themeController;

  const AirQoApp({Key? key, required this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return ThemeControllerProvider(
          controller: themeController,
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ],
            builder: (context, child) {
              final provider = Provider.of<LocaleProvider>(context);

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  CustomLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  LgMaterialLocalizations.delegate,
                ],
                // supportedLocales: L10n.all,
                // localeResolutionCallback: (locale, supportedLocales) {
                //   for (var supportedLocale in supportedLocales) {
                //     if (supportedLocale.languageCode.toLowerCase().trim() ==
                //         locale!.languageCode.toLowerCase().trim()) {
                //       return supportedLocale;
                //     }
                //   }
                //   return supportedLocales.first;
                // },
                supportedLocales: [const Locale('en'), const Locale('lg')],
                locale: provider.locale,
                title: '${AppConfig.name}',
                theme: _buildCurrentTheme(),
                home: SplashScreen(),
              );
            },
          ),
          // child: MaterialApp(
          //   localizationsDelegates: [
          //     CustomLocalizations.delegate,
          //     GlobalMaterialLocalizations.delegate,
          //     GlobalWidgetsLocalizations.delegate,
          //     GlobalCupertinoLocalizations.delegate,
          //     LgMaterialLocalizations.delegate,
          //   ],
          //   // supportedLocales: L10n.all,
          //   // localeResolutionCallback: (locale, supportedLocales) {
          //   //   for (var supportedLocale in supportedLocales) {
          //   //     if (supportedLocale.languageCode.toLowerCase().trim() ==
          //   //         locale!.languageCode.toLowerCase().trim()) {
          //   //       return supportedLocale;
          //   //     }
          //   //   }
          //   //   return supportedLocales.first;
          //   // },
          //   supportedLocales: [const Locale('en'), const Locale('lg')],
          //   locale: Provider.of<LocaleProvider>(context).locale,
          //   title: appName,
          //   theme: _buildCurrentTheme(),
          //   home: SplashScreen(),
          // ),
        );
      },
    );
  }

  ThemeData _buildCurrentTheme() {
    switch (themeController.currentTheme) {
      case 'dark':
        return darkTheme();
      case 'light':
        return lightTheme();
      default:
        return lightTheme();
    }
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool measurementsReady = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (error == '') {
      return Scaffold(
          body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/icon/airqo_logo_tagline_transparent.png',
              //   height: 150,
              //   width: 150,
              // ),
              // Center(
              //   child: CircularProgressIndicator(
              //     valueColor:
              //         AlwaysStoppedAnimation<Color>(ColorConstants.appColor),
              //   ),
              // )
            ],
          ),
        ),
      ));
    } else {
      return Scaffold(
        body: Center(
          child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(error,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.red,
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorConstants.appColor),
                    onPressed: reload,
                    child:
                        const Text('Try Again', style: TextStyle(fontSize: 15)),
                  )
                ],
              )),
        ),
      );
    }
  }

  Future<void> initialize() async {
    _getLatestMeasurements();
    Future.delayed(const Duration(seconds: 4), _checkFirstUse);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void reload() {
    setState(() {
      error = '';
    });
    _initDB().then((value) => {_checkFirstUse()});
  }

  Future _checkDB() async {
    try {
      await DBHelper().getLatestMeasurements().then((value) => {
            if (value.isNotEmpty && mounted)
              {
                setState(() {
                  measurementsReady = true;
                })
              },
          });
    } catch (e) {
      print(e);
    }
  }

  Future _checkFirstUse() async {
    // var prefs = await SharedPreferences.getInstance();
    // var isFirstUse = prefs.getBool(PrefConstant.firstUse) ?? true;
    //
    // if (isFirstUse) {
    //   await Navigator.pushReplacement(context,
    //       MaterialPageRoute(builder: (context) {
    //     return LogoScreen();
    //   }));
    // } else {
    //   await Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (context) {
    //     return HomePage();
    //   }), (r) => false);
    // }

    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
      return LogoScreen();
    }));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  void _getLatestMeasurements() async {
    await AirqoApiClient(context).fetchLatestMeasurements().then((value) => {
          if (value.isNotEmpty)
            {
              DBHelper().insertLatestMeasurements(value).then((value) => {
                    if (mounted)
                      {
                        setState(() {
                          measurementsReady = true;
                        })
                      }
                  })
            }
        });
  }

  Future _initDB() async {
    try {
      await DBHelper().getLatestMeasurements().then((value) => {
            if (value.isNotEmpty && mounted)
              {
                setState(() {
                  measurementsReady = true;
                })
              },
            if (!measurementsReady)
              {
                _getLatestMeasurements(),
              },
          });
    } catch (e) {
      print(e);
    }
  }
}