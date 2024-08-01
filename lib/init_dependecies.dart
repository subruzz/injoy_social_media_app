import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/features/assets/data/repository/asset_repository_impl.dart';
import 'package:social_media_app/features/assets/domain/repository/asset_repository.dart';
import 'package:social_media_app/features/assets/data/datasource/local/asset_local_datasource.dart';
import 'package:social_media_app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:social_media_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:social_media_app/features/auth/domain/repostiories/auth_repository.dart';
import 'package:social_media_app/features/auth/domain/usecases/current_user.dart';
import 'package:social_media_app/features/auth/domain/usecases/forgot_password.dart';
import 'package:social_media_app/features/auth/domain/usecases/google_auth.dart';
import 'package:social_media_app/features/auth/domain/usecases/login_user.dart';
import 'package:social_media_app/features/auth/domain/usecases/user_signup.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/call/data/datasource/call_remote_datasource.dart';
import 'package:social_media_app/features/call/data/repository/call_repository_impl.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';
import 'package:social_media_app/features/call/domain/usecases/end_call.dart';
import 'package:social_media_app/features/call/domain/usecases/get_channel_id.dart';
import 'package:social_media_app/features/call/domain/usecases/get_user_calling.dart';
import 'package:social_media_app/features/call/domain/usecases/make_call.dart';
import 'package:social_media_app/features/call/domain/usecases/save_call_history.dart';
import 'package:social_media_app/features/call/presentation/agora/agora_cubit.dart';
import 'package:social_media_app/features/call/presentation/call/call_cubit.dart';
import 'package:social_media_app/features/call/presentation/call_history/call_history_cubit.dart';
import 'package:social_media_app/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:social_media_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_chat_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/delete_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_my_chats_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/get_single_user_message_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/seen_message_update_usecase.dart';
import 'package:social_media_app/features/chat/domain/usecases/send_message_use_case.dart';
import 'package:social_media_app/features/chat/presentation/cubits/chat/chat_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message/message_cubit.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_info_store/message_info_store_cubit.dart';
import 'package:social_media_app/features/explore/data/datasource/explore_app_datasource.dart';
import 'package:social_media_app/features/explore/data/repository/explore_app_repo_impl.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_hashtag_top_posts.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_nearyby_users.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_recent_posts_hashtag.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_recommended_post.dart';
import 'package:social_media_app/features/explore/domain/usecases/get_suggested_users.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_hash_tags.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_locations_explore.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_user.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recent_hashtag_posts/get_recent_hashtag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recommended_post/get_recommended_post_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_hash_tag/search_hash_tag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_location_explore/search_location_explore_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/search_user/search_user_cubit.dart';
import 'package:social_media_app/features/notification/data/datacource/notification_datasource.dart';
import 'package:social_media_app/features/notification/data/repository/notification_repository_impl.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';
import 'package:social_media_app/features/notification/domain/usecases/create_notification_use_case.dart';
import 'package:social_media_app/features/notification/domain/usecases/delete_my_notification.dart';
import 'package:social_media_app/features/notification/domain/usecases/delete_notification.dart';
import 'package:social_media_app/features/notification/domain/usecases/get_my_notification.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:social_media_app/features/post/data/datasources/remote/comment_remote_datasource.dart';
import 'package:social_media_app/features/post/data/datasources/remote/post_remote_datasource.dart';
import 'package:social_media_app/features/post/data/repository/comment_repository_impl.dart';
import 'package:social_media_app/features/post/data/repository/post_repostiory_impl.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/create_comment_usecase.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/delete_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/like_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/read_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/remove_like_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/update_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/post/create_posts.dart';
import 'package:social_media_app/features/post/domain/usecases/post/delete_post.dart';
import 'package:social_media_app/features/assets/domain/usecase/get_albums.dart';
import 'package:social_media_app/features/assets/domain/usecase/get_assets.dart';
import 'package:social_media_app/features/post/domain/usecases/post/like_post.dart';
import 'package:social_media_app/features/post/domain/usecases/post/searh_hashtag.dart';
import 'package:social_media_app/features/post/domain/usecases/post/unlike_post.dart';
import 'package:social_media_app/features/post/domain/usecases/post/update_post.dart';
import 'package:social_media_app/features/assets/presenation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/assets/presenation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/like_comment/like_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/status_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/data/repository/status_feed_repository_impl.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_for_you_posts.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/for_you_posts/for_you_post_bloc.dart';
import 'package:social_media_app/features/premium_subscription/data/datasource/premium_subscription_datasource.dart';
import 'package:social_media_app/features/premium_subscription/data/repository/premium_subsription_repo_impl.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';
import 'package:social_media_app/features/premium_subscription/domain/usecases/create_payment_intent.dart';
import 'package:social_media_app/features/premium_subscription/domain/usecases/setup_stripe_for_payment.dart';
import 'package:social_media_app/features/premium_subscription/domain/usecases/update_user_premium_status.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';
import 'package:social_media_app/features/profile/data/data_source/other_user_data_source.dart';
import 'package:social_media_app/features/profile/data/repository/other_user_profile_impl.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';
import 'package:social_media_app/features/profile/domain/usecases/add_interest.dart';
import 'package:social_media_app/features/profile/domain/usecases/check_username_exist.dart';
import 'package:social_media_app/features/profile/domain/usecases/follow_user.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_followers_list.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_following_list.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_other_user_details.dart';
import 'package:social_media_app/features/profile/domain/usecases/unfollow_user.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_followers_list/get_followers_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_following_list/get_following_list_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_liked_posts/get_user_liked_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_profile/other_profile_cubit.dart';
import 'package:social_media_app/features/settings/data/datasource/settings_datasource.dart';
import 'package:social_media_app/features/settings/data/repository/setting_repo_impl.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';
import 'package:social_media_app/features/settings/domain/usecases/edit_notification_preference.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';
import 'package:social_media_app/features/status/data/datasource/status_remote_datasource.dart';
import 'package:social_media_app/features/status/data/repository/create_status_repository_impl.dart';
import 'package:social_media_app/features/status/domain/repository/status_repository.dart';
import 'package:social_media_app/features/status/domain/usecases/create_multiple_status.dart';
import 'package:social_media_app/features/status/domain/usecases/create_status.dart';
import 'package:social_media_app/features/status/domain/usecases/delete_status.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_all_statuses.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_my_status.dart';
import 'package:social_media_app/features/status/domain/usecases/seeen_status_update.dart';
import 'package:social_media_app/features/status/presentation/bloc/cubit/select_color_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/location/data/datasource/local/location_local_datasource.dart';
import 'package:social_media_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:social_media_app/features/location/domain/repositories/location_repository.dart';
import 'package:social_media_app/features/location/domain/usecases/get_location.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/post_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/data/repository/post_feed_repository_impl.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/profile/data/data_source/user_profile_data_source.dart';
import 'package:social_media_app/features/profile/data/data_source/user_posts_remote_datasource.dart';
import 'package:social_media_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:social_media_app/features/profile/data/repository/user_post_repository_impl.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/add_interests/select_interest_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/who_visited_premium_feature/data/datasource/who_visited_data_source.dart';
import 'package:social_media_app/features/who_visited_premium_feature/data/repository/who_visited_repo_impl.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/repositories/who_visited_repository.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/usecases/add_visited_user.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/usecases/get_all_visited_user.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/bloc/who_visited/who_visited_bloc.dart';

import 'features/profile/domain/usecases/get_my_liked_posts.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _commonProviders();
  _initAuth();
  _initProfile();
  _initLocation();
  _localAsset();
  _post();
  _call();
  _notification();
  _getUserPosts();
  _postFeed();
  _statusCreation();
  _settings();
  _comment();
  _exploreApp();
  _whoVisitedPremiumFeature();
  _premiumsubscription();
  _chat();
  serviceLocator.registerLazySingleton(
    () => AppUserBloc(),
  );
  serviceLocator.registerLazySingleton(() => FollowingCubit());
  serviceLocator.registerLazySingleton(() => InitialSetupCubit(
      getAllStatusBloc: serviceLocator(),
      getMyStatusBloc: serviceLocator(),
      followingCubit: serviceLocator(),
      followingPostFeedBloc: serviceLocator(),
      getUserPostsBloc: serviceLocator()));
}

void _commonProviders() {
  serviceLocator
    ..registerLazySingleton(() => PickMultipleImageCubit())
    ..registerFactory(() => PickSingleImageCubit());
}

void _initAuth() {
  //Auth remote data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthremoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firebaseStorage: FirebaseFirestore.instance),
    )
    //Auth repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authremoteDataSource: serviceLocator(),
      ),
    )
    //usecase for signup for the user
    ..registerFactory(
      () => UserSignup(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(() => CurrentUser(serviceLocator()))
    //Auth bloc
    ..registerLazySingleton(
      () => SignupBloc(
        appUserBloc: serviceLocator(),
        userSignUp: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GoogleAuthUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GoogleAuthBloc(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
      () => LoginUserUseCase(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => LoginBloc(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => ForgotPasswordUseCase(serviceLocator()))
    ..registerLazySingleton(
      () => ForgotPasswordBloc(serviceLocator()),
    )
    ..registerFactory(() => AuthBloc(serviceLocator(), serviceLocator()));
}

void _initProfile() {
  serviceLocator
    ..registerFactory<UserProfileDataSource>(() => UserProfileDataSourceImpl(
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance))
    ..registerFactory<UserProfileRepository>(() =>
        UserProfileRepositoryImpl(userProfileDataSource: serviceLocator()))
    ..registerFactory(
      () => CreateUserProfileUseCase(profileRepository: serviceLocator()),
    )
    ..registerFactory(
        () => CheckUsernameExistUseCasse(profileRepository: serviceLocator()))
    ..registerLazySingleton(
      () => ProfileBloc(serviceLocator(), serviceLocator(), serviceLocator(),
          serviceLocator()),
    )
    ..registerFactory(
        () => AddInterestUseCase(profileRepository: serviceLocator()))
    ..registerLazySingleton(() => SelectInterestCubit(serviceLocator()))
    ..registerFactory<OtherUserDataSource>(() =>
        OtherUserDataSourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<OtherUserRepository>(() =>
        OtherUserProfileRepositoryImpl(otherUserDataSource: serviceLocator()))
    ..registerFactory(() =>
        GetOtherUserDetailsUseCase(userProfileRepository: serviceLocator()))
    ..registerFactory(() => OtherProfileCubit(serviceLocator()))
    ..registerFactory(
        () => FollowUserUseCase(userProfileRepository: serviceLocator()))
    ..registerFactory(
        () => UnfollowUserUseCase(userProfileRepository: serviceLocator()))
    ..registerLazySingleton(() => FollowunfollowCubit(
        serviceLocator(), serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => GetOtherUserPostsCubit(serviceLocator()))
    ..registerFactory(
        () => GetFollowingListUseCase(userProfileRepository: serviceLocator()))
    ..registerFactory(
        () => GetFollowersListUseCase(userProfileRepository: serviceLocator()))
    ..registerFactory(() => GetFollowersCubit(serviceLocator()))
    ..registerFactory(() => GetFollowingListCubit(serviceLocator()));
}

void _initLocation() {
  serviceLocator
    ..registerFactory<LocationLocalDataSource>(
        () => LocationLocalDataSourceImpl())
    ..registerFactory<LocationRepository>(
        () => LocationRepositoryImpl(locationLocalDataSource: serviceLocator()))
    ..registerFactory(
        () => GetLocationUseCase(locationRepository: serviceLocator()));
}

void _localAsset() {
  serviceLocator
    ..registerFactory<AssetLocalSource>(() => AssetLocalSourceImpl())
    ..registerFactory<AssetRepository>(
        () => AssetRepositoryImpl(assetLocalSource: serviceLocator()))
    ..registerFactory(() => LoadAssetsUseCase(serviceLocator()))
    ..registerFactory(() => AssetsBloc(serviceLocator()))
    ..registerFactory(() => LoadAlbumsUseCase(serviceLocator()))
    ..registerFactory(() => AlbumBloc(
          serviceLocator(),
        ));
}

void _post() {
  serviceLocator
    ..registerFactory<PostRemoteDatasource>(() => PostRemoteDataSourceImpl(
        firestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance))
    ..registerFactory<PostRepository>(
        () => PostRepostioryImpl(serviceLocator()))
    ..registerFactory(
        () => SearchHashTagUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() => SearchHashtagBloc(serviceLocator()))
    ..registerFactory(
        () => CreatePostsUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() => CreatePostBloc(serviceLocator()))
    ..registerLazySingleton(() => UpdatePostBloc(serviceLocator()))
    ..registerFactory(
        () => DeletePostsUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() => DeletePostBloc(serviceLocator()))
    ..registerFactory(() => LikePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(
        () => UnlikePostsUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() =>
        LikePostBloc(serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(() => SelectTagsCubit());
}

void _getUserPosts() {
  serviceLocator
    ..registerFactory<UserPostsRemoteDataSource>(
        () => UserPostsRemoteDatasourceImpl())
    ..registerFactory<UserPostsRepository>(() =>
        UserPostRepositoryImpl(userPostsRemoteDataSource: serviceLocator()))
    ..registerFactory(
        () => GetUserPostsUseCase(userPostRepository: serviceLocator()))
    ..registerFactory(
        () => UpdatePostsUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() => GetUserPostsBloc(serviceLocator()))
    ..registerFactory(
        () => GetMyLikedPostsUseCase(userPostRepository: serviceLocator()))
    ..registerFactory(() => GetUserLikedPostsCubit(serviceLocator()));
}

void _postFeed() {
  serviceLocator
    ..registerFactory<PostFeedRemoteDatasource>(() =>
        PostFeedRemoteDatasourceImpl(firestore: FirebaseFirestore.instance))
    ..registerFactory<PostFeedRepository>(
        () => PostFeedRepositoryImpl(feedRemoteDatasource: serviceLocator()))
    ..registerFactory(
        () => GetFollowingPostsUseCase(postFeedRepository: serviceLocator()))
    ..registerLazySingleton(() => (FollowingPostFeedBloc(serviceLocator())))
    ..registerFactory<StatusFeedRemoteDatasource>(() =>
        StatusFeedRemoteDatasourceimpl(
            firebasefirestore: FirebaseFirestore.instance))
    ..registerFactory<StatusFeedRepository>(() =>
        StatusFeedRepositoryImpl(statusFeedRemoteDatasource: serviceLocator()))
    ..registerFactory(() => GetMyStatusUseCase(repository: serviceLocator()))
    ..registerLazySingleton(() => GetMyStatusBloc(
          getMyStatusUseCase: serviceLocator(),
        ))
    ..registerFactory(() => GetAllStatusesUseCase(repository: serviceLocator()))
    ..registerLazySingleton(
        () => GetAllStatusBloc(getAllStatusesUseCase: serviceLocator()))
    ..registerFactory(
        () => GetForYouPostsUseCase(postFeedRepository: serviceLocator()))
    ..registerLazySingleton(() => ForYouPostBloc(serviceLocator()));
}

void _comment() {
  serviceLocator
    ..registerFactory<CommentRemoteDatasource>(() =>
        CommentRemoteDatasourceImpl(
            firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<CommentRepository>(
        () => CommentRepositoryImpl(commentRemoteDatasource: serviceLocator()))
    ..registerFactory(
        () => CreateCommentUsecase(commentRepository: serviceLocator()))
    ..registerFactory(
        () => UpdateCommentUseCase(commentRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteCommentUseCase(commentRepository: serviceLocator()))
    ..registerFactory(
        () => ReadCommentUseCase(commentRepository: serviceLocator()))
    ..registerFactory(
        () => LikeCommentUseCase(commentRepository: serviceLocator()))
    ..registerFactory(
        () => RemoveLikeCommentUseCase(commentRepository: serviceLocator()))
    ..registerLazySingleton(
        () => LikeCommentCubit(serviceLocator(), serviceLocator()))
    ..registerFactory(() => GetPostCommentCubit(serviceLocator()))
    ..registerFactory(() => CommentBasicCubit(
        notificationCubit: serviceLocator(),
        createCommentUsecase: serviceLocator(),
        updateCommentUseCase: serviceLocator(),
        deleteCommentUseCase: serviceLocator()));
}

void _statusCreation() {
  serviceLocator
    ..registerFactory<StatusRemoteDatasource>(() => StatusRemoteDatasourceImpl(
        firestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance))
    ..registerFactory<StatusRepository>(() =>
        CreateStatusRepositoryImpl(statusRemoteDatasource: serviceLocator()))
    ..registerFactory(
        () => CreateStatusUseCase(createStatusRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteStatuseCase(statusRepository: serviceLocator()))
    ..registerFactory(
        () => SeeenStatusUpdateUseCase(statusRepository: serviceLocator()))
    ..registerFactory(() =>
        CreateMultipleStatusUseCase(createStatusRepository: serviceLocator()))
    ..registerLazySingleton(
        () => DeleteStatusBloc(deleteStatusUseCase: serviceLocator()))
    ..registerLazySingleton(() => (StatusBloc(
        createStatusUseCase: serviceLocator(),
        deleteStatuseCase: serviceLocator(),
        seeenStatusUpdateUseCase: serviceLocator(),
        createMultipleStatusUseCase: serviceLocator())))
    ..registerLazySingleton(() => SelectColorCubit());
}

void _exploreApp() {
  serviceLocator
    ..registerFactory<ExploreAppDatasource>(() =>
        ExploreAppDatasourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<ExploreAppRepository>(
        () => ExploreAppRepoImpl(exploreAppDatasource: serviceLocator()))
    ..registerFactory(
        () => SearchUserUseCase(exploreAppRepository: serviceLocator()))
    ..registerLazySingleton(() => SearchUserCubit(serviceLocator()))
    ..registerFactory(
        () => SearchHashTagsUseCase(exploreAppRepository: serviceLocator()))
    ..registerLazySingleton(() => SearchHashTagCubit(serviceLocator()))
    ..registerFactory(
        () => GetRecommendedPostUseCase(exploreAppRepository: serviceLocator()))
    ..registerLazySingleton(() => GetRecommendedPostCubit(serviceLocator()))
    ..registerFactory(() =>
        SearchLocationsExploreUseCase(exploreAppRepository: serviceLocator()))
    ..registerLazySingleton(() => SearchLocationExploreCubit(serviceLocator()))
    ..registerFactory(() =>
        GetRecentPostsHashtagUseCase(exploreAppRepository: serviceLocator()))
    ..registerLazySingleton(
        () => GetHashtagTopPostsUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => GetHashTagPostsCubit(
          serviceLocator(),
        ))
    ..registerFactory(() => GetRecentHashtagPostsCubit(serviceLocator()))
   
    ..registerFactory(
        () => ExploreUserCubit(serviceLocator(), ))
    ..registerFactory(
        () => GetNearybyUsersUseCase(exploreAppRepository: serviceLocator()));
}

void _chat() {
  serviceLocator
    ..registerFactory<ChatRemoteDatasource>(() => ChatRemoteDatasourceImpl(
        firestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance))
    ..registerFactory<ChatRepository>(
        () => ChatRepositoryImpl(chatRemoteDatasource: serviceLocator()))
    ..registerFactory(() => DeleteChatUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteMessageUsecase(chatRepository: serviceLocator()))
    ..registerFactory(() => GetMyChatsUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => GetSingleUserMessageUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => SeenMessageUpdateUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => SendMessageUseCase(chatRepository: serviceLocator()))
    ..registerLazySingleton(() =>
        MessageInfoStoreCubit(id: serviceLocator<AppUserBloc>().appUser.id))
    ..registerFactory(() => MessageCubit(serviceLocator(), serviceLocator(),
        serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(
        () => MessageAttributeBloc(serviceLocator(), serviceLocator()))
    ..registerFactory(() => ChatCubit(serviceLocator(),serviceLocator()));
}

void _call() {
  serviceLocator
    ..registerFactory<CallRemoteDatasource>(() =>
        CallRemoteDatasourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<CallRepository>(
        () => CallRepositoryImpl(callRemoteDatasource: serviceLocator()))
    ..registerFactory(() => MakeCallUseCase(callRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllChannelIdUseCase(callRepository: serviceLocator()))
    ..registerFactory(() => EndCallUseCase(callRepository: serviceLocator()))
    ..registerFactory(
        () => SaveCallHistoryUseCase(callRepository: serviceLocator()))
    ..registerFactory(
        () => GetUserCallingUseCase(callRepository: serviceLocator()))
    // ..registerLazySingleton(() => AgoraCubit())
    ..registerLazySingleton(() => CallCubit(
        getUserCallingUseCase: serviceLocator(),
        makeCallUseCase: serviceLocator(),
        messageStroreCubit: serviceLocator(),
        endCallUseCase: serviceLocator(),
        saveCallHistoryUseCase: serviceLocator()))
    ..registerLazySingleton(() => CallHistoryCubit());
}

void _notification() {
  serviceLocator
    ..registerFactory<NotificationDatasource>(() => NotificationDatasourceImple(
        firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<NotificationRepository>(() =>
        NotificationRepositoryImpl(notificationDatasource: serviceLocator()))
    ..registerFactory(() =>
        CreateNotificationUseCase(notificationRepository: serviceLocator()))
    ..registerFactory(() =>
        DeleteNotificationUseCase(notificationRepository: serviceLocator()))
    ..registerFactory(() =>
        GetMyNotificationUseCase(notificationRepository: serviceLocator()))
    ..registerFactory(() =>
        DeleteMyNotificationUseCase(notificationRepository: serviceLocator()))
    ..registerLazySingleton(() => NotificationCubit(serviceLocator(),
        serviceLocator(), serviceLocator(), serviceLocator()));
}

void _premiumsubscription() {
  serviceLocator
    ..registerFactory<PremiumSubscriptionDatasource>(
        () => PremiumSubscriptionDatasourceImpl())
    ..registerFactory<PremiumSubscriptionRepository>(() =>
        PremiumSubsriptionRepoImpl(
            premiumSubscriptionDatasource: serviceLocator()))
    ..registerFactory(() => CreatePaymentIntentUseCase(
        premiumSubscriptionRepository: serviceLocator()))
    ..registerFactory(() => SetupStripeForPaymentUseCase(
        premiumSubscriptionRepository: serviceLocator()))
    ..registerFactory(() => UpdateUserPremiumStatusUseCase(
        premiumSubscriptionRepository: serviceLocator()))
    ..registerLazySingleton(
        () => PremiumSubscriptionBloc(serviceLocator(), serviceLocator()));
}

void _whoVisitedPremiumFeature() {
  serviceLocator
    ..registerFactory<WhoVisitedDataSource>(() =>
        WhoVisitedDataSourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<WhoVisitedRepository>(
        () => WhoVisitedRepoImpl(whoVisitedDataSource: serviceLocator()))
    ..registerFactory(
        () => AddVisitedUserUseCase(whoVisitedRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllVisitedUserUseCase(whoVisitedRepository: serviceLocator()))
    ..registerLazySingleton(
        () => WhoVisitedBloc(serviceLocator(), serviceLocator()));
}

void _settings() {
  serviceLocator
    ..registerFactory<SettingsDatasource>(() =>
        SettingsDatasourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<SettingsRepository>(
        () => SettingRepoImpl(settingsDatasource: serviceLocator()))
    ..registerFactory(() =>
        EditNotificationPreferenceUseCase(settingsRepository: serviceLocator()))
    ..registerLazySingleton(() => SettingsCubit(serviceLocator()));
}
