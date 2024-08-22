import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/utils/constants.dart';
import 'package:ulearning_app/common/utils/image_res.dart';
import 'package:ulearning_app/common/widgets/app_shadow.dart';
import 'package:ulearning_app/common/widgets/image_widgets.dart';
import 'package:ulearning_app/features/lesson_detail/controller/lesson_controller.dart';
import 'package:video_player/video_player.dart';

class LessonDetail extends ConsumerStatefulWidget {
  const LessonDetail({super.key});

  @override
  ConsumerState<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends ConsumerState<LessonDetail> {
  late dynamic args;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var lessonDetail = ref.watch(lessonDetailControllerProvider(index: args.toInt()));
    var lessonData = ref.watch(lessonDataControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (lessonData.value == null ||
                lessonData.value!.lessonItem.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  lessonData.when(
                    data: (data) {
                      return Column(
                        children: [
                          Container(
                            width: 325.w,
                            height: 200.h,
                            decoration: networkImageDecoration(
                                imagePath:
                                    "${AppConstants.IMAGE_UPLOADS_PATH}${data.lessonItem[0].thumbnail}"),
                            child: FutureBuilder(
                              future: data.initializeVideoPlayer,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return videoPlayerController == null
                                      ? Container()
                                      : Stack(
                                          children: [
                                            VideoPlayer(videoPlayerController!),
                                          ],
                                        );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.w, right: 25.w, top: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: AppImage(
                                    width: 24.w,
                                    height: 24.h,
                                    imagePath: ImageRes.left,
                                  ),
                                ),
                                SizedBox(width: 15.h),
                                GestureDetector(
                                  onTap: () {
                                    if (data.isPlay) {
                                      videoPlayerController?.pause();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(false);
                                    } else {
                                      videoPlayerController?.play();
                                      ref
                                          .read(lessonDataControllerProvider
                                              .notifier)
                                          .playPause(true);
                                    }
                                  },
                                  child: data.isPlay ? AppImage(
                                    width: 24.w,
                                    height: 24.h,
                                    imagePath: ImageRes.pause,
                                  ) : AppImage(
                                    width: 24.w,
                                    height: 24.h,
                                    imagePath: ImageRes.play,
                                  ),
                                ),
                                SizedBox(width: 15.h),
                                GestureDetector(
                                  onTap: () {},
                                  child: AppImage(
                                    width: 24.w,
                                    height: 24.h,
                                    imagePath: ImageRes.right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    error: (e, t) {
                      return const Text("error");
                    },
                    loading: () {
                      return const Text("loading");
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

// lessonDetail.when(
//             data: (data) {
//               return Column(
//                 children: [
//                   Text(data!.elementAt(0).name.toString()),
//                   AppBoxDecorationImage(
//                     imagePath:
//                         "${AppConstants.IMAGE_UPLOADS_PATH}${data.elementAt(0).thumbnail}",
//                     width: 325.w,
//                     height: 200.h,
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ],
//               );
//             },
//             error: (error, traceStack) {
//               return Text(error.toString());
//             },
//             loading: () {
//               return const Text("loading");
//             },
//           ),