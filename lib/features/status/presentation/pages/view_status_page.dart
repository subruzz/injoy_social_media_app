import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/status_delete_popup.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/status_info.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/story_items.dart';
import 'package:story_view/controller/story_controller.dart';

class ViewStatusPage extends StatefulWidget {
  final StatusEntity? statusEntity;
  final List<SingleStatusEntity>? myStatuses;
  final int index;
  final bool isMe;

  const ViewStatusPage({
    super.key,
    this.isMe = false,
    this.myStatuses,
    this.statusEntity,
    required this.index,
  });
  @override
  State createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<ViewStatusPage> {
  final ValueNotifier<int> _currentStoryIndex = ValueNotifier(0);
  final _storyController = StoryController();
  final int index = 0;
  late List<SingleStatusEntity> _statuses;
  @override
  void initState() {
    _statuses =
        widget.isMe ? widget.myStatuses! : widget.statusEntity!.statuses;
    super.initState();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  void deleteStatus(BuildContext context, String statusId, String? imgUrl) {
    context
        .read<DeleteStatusBloc>()
        .add(DeleteStatus(sId: statusId, imgUrl: imgUrl));
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    return GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              StoryItems(
                  uid: user.id,
                  statuses: _statuses,
                  currentStoryIndex: _currentStoryIndex,
                  storyController: _storyController),
              Positioned(
                top: 30,
                left: 20,
                right: 20,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusInfo(
                          isMe: widget.isMe,
                          user: user,
                          statusEntity: widget.statusEntity,
                          created: _statuses[_currentStoryIndex.value]
                              .createdAt
                              .toDate(),
                          currentStoryIndex: _currentStoryIndex),
                      if (widget.isMe)
                        StatusDeletePopup(deleteStatus: () {
                          deleteStatus(
                              context,
                              _statuses[_currentStoryIndex.value].statusId,
                              _statuses[_currentStoryIndex.value].statusImage);
                        })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
