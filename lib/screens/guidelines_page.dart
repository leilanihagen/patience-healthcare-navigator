import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/components/guildeline_component/situation_box.dart';
import 'package:hospital_stay_helper/components/page_description.dart';
import 'package:hospital_stay_helper/plugins/firebase_analytics.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/after_stay_page.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/before_stay_page.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/collection_page.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/during_stay_page.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/received_bill_page.dart';
import 'package:hospital_stay_helper/screens/guildeLinesList/terms_page.dart';

// Src: https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
// Not using yet:
// class SlideRightRoute extends PageRouteBuilder {
//   final Widget page;
//   SlideRightRoute({this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               SlideTransition(
//             position: Tween<Offset>(
//               begin: const Offset(-1, 0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//           ),
//         );
// }

class CustomPageRouteBuilder<T> extends PageRoute<T> {
  final RoutePageBuilder? pageBuilder;
  final PageTransitionsBuilder matchingBuilder =
      const FadeUpwardsPageTransitionsBuilder(); // Default Android/Linux/Windows
  // final PageTransitionsBuilder matchingBuilder = const CupertinoPageTransitionsBuilder(); // Default iOS/macOS (to get the swipe right to go back gesture)

  CustomPageRouteBuilder({this.pageBuilder});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder!(context, animation, secondaryAnimation);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(
      milliseconds:
          900); // Can give custom Duration, unlike in MaterialPageRoute

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return matchingBuilder.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}

Widget renderClickableSituationCard(
    BuildContext context, pageBuilder, String situation, IconData icon) {
  return GestureDetector(
    onTap: () {
      observer.analytics
          .logEvent(name: 'guideLine', parameters: {'situation': situation});
      Navigator.push(
        context,
        CustomPageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                pageBuilder),
      );
    },
    child: SituationBox(
      text: situation,
      icon: icon,
      backButtonOpacity: 0,
    ),
  );
}

class RootCategoriesPage extends StatelessWidget {
  const RootCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildPageDescriptionColor(
              "How to use Guidelines",
              "Learn things you can do before, during and after your hospital visit to help avoid surprise medical bills, and what to do if you recieve one.\n\nStart by choosing a category below that best fits your situation.",
              Theme.of(context).scaffoldBackgroundColor,
            ),
            //renderClickableSituationCard("I'm preparing for a hospital visit"),
            renderClickableSituationCard(
                context,
                TermsPage(),
                "I want to learn healthcare terms and definitions",
                Icons.menu_book_rounded),
            renderClickableSituationCard(context, BeforeStayPage(),
                "I'm preparing for a hospital visit", Icons.laptop),
            renderClickableSituationCard(context, DuringStayPage(),
                "I'm at the hospital now", Icons.sick_rounded),
            renderClickableSituationCard(
                context,
                AfterStayPage(),
                "I recently visited the hospital",
                Icons.medical_services_rounded),
            renderClickableSituationCard(
                context,
                ReceivedBillPage(),
                "I've received a surprise medical bill",
                Icons.attach_money_rounded),
            renderClickableSituationCard(
                context,
                CollectionsPage(),
                "My medical bill/debt has been sent to collections",
                Icons.priority_high_rounded),
          ],
        ),
      ),
    );
  }
}
