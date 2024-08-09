import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/utils/app_colors.dart';

Widget text24Normal(
    {String text = "",
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color, fontSize: 24.sp, fontWeight: fontWeight),
  );
}

// Widget text16Normal(
//     {String text = "", Color color = AppColors.primarySecondaryElementText}) {
//   return Text(
//     text,
//     textAlign: TextAlign.center,
//     style:
//         TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.normal),
//   );
// }

class Text16Normal extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  const Text16Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primarySecondaryElementText,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontSize: 16.sp, fontWeight: fontWeight),
    );
  }
}

// Widget text14Normal(
//     {String text = "", Color color = AppColors.primaryThridElementText}) {
//   return Text(
//     text,
//     textAlign: TextAlign.start,
//     style:
//         TextStyle(color: color, fontSize: 14.sp, fontWeight: FontWeight.normal),
//   );
// }

class Text14Normal extends StatelessWidget {
  final String text;
  final Color color;

  const Text14Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThridElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: 14.sp, fontWeight: FontWeight.normal),
    );
  }
}

class Text11Normal extends StatelessWidget {
  final String text;
  final Color color;

  const Text11Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: 11.sp, fontWeight: FontWeight.normal),
    );
  }
}

class Text10Normal extends StatelessWidget {
  final String text;
  final Color color;

  const Text10Normal(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryThridElementText});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: color, fontSize: 10.sp, fontWeight: FontWeight.normal),
    );
  }
}

Widget textUnderline({
  String text = "Your text",
}) {
  return GestureDetector(
    onTap: () {},
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
        color: AppColors.primaryText,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.primaryText,
      ),
    ),
  );
}

class FadeText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize ;

  const FadeText(
      {super.key,
      this.text = "",
      this.color = AppColors.primaryElementText,
      this.fontSize  = 10 ,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      style: TextStyle(
          color: color, fontSize: fontSize.sp, fontWeight: FontWeight.bold),
    );
  }
}
