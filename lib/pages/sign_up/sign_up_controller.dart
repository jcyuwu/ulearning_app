import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulearning_app/common/widgets/popup_messages.dart';
import 'package:ulearning_app/pages/sign_up/notifier/register_notifier.dart';

class SignUpController {
  late WidgetRef ref;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);

    String name = state.userName;
    String email = state.email;

    String password = state.password;
    String rePassword = state.rePassword;

    if (state.userName.isEmpty || name.isEmpty) {
      toastInfo("your name is empty");
      return;
    }

    if (state.userName.length < 6 || name.length < 6) {
      toastInfo("your name is too short");
      return;
    }

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("your email is empty");
      return;
    }

    if ((state.password.isEmpty || state.rePassword.isEmpty) ||
        (password.isEmpty || rePassword.isEmpty)) {
      toastInfo("your password is empty");
      return;
    }

    if (state.password != state.rePassword || password != rePassword) {
      toastInfo("your password did not match");
      return;
    }

    var context = Navigator.of(ref.context);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (kDebugMode) {
        print(credential);
      }

      if (credential.user!=null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);

        toastInfo("An email has been to verify your account. Please open that email and confirm your identity");
        context.pop();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
