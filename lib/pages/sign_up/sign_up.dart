import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/widgets/app_bar.dart';
import 'package:ulearning_app/common/widgets/app_textfields.dart';
import 'package:ulearning_app/common/widgets/button_widgets.dart';
import 'package:ulearning_app/common/widgets/text_widgets.dart';
import 'package:ulearning_app/pages/sign_up/notifier/register_notifier.dart';
import 'package:ulearning_app/pages/sign_up/sign_up_controller.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  late SignUpController _controller;

  @override
  void initState() {
    _controller = SignUpController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final regProvider = ref.watch(registerNotifierProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppBar(title: "Sign up"),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: text14Normal(
                      text: "Enter your details below & free sign up"),
                ),
                SizedBox(
                  height: 50.h,
                ),
                appTextField(
                  text: "Username",
                  iconName: "assets/icons/user.png",
                  hintText: "Enter your user name",
                  func: (value) => ref
                      .read(registerNotifierProvider.notifier)
                      .onUserNameChange(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                appTextField(
                  text: "Email",
                  iconName: "assets/icons/user.png",
                  hintText: "Enter your email address",
                  func: (value) => ref
                      .read(registerNotifierProvider.notifier)
                      .onUserEmailChange(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                appTextField(
                  text: "Password ",
                  iconName: "assets/icons/lock.png",
                  hintText: "Enter your password",
                  obscureText: true,
                  func: (value) => ref
                      .read(registerNotifierProvider.notifier)
                      .onPasswordChange(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                appTextField(
                  text: "Confirm Password ",
                  iconName: "assets/icons/lock.png",
                  hintText: "Confirm your password",
                  obscureText: true,
                  func: (value) => ref
                      .read(registerNotifierProvider.notifier)
                      .onRePasswordChange(value),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25.w),
                  child: text14Normal(
                      text:
                          "By creating an account you are agreeing with our terms and conditions"),
                ),
                SizedBox(
                  height: 100.h,
                ),
                Center(
                  child: appButton(
                    buttonName: "Register",
                    isLogin: true,
                    context: context,
                    func: () => _controller.handleSignUp(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
