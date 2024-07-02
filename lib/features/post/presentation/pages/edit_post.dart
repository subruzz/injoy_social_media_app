import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/debouncer.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/post/post_single_image.dart';
import 'package:social_media_app/features/post/presentation/bloc/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/description_textfield.dart';
import 'package:social_media_app/features/post/presentation/widgets/edit_post/edit_screen_feed_option.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtags/select_hashtag.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtags/selected_hashtags.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class EditPostPage extends StatefulWidget {
  final List<String> userAllPostImages;
  final int index;
  final List<PostEntity> allUserStatuses;

  const EditPostPage({
    super.key,
    required this.post,
    required this.userAllPostImages,
    required this.index,
    required this.allUserStatuses,
  });
  final PostEntity post;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _descriptionController = TextEditingController();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 1000));
  final _hashtagcontroller = TextEditingController();
  final _selectTagsCubit = GetIt.instance<SelectTagsCubit>();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.post.description ?? '';
    _selectTagsCubit.alreadySelected(widget.post.hashtags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
            )),
        actions: [
          BlocConsumer<UpdatePostBloc, UpdatePostState>(
            listener: (context, state) {
              if (state is UpdatePostsError) {
                Messenger.showSnackBar(message: state.errorMsg);
              }
              if (state is UpdatePostSuccess) {
                context.read<GetUserPostsBloc>().add(GetUserPostsAterPostUpdate(
                    userAllPostImages: widget.userAllPostImages,
                    updatedPost: state.updatePost,
                    index: widget.index,
                    allUsePosts: widget.allUserStatuses));
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is UpdatePostLoading) {
                return const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: CircularLoading(),
                );
              }
              return IconButton(
                  onPressed: () {
                    final selectedHashtags = _selectTagsCubit.state;

                    context.read<UpdatePostBloc>().add(UpdatePost(
                          hashtags: selectedHashtags is SelectdTagsSuccess
                              ? selectedHashtags.tags
                              : widget.post.hashtags,
                          description: _descriptionController.text.trim(),
                          postId: widget.post.postId,
                        ));
                  },
                  icon: const Icon(
                    Icons.check,
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: widget.post.userProfileUrl != null
                          ? CachedNetworkImageProvider(
                              widget.post.userProfileUrl!)
                          : const AssetImage('assets/images/profile_icon.png')),
                  AppSizedBox.sizedBox5W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.username,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      if (widget.post.location != null)
                        Text(
                          widget.post.location!,
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                    ],
                  )
                ],
              ),
            ),
            AppSizedBox.sizedBox15H,
            if (widget.post.postImageUrl.isNotEmpty)
              widget.post.postImageUrl.length == 1
                  ? PostSingleImage(
                      imgUrl: widget.post.postImageUrl[0],
                      size: .5,
                      isEdit: true,
                    )
                  : PostMultipleImages(
                      isEdit: true,
                      postImageUrls: widget.post.postImageUrl,
                      size: .5,
                    ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: DescriptionTextfield(
                  descriptionController: _descriptionController),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SelectedHashtags(selectTagsCubit: _selectTagsCubit),
            ),
            AppSizedBox.sizedBox10H,
            Row(
              children: [
                SelectHashtag(
                    selectTagsCubit: _selectTagsCubit,
                    debouncer: _debouncer,
                    hashtagcontroller: _hashtagcontroller),
              ],
            ),
            if (widget.post.postImageUrl.isEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    AppSizedBox.sizedBox10H,
                    const EditScreenFeedOption(
                        title: 'Tag People',
                        icon: Icons.people_outline_outlined),
                    const EditScreenFeedOption(
                        title: 'Audience', icon: Icons.visibility),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
