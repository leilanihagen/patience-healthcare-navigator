import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/localizations/language_constants.dart';
import 'package:hospital_stay_helper/localizations/localization.dart';
import 'navigation_bar_controller.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState state = context.findAncestorStateOfType<_AppState>();
    state.setLocale(newLocale);
  }

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      return ScreenUtilInit(
          designSize: Size(1080, 1920),
          allowFontScaling: false,
          builder: () => MaterialApp(
              scaffoldMessengerKey: rootScaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: 'Open Sans'),
              locale: _locale,
              supportedLocales: [
                Locale("en", "US"),
                Locale("es", "MX"),
                Locale("kr", "KR"),
                Locale("vi", "VN")
              ],
              localizationsDelegates: [
                Localization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              home: AppBottomNavBarController()));
    }
  }
}
