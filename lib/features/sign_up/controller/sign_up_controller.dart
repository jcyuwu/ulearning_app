import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ulearning_app/common/global_loader/global_loader.dart';
import 'package:ulearning_app/common/widgets/popup_messages.dart';
import 'package:ulearning_app/features/sign_up/provider/notifier/register_notifier.dart';
import 'package:ulearning_app/features/sign_up/repo/sign_up_repo.dart';

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

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    // Future.delayed(Duration(seconds: 2), () {});

    var context = Navigator.of(ref.context);
    try {
      final credential = await SignUpRepo.firebaseSignUp(email, password);

      if (kDebugMode) {
        print(credential);
      }

      if (credential.user!=null) {
        await credential.user?.sendEmailVerification();
        await credential.user?.updateDisplayName(name);
        String photoUrl = "uploads/default.png";
        await credential.user?.updatePhotoURL(photoUrl);

        toastInfo("An email has been to verify your account. Please open that email and confirm your identity");
        context.pop();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        toastInfo("The password is too weak");
      } else if (e.code == "email-already-use") {
        toastInfo("This email address has already registered");
      } else if (e.code == "user-not-found") {
        toastInfo("User not found");
      } else {
        if (kDebugMode) {
          print(e.code);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    ref.watch(appLoaderProvider.notifier).setLoaderValue(false);
  }
}
