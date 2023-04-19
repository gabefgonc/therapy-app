import 'package:flutter/material.dart';
import 'package:mood_app/pages/home.dart';
import 'package:mood_app/pages/intro/intro_page4.dart';
import 'package:mood_app/pages/intro/intro_page_2.dart';
import 'package:mood_app/pages/intro/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro/intro_page_1.dart';

class FirstTime extends StatelessWidget {
  final PageController _pageController = PageController();

  FirstTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        PageView(
          controller: _pageController,
          children: [
            const IntroPage1(),
            const IntroPage2(),
            const IntroPage3(),
            IntroPage4()
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.8),
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 4,
            effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).primaryColor),
          ),
        ),
      ],
    )));
  }
}
