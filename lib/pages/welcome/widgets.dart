import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/app_shadow.dart';
import 'package:ulearning_app/common/widgets/text_widgets.dart';

Widget appOnboardingPage(PageController controller,
    {String imagePath = "assets/images/reading.png",
    String title = "",
    String subTitle = "",
    index = 0,
    required BuildContext context}) {
  return Column(
    children: [
      Image.asset(
        imagePath,
        fit: BoxFit.fitWidth,
      ),
      Container(
          margin: EdgeInsets.only(top: 15.h),
          child: text24Normal(text: title)),
      Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: text16Normal(text: subTitle)),
      _nextButton(index, controller, context)
    ],
  );
}

Widget _nextButton(int index, PageController controller, BuildContext context) {
  return GestureDetector(
      onTap: () {
        //print("my index is $index");
        if (index < 3) {
          controller.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        } else {
          Navigator.pushNamed(context, "/signIn");
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => const SignIn()));
        }
      },
      child: Container(
        width: 325.w,
        height: 50.h,
        margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
        decoration: appBoxShadow(),
        child: Center(child: text16Normal(text: index<3 ? "next" : "Get started", color: Colors.white)),
      ));
}
