import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
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
import 'package:social_media_app/features/post/data/datasources/local/asset_local_source.dart';
import 'package:social_media_app/features/post/data/datasources/remote/post_remote_datasource.dart';
import 'package:social_media_app/features/post/data/repository/asset_repository_impl.dart';
import 'package:social_media_app/features/post/data/repository/post_repostiory_impl.dart';
import 'package:social_media_app/features/post/domain/repositories/asset_repository.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';
import 'package:social_media_app/features/post/domain/usecases/create_posts.dart';
import 'package:social_media_app/features/post/domain/usecases/delete_post.dart';
import 'package:social_media_app/features/post/domain/usecases/get_albums.dart';
import 'package:social_media_app/features/post/domain/usecases/get_assets.dart';
import 'package:social_media_app/features/post/domain/usecases/like_post.dart';
import 'package:social_media_app/features/post/domain/usecases/searh_hashtag.dart';
import 'package:social_media_app/features/post/domain/usecases/update_post.dart';
import 'package:social_media_app/features/post/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/status_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/data/repository/status_feed_repository_impl.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';
import 'package:social_media_app/features/profile/domain/usecases/add_interest.dart';
import 'package:social_media_app/features/profile/domain/usecases/check_username_exist.dart';
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

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _commonProviders();
  _initAuth();
  _initProfile();
  _initLocation();
  _localAsset();
  _post();
  _getUserPosts();
  _postFeed();
  _statusCreation();
  serviceLocator.registerLazySingleton(
    () => AppUserBloc(),
  );
  serviceLocator.registerLazySingleton(() => InitialSetupCubit(
      getAllStatusBloc: serviceLocator(),
      getMyStatusBloc: serviceLocator(),
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
      () => ProfileBloc(serviceLocator(), serviceLocator(), serviceLocator()),
    )
    ..registerFactory(
        () => AddInterestUseCase(profileRepository: serviceLocator()))
    ..registerLazySingleton(() => SelectInterestCubit(serviceLocator()));
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
    ..registerLazySingleton(() => AssetsBloc(serviceLocator()))
    ..registerFactory(() => LoadAlbumsUseCase(serviceLocator()))
    ..registerLazySingleton(() => AlbumBloc(
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
    ..registerLazySingleton(() => LikePostBloc(serviceLocator()))
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
    ..registerLazySingleton(() => GetUserPostsBloc(serviceLocator()));
}

void _postFeed() {
  serviceLocator
    ..registerFactory<PostFeedRemoteDatasource>(
        () => PostFeedRemoteDatasourceImpl())
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
        () => GetAllStatusBloc(getAllStatusesUseCase: serviceLocator()));
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
