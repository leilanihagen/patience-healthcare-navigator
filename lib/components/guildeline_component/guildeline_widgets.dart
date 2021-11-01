import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/config/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class GuidelineHyperLinkText extends StatelessWidget {
  final String title;
  final String text;
  final String hyperLink;
  final String hyperLinkText;

  const GuidelineHyperLinkText(
      {required this.title,
      required this.text,
      required this.hyperLinkText,
      required this.hyperLink,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        childrenPadding: EdgeInsets.fromLTRB(15, 0, 15, 11),
        title: Text(title, style: Styles.headerGuildline),
        children: [
          RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText1,
                  children: [
                TextSpan(text: (text + "\n\n")),
                TextSpan(
                    text: hyperLinkText,
                    style: Styles.hyperlink,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch(hyperLink))
              ])),
        ]);
  }
}

class GuidelineCustomWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const GuidelineCustomWidget(
      {required this.title, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        childrenPadding: EdgeInsets.fromLTRB(15, 0, 15, 11),
        title: Text(
          title,
          style: Styles.headerGuildline,
        ),
        children: [
          child,
        ]);
  }
}

class GuidelineText extends StatelessWidget {
  final String title, text;
  const GuidelineText({required this.title, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        childrenPadding: EdgeInsets.fromLTRB(15, 0, 15, 11),
        title: Text(
          title,
          style: Styles.headerGuildline,
        ),
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyText1),
        ]);
  }
}
