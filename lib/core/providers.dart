import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/features/ai_chat/presentation/cubits/cubit/ai_chat_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/suggestion_from_post/suggestion_from_post_cubit.dart';
import 'package:social_media_app/features/media_picker/presenation/bloc/cubit/asset_file_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat_wallapaper/chat_wallapaper_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/like_comment/like_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/save_post/save_post_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/bloc/who_visited/who_visited_bloc.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/add_interests/select_interest_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_bloc.dart';

import '../features/chat/presentation/cubits/messages_cubits/message/message_cubit.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> myProviders = [
  BlocProvider(
    create: (context) => serviceLocator<DeleteStatusBloc>(),
  ),
  BlocProvider(create: (context) => AppLanguageCubit()),
  BlocProvider(
    create: (context) => serviceLocator<ProfileBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SavePostCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<AppUserBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetMyReelsCubit>()
      ..getMyReels(PartialUser(
          id: context.read<AppUserBloc>().appUser.id,
          userName: context.read<AppUserBloc>().appUser.userName,
          fullName: context.read<AppUserBloc>().appUser.fullName,
          profilePic: context.read<AppUserBloc>().appUser.profilePic)),
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
    create: (context) => serviceLocator<AiChatCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<NotificationCubit>()
      ..getMynotifications(myId: context.read<AppUserBloc>().appUser.id),
  ),
  BlocProvider(
      create: (context) => serviceLocator<GetMyReelsCubit>()
        ..getMyReels(PartialUser(
            id: context.read<AppUserBloc>().appUser.id,
            userName: context.read<AppUserBloc>().appUser.userName,
            fullName: context.read<AppUserBloc>().appUser.fullName,
            profilePic: context.read<AppUserBloc>().appUser.profilePic))),
  BlocProvider(
    create: (context) => serviceLocator<GetUserPostsBloc>()
      ..add(GetUserPostsrequestedEvent(
          user: PartialUser(
              id: context.read<AppUserBloc>().appUser.id,
              userName: context.read<AppUserBloc>().appUser.userName,
              fullName: context.read<AppUserBloc>().appUser.fullName,
              profilePic: context.read<AppUserBloc>().appUser.profilePic))),
  ),
  BlocProvider(
    create: (context) => serviceLocator<DeletePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SearchHashtagBloc>(),
  ),
  BlocProvider(create: (context) => serviceLocator<MessageCubit>()),
  BlocProvider(
    create: (context) => serviceLocator<LikePostBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<FollowingCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<LikeCommentCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<GetHashTagPostsCubit>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<WhoVisitedBloc>(),
  ),
  BlocProvider(
    create: (context) => serviceLocator<SettingsCubit>(),
  ),
  BlocProvider(create: (context) => AssetFileCubit()),
  BlocProvider(create: (context) => ChatWallapaperCubit()..getChatWallapaper()),
  BlocProvider(create: (context) => serviceLocator<SuggestionFromPostCubit>()),
];
