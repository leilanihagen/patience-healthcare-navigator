import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/provider/navigation_provider.dart';
import 'package:hospital_stay_helper/provider/timeline_provider.dart';
import 'package:hospital_stay_helper/provider/user_provider.dart';
import 'package:hospital_stay_helper/screens/profile_page.dart';
import 'package:provider/provider.dart';
import 'navigation_bar_controller.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MainNavigationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => VisitTimelineProvider(),
          ),
        ],
        child: MaterialApp(
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Patience Healthcare Navigator',
          theme: ThemeData(
            // primarySwatch: Colors.blue,
            // scaffoldBackgroundColor: Color(0xff66558E),
            scaffoldBackgroundColor: Colors.white,
            brightness: Brightness.light,
            primaryColor: Styles.blueTheme,
            // colorScheme: ColorScheme.fromSwatch()
            //     .copyWith(secondary: Styles.modestPink),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Styles.modestPink,
              foregroundColor: Styles.shadowWhite,
            ),
            textTheme: const TextTheme(bodyText1: Styles.articleBody),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: Styles.appBarNew,
                actionsIconTheme:
                    IconThemeData(color: Styles.blueTheme, size: 35),
                iconTheme: IconThemeData(color: Styles.blueTheme, size: 35)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Styles.blueTheme,
              unselectedItemColor: Colors.grey[400],
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            toggleableActiveColor: Styles.blueTheme,
            iconTheme: const IconThemeData(color: Colors.blue),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Open Sans',
            // accentColor: Styles
            //     .blueTheme, // Mainly for overscroll color (in Android). ie. instead of the default blue
          ),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Styles.blueTheme,
              appBarTheme: const AppBarTheme(
                  titleTextStyle: Styles.appBarNew,
                  actionsIconTheme:
                      IconThemeData(color: Styles.blueTheme, size: 35),
                  iconTheme: IconThemeData(color: Styles.blueTheme, size: 35)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedItemColor: Styles.blueTheme,
                  // unselectedItemColor: Colors.grey[400],
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  )),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Styles.modestPink,
                foregroundColor: Styles.shadowWhite,
              ),
              toggleableActiveColor: Styles.blueTheme,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Open Sans'),
          themeMode: ThemeMode.system,
          navigatorObservers: [observer],
          routes: {
            '/': (context) => AppBottomNavBarController(
                  currentIndex: 0,
                ),
            '/profile': (context) => ProfilePage()
          },
          initialRoute: '/',
        ),
      ),
    );
  }
  // }
}
