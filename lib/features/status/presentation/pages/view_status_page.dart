import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/extensions/datetime_to_string.dart';
import 'package:social_media_app/core/widgets/common/partial_user_widget.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/status_delete_popup.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/status_info.dart';
import 'package:social_media_app/features/status/presentation/widgets/view_status/story_items.dart';
import 'package:story_view/controller/story_controller.dart';

import '../../../../core/utils/di/di.dart';
import '../../../../core/widgets/shimmers/partial_user_shimmer.dart';
import '../../../post_status_feed/presentation/bloc/status_viewers/status_viewers_cubit.dart';

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
  final ValueNotifier<bool> _playPauseStatus = ValueNotifier(false);
  final _statusViewCubit = serviceLocator<StatusViewersCubit>();
  final _deleteStatus = serviceLocator<DeleteStatusBloc>();
  @override
  void initState() {
    _statuses =
        widget.isMe ? widget.myStatuses! : widget.statusEntity!.statuses;
    super.initState();
  }

  @override
  void dispose() {
    _currentStoryIndex.dispose();
    _playPauseStatus.dispose();
    _statusViewCubit.close();
    _deleteStatus.close();
    _storyController.dispose();
    super.dispose();
  }

  void deleteStatus(BuildContext context, String statusId, String? imgUrl) {
    _deleteStatus.add(DeleteStatus(sId: statusId, imgUrl: imgUrl));
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
          body: WebWidthHelper(
            child: Stack(
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
                        Row(
                          children: [
                            if (widget.isMe)
                              StatusDeletePopup(
                                  deleteStatusBloc: _deleteStatus,
                                  deleteStatus: () {
                                    deleteStatus(
                                        context,
                                        _statuses[_currentStoryIndex.value]
                                            .statusId,
                                        _statuses[_currentStoryIndex.value]
                                            .statusImage);
                                  }),
                            AppSizedBox.sizedBox10W,
                            ValueListenableBuilder(
                              valueListenable: _playPauseStatus,
                              builder: (context, value, child) {
                                return GestureDetector(
                                  onTap: () {
                                    if (value) {
                                      _storyController.play();
                                    } else {
                                      _storyController.pause();
                                    }
                                    _playPauseStatus.value =
                                        !_playPauseStatus.value;
                                  },
                                  child: value
                                      ? const Icon(Icons.play_arrow)
                                      : const Icon(Icons.pause),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                if (widget.isMe)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: GestureDetector(
                        onTap: () async {
                          _storyController.pause();
                          log('current index is ${_statuses[_currentStoryIndex.value].viewers}');
                          _statusViewCubit.getStatusViewers(
                              _statuses[_currentStoryIndex.value].viewers);
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize: .3,
                                minChildSize: 0.3,
                                maxChildSize: getBottomSheetHeight(
                                    _statuses[_currentStoryIndex.value]
                                        .viewers
                                        .length),
                                expand: false,
                                builder: (context, scrollController) {
                                  return StatusViewersWidgt(
                                      key: ValueKey(_currentStoryIndex.value),
                                      viewersCount:
                                          _statuses[_currentStoryIndex.value]
                                              .viewers
                                              .length,
                                      controller: scrollController,
                                      statusViewCubit: _statusViewCubit);
                                },
                              );
                            },
                          ).then((value) {
                            _statusViewCubit.setInit();
                            _storyController.play();
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(Icons.keyboard_arrow_up_outlined)
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .slide(
                                  duration: const Duration(seconds: 1),
                                  begin: const Offset(0, 0.1),
                                  end: const Offset(0, -0.3),
                                  curve: Curves.easeIn,
                                )
                                .then()
                                .slide(
                                  duration: const Duration(seconds: 1),
                                  begin: const Offset(0, -0.3),
                                  end: const Offset(0, 0.1),
                                  curve: Curves.easeIn,
                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.remove_red_eye),
                                AppSizedBox.sizedBox5W,
                                ValueListenableBuilder(
                                  valueListenable: _currentStoryIndex,
                                  builder: (context, value, child) {
                                    return Text(
                                      key: ValueKey(value),
                                      _statuses[value]
                                          .viewers
                                          .length
                                          .toString(),
                                      style: AppTextTheme
                                              .getResponsiveTextTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              color:
                                                  AppDarkColor().primaryText),
                                    );
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ));
  }

  double getBottomSheetHeight(int length) {
    if (length < 3) {
      return .3;
    } else if (length < 6) {
      return .5;
    } else if (length < 9) {
      return .7;
    } else {
      return .9;
    }
  }
}

class StatusViewersWidgt extends StatelessWidget {
  const StatusViewersWidgt(
      {super.key,
      required this.controller,
      required this.statusViewCubit,
      required this.viewersCount});
  final ScrollController controller;
  final StatusViewersCubit statusViewCubit;
  final int viewersCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: .9.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppDarkColor().buttonBackground,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            child: Text('Viewed by  $viewersCount',
                style: AppTextTheme.getResponsiveTextTheme(context).labelLarge),
          ),
          AppSizedBox.sizedBox10W,
          BlocBuilder(
            bloc: statusViewCubit,
            builder: (context, state) {
              if (state is StatusViewersLoading) {
                return Expanded(
                    child: ListView.builder(
                  padding: AppPadding.only(left: 8, right: 4, top: 4),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const ShimmerPartialUserWidget();
                  },
                ));
              }
              if (state is StatusViewersSuccess) {
                if (state.statusViewers.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No views yet',
                        style: AppTextTheme.getResponsiveTextTheme(context)
                            .bodyLarge,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    padding: AppPadding.only(left: 8, right: 4, top: 4),
                    controller: controller,
                    itemCount: state.statusViewers.length,
                    itemBuilder: (context, index) {
                      return PartialUserWidget(
                          replaceFullName: state.statusViewers[index].$2
                              .toDate()
                              .statsuViewFormat(),
                          wantFollowB: false,
                          user: state.statusViewers[index].$1);
                    },
                  ),
                );
              }
              return const EmptyDisplay();
            },
          )
        ],
      ),
    );
  }
}
