import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryItems extends StatelessWidget {
  const StoryItems(
      {super.key,
      required this.statuses,required this.uid,
      required this.currentStoryIndex,
      required this.storyController});
  final List<SingleStatusEntity> statuses;
  final ValueNotifier<int> currentStoryIndex;
  final StoryController storyController;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: [
        for (final status in statuses)
          status.statusImage != null
              ? StoryItem.pageImage(
                  controller: storyController,
                  url: status.statusImage!,
                  caption: Text(
                    status.content ?? '',
                    textAlign: TextAlign.center,
                  ))
              : StoryItem.text(
                  textStyle: Theme.of(context).textTheme.displaySmall,
                  title: status.content ?? '',
                  backgroundColor: Color(status.color!)),
      ],
      onStoryShow: (storyItem, index) {
        currentStoryIndex.value = index;
        if (!statuses[index]
            .viewers
            .contains(uid)) {
          context.read<StatusBloc>().add(SeenStatusUpateEvent(
              statusId: statuses[index].statusId,
              viewedUid: uid));
        }
      },
      onComplete: () {
        Navigator.pop(context);
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
      controller: storyController,
    );
  }
}


