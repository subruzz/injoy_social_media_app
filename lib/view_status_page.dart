import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/view_status/view_status_bloc.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class ViewStatusPage extends StatefulWidget {
  const ViewStatusPage({super.key});

  @override
  State createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<ViewStatusPage> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ViewStatusBloc>().add(ViewCurrentUserStatusEvent(
        uId: context.read<AppUserBloc>().appUser!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ViewStatusBloc, ViewStatusState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ViewStatusSuccess) {
            return StoryView(
              storyItems: [
                ...state.statuses.map(
                  (e) => StoryItem.text(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    title: e.content ?? '',
                    backgroundColor: Color(e.color),
                  ),
                )
              ],
              onStoryShow: (storyItem, index) {
                print("Showing a story");
              },
              onComplete: () {
                Navigator.pop(context);
                print("Completed a cycle");
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              controller: storyController,
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
