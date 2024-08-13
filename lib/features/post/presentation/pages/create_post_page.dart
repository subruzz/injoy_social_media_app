import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/hash_tag_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/post_option_section/post_option_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/post_option_section/widgets/post_location.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';

import '../../../../core/services/method_channel.dart/video_trimmer.dart';
import '../widgets/create_post/section/create_post_input_section/post_input_section.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
    this.isReel = false,
    required this.selectedImages,
  });
  final List<SelectedByte> selectedImages;
  final bool isReel;
  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _descriptionController = TextEditingController();
  final _hashtagcontroller = TextEditingController();
  final _selectTagsCubit = GetIt.instance<SelectTagsCubit>();
  final PageController _pageController = PageController();
  UserLocation? _location;
  bool _isCommentOff = false;
  @override
  void dispose() {
    _descriptionController.dispose();
    _hashtagcontroller.dispose();
    _selectTagsCubit.close();
    _pageController.dispose();
    super.dispose();
  }

  final VideoService _videoService = VideoService();

  Future<void> _trimVideo(String videoPath) async {
    final trimmedVideoPath = await _videoService.trimVideo(videoPath);
    if (trimmedVideoPath != null) {
      // Handle the trimmed video path (e.g., show it in a video player or save it)
      log("Trimmed video path: $trimmedVideoPath");
    } else {
      // Handle error case
      log("Failed to trim video.");
    }
  }

  @override
  void initState() {
    super.initState();
    _trimVideo(widget.selectedImages.first.selectedFile!.path);
  }

  @override
  Widget build(BuildContext context) {
    log(' we hvae this muchh ${widget.selectedImages}');
    final l10n = context.l10n;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                final selectedHashtags = _selectTagsCubit.state;
                final appUser = context.read<AppUserBloc>().appUser;
                context.read<CreatePostBloc>().add(CreatePostClickEvent(
                      isReel: widget.isReel,
                      isCommentOff: _isCommentOff,
                      userFullName: appUser.fullName ?? '',
                      postPics: widget.selectedImages,
                      creatorUid: appUser.id,
                      username: appUser.userName ?? '',
                      description: _descriptionController.text.trim().isEmpty
                          ? null
                          : _descriptionController.text.trim(),
                      userProfileUrl: appUser.profilePic,
                      hashtags: selectedHashtags is SelectdTagsSuccess
                          ? selectedHashtags.tags
                          : [],
                      latitude: _location?.latitude,
                      location: _location?.currentLocation,
                      longitude: _location?.longitude,
                    ));
              },
              icon: CustomSvgIcon(
                assetPath: AppAssetsConst.send2,
                color: AppDarkColor().iconSoftColor,
              )),
        ],
        title: Text(l10n!.newPost),
      ),
      body: CustomAppPadding(
        child: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state is CreatePostFailure) {
              Messenger.showSnackBar(message: l10n.postAddError);
            }
            if (state is CreatePostSuccess) {
              // context.read<GetUserPostsBloc>().add(GetUserPostsrequestedEvent(
              //     uid: context.read<AppUserBloc>().appUser.id));
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );

              Messenger.showSnackBar(message: l10n.postAddedSuccess);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SelectedAssetsSection(
                    //     isPost: true,
                    //     pageController: _pageController,
                    //     selectedAssets: widget.selectedImages),
                    // Center(
                    // child: SelectedAssetsIndicator(
                    //     isPost: true,
                    //     pageController: _pageController,
                    //     selectedAssets: widget.selectedImages),
                    // ),
                    //input for creating post
                    PostInputSection(
                      l10n: l10n,
                      descriptionController: _descriptionController,
                      assetEntity: widget.selectedImages[0],
                    ),
                    AppSizedBox.sizedBox20H,
                    //selecting and displaying hashtag
                    HashTagSection(
                        hashTagController: _hashtagcontroller,
                        selectTagsCubit: _selectTagsCubit),
                    AppSizedBox.sizedBox10H,
                    PostLocation(
                      l10n: l10n,
                      setLocation: (location) {
                        _location = location;
                      },
                    ),
                    AppSizedBox.sizedBox10H,
                    // for selecting post options
                    // ListTile(
                    //     title: Text('Tag people'),
                    //     onTap: () {
                    //       Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => TagPeoplePage(
                    //           selectedAssets: widget.selectedImages,
                    //         ),
                    //       ));
                    //     }),
                    PostOptionSection(
                      l10n: l10n,
                      isCommentOff: _isCommentOff,
                      onCommentToggle: (value) {
                        _isCommentOff = value;

                        log(_isCommentOff.toString());
                      },
                    )
                  ],
                ),
                if (state is CreatePostLoading)
                  const OverlayLoadingHolder(
                    wantAnimatedLoading: true,
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
