import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/follow_hashtag/follow_hashtag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recommended_post/get_recommended_post_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_hash_tag/search_hash_tag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_user/search_user_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/like_comment/like_comment_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/init_dependecies.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/assets/presenation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/assets/presenation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/add_interests/select_interest_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';

List<SingleChildWidget> myProviders = [
  BlocProvider(
    create: (context) => serviceLocator<SignupBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<DeleteStatusBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<ProfileBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<AppUserBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GoogleAuthBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<LoginBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<ForgotPasswordBloc>(),
  ),
  BlocProvider(
    create: (context) => BottomNavCubit(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchHashtagBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<CreatePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetUserPostsBloc>()
      ..add(GetUserPostsrequestedEvent(
          uid: context.read<AppUserBloc>().appUser.id)),
  ),
  BlocProvider(
    create: (context) => serviceLocator<FollowingPostFeedBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<StatusBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<FollowunfollowCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SelectInterestCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<AuthBloc>()..add(AuthCurrentUser()),
  ),
  BlocProvider(
    create: (context) => serviceLocator<UpdatePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<DeletePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<PickMultipleImageCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchHashtagBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<LikePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<FollowingCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetMyStatusBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetMyStatusBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetAllStatusBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<CommentBasicCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetPostCommentCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<LikeCommentCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchUserCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchHashTagCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetRecommendedPostCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchLocationExploreCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetHashTagPostsCubit>(),
  ),
 
  BlocProvider(
    create: (context) => FollowHashtagCubit(
        FirebaseFirestore.instance, context.read<AppUserBloc>().appUser.id),
  ),
  // BlocProvider(
  //   create: (context) => serviceLocator<OtherProfileCubit>(),
  // ),
  BlocProvider(
      create: (context) => serviceLocator<AlbumBloc>()..add(GetAlbumsEvent())),
  BlocProvider(create: (context) => serviceLocator<AssetsBloc>()),
  BlocProvider(create: (context) => serviceLocator<InitialSetupCubit>()),
];