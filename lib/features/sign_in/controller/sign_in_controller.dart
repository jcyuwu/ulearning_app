import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulearning_app/common/models/user.dart';
import 'package:ulearning_app/common/global_loader/global_loader.dart';
import 'package:ulearning_app/common/utils/constants.dart';
import 'package:ulearning_app/common/widgets/popup_messages.dart';
import 'package:ulearning_app/features/global.dart';
import 'package:ulearning_app/features/sign_in/provider/sign_in_notifier.dart';
import 'package:ulearning_app/features/sign_in/repo/sign_in_repo.dart';
import 'package:ulearning_app/main.dart';

class SignInController {
  // WidgetRef ref;
  // SignInController(this.ref);
  SignInController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleSignIn(WidgetRef ref) async {
    var state = ref.read(signInNotifierProvider);
    String email = state.email;
    String password = state.password;

    emailController.text = email;
    passwordController.text = password;

    if (state.email.isEmpty || email.isEmpty) {
      toastInfo("your email is empty");
      return;
    }

    if ((state.password.isEmpty) || (password.isEmpty)) {
      toastInfo("your password is empty");
      return;
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final credential = await SignInRepo.firebaseSignIn(email, password);

      if (credential.user == null) {
        toastInfo("User not found");
        return;
      }

      if (!credential.user!.emailVerified) {
        toastInfo("You must verify your email address first !");
        return;
      }

      var user = credential.user;
      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoURL = user.photoURL;

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoURL;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 1;
        asyncPostAllData(loginRequestEntity);
        if (kDebugMode) {
          print("user login");
        }
      } else {
        toastInfo("login error");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toastInfo("User not found");
      } else if (e.code == "wrong-password") {
        toastInfo("Your password is wrong");
      } else {
        toastInfo(e.code);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  Future<void> asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    var result = await SignInRepo.login(params: loginRequestEntity);
    if (result.code==200) {
      try {
        //var navigator = Navigator.of(ref.context);
        // Global.storageService.setString(
        //     AppConstants.STORAGE_USER_PROFILE_KEY,
        //     jsonEncode(
        //         {"name": "jcy256", "email": "jcyu256@gmail.com", "age": 34}));
        // Global.storageService
        //     .setString(AppConstants.STORAGE_USER_TOKEN_KEY, "123456");
        Global.storageService.setString(
            AppConstants.STORAGE_USER_PROFILE_KEY,
            jsonEncode(
                result.data));
        Global.storageService
            .setString(AppConstants.STORAGE_USER_TOKEN_KEY, result.data!.access_token!);

        navKey.currentState
            ?.pushNamedAndRemoveUntil("/application", (route) => false);
        // navigator.push(MaterialPageRoute(
        //   builder: (BuildContext context) => Scaffold(appBar: AppBar(), body: const Application(),),
        // ));
        //navigator.pushNamed("/application");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      toastInfo("Login error");
    }
  }
}
