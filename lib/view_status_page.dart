import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_ago.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class ViewStatusPage extends StatefulWidget {
  final StatusEntity statusEntity;
  const ViewStatusPage({
    super.key,
    required this.statusEntity,
    required this.index,
  });
  final int index;
  @override
  State createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<ViewStatusPage> {
  final ValueNotifier<int> _currentStoryIndex = ValueNotifier(0);
  final _storyController = StoryController();
  final int index = 0;
  final ValueNotifier<bool> _statusControls = ValueNotifier(false);
  @override
  void initState() {
    print('df');
    super.initState();
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  void deleteStatus(BuildContext context, String statusId) {
    context.read<StatusBloc>().add(DeleteStatusEvent(
          sId: statusId,
          uId: context.read<AppUserBloc>().appUser!.id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.pop(context);
          }
        },
        child:
            //  BlocBuilder<GetMyStatusBloc, GetMyStatusState>(
            //   builder: (context, state) {
            //     if (state is GetMyStatusSuccess) {
            //       if (_currentStoryIndex.value == -1) {
            //         return SizedBox();
            //       }
            //       print('our index is ${_currentStoryIndex.value}');

            //       return
            Scaffold(
          body: Stack(
            children: [
              StoryView(
                storyItems: [
                  for (final status in widget.statusEntity.statuses)
                    StoryItem.text(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      title: status.content ?? '',
                      backgroundColor: Color(status.color),
                    ),
                ],
                onStoryShow: (storyItem, index) {
                  _currentStoryIndex.value = index;
                  if (!widget.statusEntity.statuses[index].viewers
                      .contains(context.read<AppUserBloc>().appUser!.id)) {
                    context.read<StatusBloc>().add(SeenStatusUpateEvent(
                        uId: widget.statusEntity.uId,
                        index: index,
                        viewedUid: context.read<AppUserBloc>().appUser!.id));
                  }
                },
                onComplete: () {
                  Navigator.pop(context);
                },
                progressPosition: ProgressPosition.top,
                repeat: false,
                controller: _storyController,
              ),
              Positioned(
                top: 30,
                left: 20,
                right: 20,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                widget.statusEntity.profilePic != null
                                    ? NetworkImage(
                                        widget.statusEntity.profilePic!,
                                      )
                                    : const AssetImage(
                                        'assets/images/profile_icon.png'),
                          ),
                          AppSizedBox.sizedBox5W,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.statusEntity.userName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              ValueListenableBuilder(
                                valueListenable: _currentStoryIndex,
                                builder: (BuildContext context, dynamic value,
                                    Widget? child) {
                                  return Text(
                                    widget
                                        .statusEntity.statuses[value].timestamp
                                        .toDate()
                                        .timeAgo(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ValueListenableBuilder(
                            builder: (context, value, child) {
                              return IconButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('allStatus')
                                        .doc(widget.statusEntity.uId)
                                        .update({
                                      'statuses': FieldValue.arrayRemove([
                                      
                                          widget.statusEntity.statuses.first
                                              .toJson()
                                        
                                      ])
                                    });
                                  } catch (e) {
                                    print('erros is this ${e.toString()}');
                                  }
                                  // _statusControls.value =
                                  //     !_statusControls.value;
                                  // if (_statusControls.value) {
                                  //   _storyController.pause();
                                  // } else {
                                  //   _storyController.play();
                                  // }
                                },
                                icon: Icon(
                                  value ? Icons.play_arrow : Icons.pause,
                                ),
                              );
                            },
                            valueListenable: _statusControls,
                          ),
                          BlocListener<StatusBloc, StatusState>(
                            listener: (context, state) {
                              if (state is StatusDeleteSuccess) {
                                _currentStoryIndex.value =
                                    _currentStoryIndex.value - 1;
                                if (_currentStoryIndex.value == -1) {
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: PopupMenuButton(
                              child: const Icon(Icons.more_horiz),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    onTap: () {
                                      // deleteStatus(
                                      //   context,
                                      //   state
                                      //       .myStatus
                                      //       .statuses[
                                      //           _currentStoryIndex.value]
                                      //       .statusId,
                                      // );
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
