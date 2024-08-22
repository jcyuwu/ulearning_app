import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/app_shadow.dart';
import 'package:ulearning_app/common/widgets/image_widgets.dart';
import 'package:ulearning_app/common/widgets/text_widgets.dart';

Widget appTextField({
  TextEditingController? controller,
  String text = "",
  String iconName = "",
  String hintText = "Type in your info",
  bool obscureText = false,
  void Function(String value)? func,
}) {
  return Container(
    padding: EdgeInsets.only(left: 25.w, right: 25.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text14Normal(text: text),
        SizedBox(
          height: 5.h,
        ),
        Container(
          width: 325.w,
          height: 50.h,
          //color: Colors.red,
          decoration: appBoxDecorationTextField(),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 17.w),
                child: AppImage(imagePath: iconName),
              ),
              appTextFieldOnly(
                controller: controller,
                hintText: hintText,
                obscureText: obscureText,
                func: func,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget appTextFieldOnly({
  TextEditingController? controller,
  String hintText = "Type in your info",
  bool obscureText = false,
  void Function(String value)? func,
  double width = 280,
  double height = 50,
}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: TextField(
      controller: controller,
      onChanged: func,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 7.h, left: 5.w),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      maxLines: 1,
      autocorrect: false,
      obscureText: obscureText,
    ),
  );
}
