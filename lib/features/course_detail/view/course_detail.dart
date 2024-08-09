import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulearning_app/common/widgets/app_bar.dart';
import 'package:ulearning_app/features/course_detail/controller/course_detail_controller.dart';
import 'package:ulearning_app/features/course_detail/view/widgets/course_detail_widgets.dart';

class CourseDetail extends ConsumerStatefulWidget {
  const CourseDetail({super.key});

  @override
  ConsumerState<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends ConsumerState<CourseDetail> {
  late dynamic args;

  @override
  void didChangeDependencies() {
    var id = ModalRoute.of(context)!.settings.arguments as Map;
    args = id["id"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var stateData =
        ref.watch(courseDetailControllerProvider(index: args.toInt()));
    return Scaffold(
      appBar: buildGlobalAppBar(title: "Course detail"),
      body: stateData.when(
        data: (data) {
          return data == null
              ? const SizedBox()
              : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CourseDetailThumbnail(courseItem: data),
                  ],
                );
        },
        error: (error, traceStack) {
          return const Text("Error loading the data");
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
