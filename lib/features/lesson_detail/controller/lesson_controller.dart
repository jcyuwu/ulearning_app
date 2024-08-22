import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ulearning_app/common/models/lesson_entities.dart';
import 'package:ulearning_app/common/utils/constants.dart';
import 'package:ulearning_app/features/lesson_detail/repo/lesson_repo.dart';
import 'package:video_player/video_player.dart';
part 'lesson_controller.g.dart';

VideoPlayerController? videoPlayerController;

@riverpod
Future<void> lessonDetailController(
  LessonDetailControllerRef ref, {
  required int index,
}) async {
  LessonRequestEntity lessonRequestEntity = LessonRequestEntity();
  lessonRequestEntity.id = index;
  final response =
      await LessonRepo.courseLessonDetail(params: lessonRequestEntity);
  if (response.code == 200) {
    if (kDebugMode) {
      print("my video url is ${AppConstants.VIDEO_STREAM_PATH}${response.data?.elementAt(0).url}");
    }
    var url =
        "${AppConstants.VIDEO_STREAM_PATH}${response.data!.elementAt(0).url!}";
    //videoPlayerController = VideoPlayerController.network("${AppConstants.VIDEO_STREAM_PATH}${response.data?.elementAt(0).url}");
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        //'https://kindly-fun-mouse.ngrok-free.app/video/butterfly.mp4',
        //'https://0af9-2001-b042-3807-366b-6c06-5569-5ced-cf56.ngrok-free.app/uploads/files/butterfly.mp4'
        url,
      ),);
    var initializeVideoPlayerFuture = videoPlayerController?.initialize();
    LessonVideo vidInstance = LessonVideo(
      lessonItem: response.data!,
      isPlay: true,
      initializeVideoPlayer: initializeVideoPlayerFuture,
      url: url,
    );
    videoPlayerController?.play();
    ref.read(lessonDataControllerProvider.notifier).updateLessonData(vidInstance);
  } else {
    if (kDebugMode) {
      print("request failed ${response.code}");
    }
  }
  
}

@riverpod
class LessonDataController extends _$LessonDataController {
  @override
  FutureOr<LessonVideo> build() async {
    return LessonVideo();
  }

  void updateLessonData(LessonVideo lessons) {
    update((data) => data.copyWith(
      url: lessons.url,
      initializeVideoPlayer: lessons.initializeVideoPlayer,
      lessonItem: lessons.lessonItem,
      isPlay: lessons.isPlay,
    ));
  }

  void playPause(bool isPlay) {
    update((data) => data.copyWith(
      isPlay: isPlay,
    ));
  }
}