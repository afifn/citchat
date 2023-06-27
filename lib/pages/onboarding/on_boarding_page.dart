
import 'package:carousel_slider/carousel_slider.dart';
import 'package:citchat/routes/router.dart';
import 'package:citchat/shared/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/theme.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  List<String> titles = [
    "Chat anytime, anywhere",
    "Your space in your dream",
    "Perfect for send message",
  ];

  List<String> subtitles = [
    "Passing of any information on any\nscreen, any device instanly\n is mode\nsimple at its sublime.",
    "A lag-free video chat connection between your users is easy and much\neverywhere on any device.",
    "Your message in your dream to sending to another people\nhide your communication from others",
  ];

  @override
  Widget build(BuildContext context) {
    final colorBackground = Theme.of(context).colorScheme.onSecondary;
    final colorText = Theme.of(context).colorScheme.onPrimaryContainer;
    final colorDot = Theme.of(context).colorScheme.outline;
    final colorDotCurrent = Theme.of(context).colorScheme.surfaceTint;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: [
                Image.asset('assets/images/onboarding1.png', height: 332),
                Image.asset('assets/images/onboarding2.png', height: 332),
                Image.asset('assets/images/onboarding3.png', height: 332),
              ],
              options: CarouselOptions(
                height: 331,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 80),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                color: colorBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    titles[currentIndex],
                    style: monsterratTextStyle.copyWith(color: colorText, fontSize: 18, fontWeight: semiBold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  Text(
                    subtitles[currentIndex],
                    style: monsterratTextStyle.copyWith(
                      color: colorText,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 26),
                  currentIndex == 2? Column(
                    children: [
                      CFillButton(
                          title: 'Get Started',
                          onPressed: () {
                            context.goNamed(RouteName.login);
                          }
                      ),
                    ],
                  ) : Row(
                    children: [
                      Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (currentIndex == 0) ? colorDotCurrent : colorDot,
                        ),
                      ),
                      Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (currentIndex == 1) ? colorDotCurrent : colorDot,
                        ),
                      ),
                      Container(
                        height: 12,
                        width: 12,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (currentIndex == 2) ? colorDotCurrent : colorDot,
                        ),
                      ),
                      const Spacer(),
                      CFillButton(
                        width: 100,
                        onPressed: () {
                          carouselController.nextPage();
                        },
                        title: "Next",
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
