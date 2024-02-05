import 'package:baby_feeding/core/common/widgets/white_space.dart';
import 'package:baby_feeding/features/on_boarding/views/widgets/first_page.dart';
import 'package:baby_feeding/features/on_boarding/views/widgets/second_page.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/common/widgets/fading_text.dart';
import '../../../core/res/colours.dart';

class OnBoardingScreeen extends StatefulWidget {
  const OnBoardingScreeen({super.key});

  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [FirstPage(), SecondPage()],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut
                      );
                    },

                    child: const Row(
                      children: [
                        //button
                        Icon(
                            Ionicons.md_chevron_forward_circle,
                            size: 30,
                            color: Colours.light
                        ),
                        WhiteSpace(width: 5),
                        //skip
                        FadingText(
                          'Skip',
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  //swipe indicotar
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      spacing: 10,
                      dotColor: Colors.white70.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
