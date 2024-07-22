import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ulearning_app/common/models/user.dart';
import 'package:ulearning_app/features/global.dart';
part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
//@riverpod
class HomeScreenBannerDots extends _$HomeScreenBannerDots {
  @override
  int build() {
    return 0;
  }

  void setIndex(int value) {
    state = value; 
  }
}

@riverpod
class HomeUserProfile extends _$HomeUserProfile {
  @override
  FutureOr<UserProfile> build() {
    return Global.storageService.getUserProfile();
  }
}