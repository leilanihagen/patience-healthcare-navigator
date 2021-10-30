import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'navigation_bar_controller.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

// class App extends StatefulWidget {
//   const App({Key? key}) : super(key: key);
//   // static void setLocale(BuildContext context, Locale newLocale) {
//   //   _AppState state = context.findAncestorStateOfType<_AppState>();
//   //   state.setLocale(newLocale);
//   // }

//   @override
//   _AppState createState() => _AppState();
// }

class App extends StatelessWidget {
  // String purpleTheme = "#66558E";
  // String lightPinkTheme = "#FDEBF1";
  // String darkPinkTheme = "#ED558C";
  // String blueTheme = "#54D0EB";
  // String darkGreenTheme = "#758C20";
  // String lightGreenTheme = "#A1BF36";

  // Locale _locale;
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) {
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // if (this._locale == null) {
    //   return Container(
    //     child: Center(
    //       child: CircularProgressIndicator(
    //           valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
    //     ),
    //   );
    // } else {
    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () => MaterialApp(
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // primarySwatch: Colors.blue,
              // scaffoldBackgroundColor: Color(0xff66558E),
              scaffoldBackgroundColor: Colors.white,
              brightness: Brightness.light,
              primaryColor: Styles.blueTheme,
              // colorScheme: ColorScheme.fromSwatch()
              //     .copyWith(secondary: Styles.modestPink),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Styles.modestPink,
                foregroundColor: Styles.shadowWhite,
              ),
              textTheme: TextTheme(),
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  titleTextStyle: Styles.appBarNew,
                  actionsIconTheme:
                      IconThemeData(color: Styles.blueTheme, size: 35),
                  iconTheme: IconThemeData(color: Styles.blueTheme, size: 35)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Styles.blueTheme,
                unselectedItemColor: Colors.grey[400],
                selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              toggleableActiveColor: Styles.blueTheme,

              iconTheme: IconThemeData(color: Colors.blue),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Open Sans',
              // accentColor: Styles
              //     .blueTheme, // Mainly for overscroll color (in Android). ie. instead of the default blue
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Styles.blueTheme,
              appBarTheme: AppBarTheme(
                  titleTextStyle: Styles.appBarNew,
                  actionsIconTheme:
                      IconThemeData(color: Styles.blueTheme, size: 35),
                  iconTheme: IconThemeData(color: Styles.blueTheme, size: 35)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Styles.blueTheme,
                  // unselectedItemColor: Colors.grey[400],
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Styles.modestPink,
                foregroundColor: Styles.shadowWhite,
              ),
              toggleableActiveColor: Styles.blueTheme,
            ),
            themeMode: ThemeMode.system,
            // locale: _locale,
            // supportedLocales: [
            //   Locale("en", "US"),
            //   Locale("es", "MX"),
            //   Locale("kr", "KR"),
            //   Locale("vi", "VN")
            // ],
            // localizationsDelegates: [
            //   Localization.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            navigatorObservers: [observer],
            // localeResolutionCallback: (locale, supportedLocales) {
            //   for (var supportedLocale in supportedLocales) {
            //     if (supportedLocale.languageCode == locale.languageCode &&
            //         supportedLocale.countryCode == locale.countryCode) {
            //       return supportedLocale;
            //     }
            //   }
            //   return supportedLocales.first;
            // },
            home: AppBottomNavBarController(
              currentIndex: 0,
            )));
  }
  // }
}
