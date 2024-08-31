import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_suggested_posts_from_post.dart';
import 'package:social_media_app/features/explore/presentation/blocs/suggestion_from_post/suggestion_from_post_cubit.dart';
import 'package:social_media_app/core/widgets/each_post/each_post.dart';
import 'package:social_media_app/core/widgets/no_post_holder.dart';

import '../../../../core/common/entities/post.dart';
import '../../../../core/widgets/loading/circular_loading.dart';
import '../../../profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';

class AllPostView extends StatelessWidget {
  const AllPostView(
      {super.key,
      required this.initialIndex,
      this.isMyposts = false,
      this.showOnlyOne = false,
      this.post,
      this.postId,
      this.posts = const []});
  final int initialIndex;
  final List<PostEntity> posts;
  final PostEntity? post;
  final bool isMyposts;
  final bool showOnlyOne;
  final String? postId;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final me = context.read<AppUserBloc>().appUser;
    return Scaffold(
        appBar: AppCustomAppbar(
          title: l10n!.posts,
        ),
        body: postId != null && showOnlyOne
            ? FutureBuilder<PostEntity?>(
                future: serviceLocator<FirebaseHelper>().fetchSinglePostById(
                    user: PartialUser(
                        id: me.id,
                        profilePic: me.profilePic,
                        userName: me.userName,
                        fullName: me.fullName),
                    postId: postId!),
                builder: (BuildContext context,
                    AsyncSnapshot<PostEntity?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('Post not found'));
                  } else {
                    final post = snapshot.data!;
                    return EachPost(currentPost: post);
                  }
                },
              )
            : (post != null && showOnlyOne)
                ? EachPost(currentPost: post!)
                : post != null
                    ? PostSuggestionFromPost(
                        post: post!,
                        userId: me.id,
                        l10n: l10n,
                      )
                    : isMyposts
                        ? BlocConsumer<GetUserPostsBloc, GetUserPostsState>(
                            builder: (context, state) {
                              if (state is GetUserPostsSuccess) {
                                if (state.userPosts.isEmpty) {
                                  NoPostHolder(text: l10n.no_posts_found);
                                }
                                return AllPostListView(
                                    initialIndex: initialIndex,
                                    posts: state.userPosts);
                              }
                              return const EmptyDisplay();
                            },
                            listener: (context, state) {
                              if (state is GetUserPostsSuccess &&
                                  state.userPosts.isEmpty) {
                                Navigator.pop(context);
                              }
                            },
                          )
                        : AllPostListView(
                            initialIndex: initialIndex, posts: posts));
  }
}

class AllPostListView extends StatelessWidget {
  const AllPostListView(
      {super.key, required this.initialIndex, required this.posts});
  final int initialIndex;
  final List<PostEntity> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(
        initialScrollOffset: initialIndex == 0 ? 0 : initialIndex * 450.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return EachPost(currentPostIndex: index, currentPost: posts[index]);
      },
    );
  }
}

class PostSuggestionFromPost extends StatelessWidget {
  const PostSuggestionFromPost({
    super.key,
    required this.post,
    required this.userId,
    required this.l10n,
  });
  final AppLocalizations l10n;
  final PostEntity post;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SuggestionFromPostCubit(
          serviceLocator<GetSuggestedPostsFromPostUseCase>(), post)
        ..getSuggestionFromPost(myId: userId, post: post),
      child: BlocBuilder<SuggestionFromPostCubit, SuggestionFromPostState>(
        builder: (context, state) {
          if (state.posts.isNotEmpty) {
            return ListView.builder(
              itemCount: state.isLoading || state.posts.length == 1
                  ? state.posts.length + 1
                  : state.posts.length,
              itemBuilder: (context, index) {
                if (index == state.posts.length && state.isLoading) {
                  return const Center(child: CircularLoadingGrey());
                } else if (index == state.posts.length &&
                    state.posts.length == 1 &&
                    !state.isLoading) {
                  return Padding(
                    padding: AppPadding.onlyTopLarge,
                    child: Center(child: CustomText(text: l10n.no_suggestions)),
                  );
                }
                return EachPost(currentPost: state.posts[index]);
              },
            );
          } else {
            return const EmptyDisplay();
          }
        },
      ),
    );
  }
}
