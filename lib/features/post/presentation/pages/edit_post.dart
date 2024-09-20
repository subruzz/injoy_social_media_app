import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';

import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/core/widgets/each_post/post_image_section.dart/widgets/post_multiple_images.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/edit_post/edit_screen_feed_option.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/select_hashtag.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/selected_hashtags.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';
import '../../../../core/utils/other/debouncer.dart';
import '../widgets/create_post/section/create_post_input_section/widgets/desc_text_field.dart';

class EditPostPage extends StatefulWidget {
  final int index;
  final PostEntity post;

  const EditPostPage({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _descriptionController = TextEditingController();
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
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppCustomAppbar(
        title: l10n!.edit_post,
        actions: [
          BlocConsumer<CreatePostBloc, CreatePostState>(
            listenWhen: (previous, current) =>
                current is UpdatePostsError ||
                current is UpdatePostSuccess ||
                current is UpdatePostLoading,
            buildWhen: (previous, current) =>
                current is UpdatePostsError ||
                current is UpdatePostSuccess ||
                current is UpdatePostLoading,
            listener: (context, state) {
              if (state is UpdatePostsError) {
                Messenger.showSnackBar(
                    message: l10n.something_went_wrong_edit_post);
              }
              if (state is UpdatePostSuccess) {
                context.read<GetUserPostsBloc>().add(GetUserPostsAterPostUpdate(
                    index: widget.index, updatedPost: state.updatedPost));
                Messenger.showSnackBar(message: l10n.post_update_success);
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

                    context.read<CreatePostBloc>().add(UpdatePostEvent(
                          oldPostHashTags: widget.post.hashtags,
                          user: PartialUser(
                              id: widget.post.creatorUid,
                              profilePic: widget.post.userProfileUrl,
                              userName: widget.post.username,
                              fullName: widget.post.userFullName),
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
              PostMultipleImages(
                pageController: PageController(),
                isEdit: true,
                postImageUrls: widget.post.postImageUrl,
                size: .5,
              ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: DescriptionTextfield(
                  l10n: l10n!,
                  onChanged: (value) {},
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
