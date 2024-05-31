import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/features/welcome/provider/notifier/welcome_notifier.dart';
import 'package:ulearning_app/features/welcome/view/widgets.dart';

//final indexProvider = StateProvider<int>((ref) => 0);

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();
  //int dotsIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexDotProvider);
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView(
                      onPageChanged: (value) {
                        //print("----my index value is $value");
                        //dotsIndex = value;
                        ref.read(indexDotProvider.notifier).changeIndex(value);
                      },
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      children: [
                        appOnboardingPage(_controller,
                            imagePath: "assets/images/reading.png",
                            title: "First See Learning",
                            subTitle:
                                "Forget about the paper, now learning all in one place",
                            index: 1,
                            context: context),
                        appOnboardingPage(_controller,
                            imagePath: "assets/images/man.png",
                            title: "Connect With Everyone",
                            subTitle:
                                "Always keep in touch with your tutor and friends. Let's get connected",
                            index: 2,
                            context: context),
                        appOnboardingPage(_controller,
                            imagePath: "assets/images/boy.png",
                            title: "Always Fascinated Learning",
                            subTitle:
                                "Anywhere, anytime. The time is at your discretion. So study wherever you can",
                            index: 3,
                            context: context)
                      ],
                    ),
                    Positioned(
                      bottom: 50,
                      //left: 20,
                      child: DotsIndicator(
                        position: index,
                        dotsCount: 3,
                        mainAxisAlignment: MainAxisAlignment.center,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: Size(24.0.w, 8.0.h),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.w)),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
