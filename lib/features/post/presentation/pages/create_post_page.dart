import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/core/widgets/app_related/rotated_icon.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post_input_section/post_input_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtag_section/hash_tag_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_option_section/widgets/post_feeds_options.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_option_section/post_option_section.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_option_section/widgets/post_location.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
    required this.selectedImages,
  });
  final List<SelectedByte> selectedImages;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final selectedHashtags = _selectTagsCubit.state;
              final appUser = context.read<AppUserBloc>().appUser;
              context.read<CreatePostBloc>().add(CreatePostClickEvent(
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
            icon: RotatedIcon(
              color: AppDarkColor().iconSecondarycolor,
              icon: Icons.send_outlined,
            ),
          ),
        ],
        title: const Text('New Post'),
      ),
      body: CustomAppPadding(
        child: BlocConsumer<CreatePostBloc, CreatePostState>(
          listener: (context, state) {
            if (state is CreatePostFailure) {
              Messenger.showSnackBar(message: state.errorMsg);
            }
            if (state is CreatePostSuccess) {
              context.read<GetUserPostsBloc>().add(GetUserPostsrequestedEvent(
                  uid: context.read<AppUserBloc>().appUser.id));
              Navigator.pop(context);
              Navigator.pop(context);

              Messenger.showSnackBar(message: 'success');
            }
          },
          builder: (context, state) {
            if (state is CreatePostLoading) {
              return const LoadingBar();
            }
            return Column(
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
                const PostOptionSection()
              ],
            );
          },
        ),
      ),
    );
  }
}
