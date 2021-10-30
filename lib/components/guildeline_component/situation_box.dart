import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hospital_stay_helper/config/styles.dart';

class SituationBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final double backButtonOpacity;

  SituationBox(
      {required this.text,
      required this.icon,
      this.backButtonOpacity = 1,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: text,
      createRectTween: (begin, end) => _CustomRectTween(begin: begin, end: end),
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        animation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeOut);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return _SituationBoxTile(
              icon: icon,
              text: text,
              opacity: animation.value,
            );
          },
        );
      },
      child: _SituationBoxTile(
        icon: icon,
        text: text,
        opacity: backButtonOpacity,
      ),
    );
  }
}

class _CustomRectTween extends RectTween {
  _CustomRectTween({Rect? begin, Rect? end}) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    t = Curves.easeOut.transform(t);
    double animatedLeft = begin!.left + t * (end!.left - begin!.left);
    double animatedTop = begin!.top + t * (end!.top - begin!.top);
    double animatedRight = begin!.right + t * (end!.right - begin!.right);
    double animatedBottom = begin!.bottom + t * (end!.bottom - begin!.bottom);

    return Rect.fromLTRB(
        animatedLeft, animatedTop, animatedRight, animatedBottom);
  }
}

class _SituationBoxTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final double opacity;

  const _SituationBoxTile({
    required this.icon,
    required this.text,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    double animProgress = 1 - opacity;

    return
        // Material(
        //   color: Colors.transparent,
        //   child:

        Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15.0 * animProgress, vertical: 8 * animProgress),
      child: Material(
        elevation: 10,
        child: Container(
          // margin: EdgeInsets.symmetric(
          //     horizontal: 15.0 * animProgress, vertical: 8 * animProgress),
          decoration: BoxDecoration(
              color: Styles.modestPink,
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5 * animProgress),
              //     spreadRadius: 4,
              //     blurRadius: 6,
              //     offset: Offset(0, 3),
              //   )
              // ],
              borderRadius: BorderRadius.circular(5.0 * animProgress)),
          child: Row(
            children: [
              Container(
                width: opacity * max(24.0, Material.defaultSplashRadius),
                child: Opacity(
                  opacity: opacity,
                  child: IconButton(
                    iconSize: 24.0,
                    splashRadius: Material.defaultSplashRadius,
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  leading: Icon(
                    icon,
                    color: Colors.white,
                    size: 33,
                  ),
                  title: Text(
                    text,
                    style: Styles.guidelineCard,
                  ),
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
