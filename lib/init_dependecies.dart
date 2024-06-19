import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
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
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/create_post/data/datasources/local/asset_local_source.dart';
import 'package:social_media_app/features/create_post/data/datasources/remote/post_remote_datasource.dart';
import 'package:social_media_app/features/create_post/data/repository/asset_repository_impl.dart';
import 'package:social_media_app/features/create_post/data/repository/post_repostiory_impl.dart';
import 'package:social_media_app/features/create_post/domain/repositories/asset_repository.dart';
import 'package:social_media_app/features/create_post/domain/repositories/post_repository.dart';
import 'package:social_media_app/features/create_post/domain/usecases/create_posts.dart';
import 'package:social_media_app/features/create_post/domain/usecases/get_assets.dart';
import 'package:social_media_app/features/create_post/domain/usecases/searh_hashtag.dart';
import 'package:social_media_app/features/create_post/features/bloc/assset_bloc/asset_bloc_bloc.dart';
import 'package:social_media_app/features/create_post/features/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/create_post/features/bloc/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/create_post/features/bloc/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/location/data/datasource/local/location_local_datasource.dart';
import 'package:social_media_app/features/location/data/repositories/location_repository_impl.dart';
import 'package:social_media_app/features/location/domain/repositories/location_repository.dart';
import 'package:social_media_app/features/location/domain/usecases/get_location.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/profile/data/data_source/user_profile_data_source.dart';
import 'package:social_media_app/features/profile/data/data_source/user_posts_remote_datasource.dart';
import 'package:social_media_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:social_media_app/features/profile/data/repository/user_post_repository_impl.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
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
  serviceLocator.registerLazySingleton(
    () => AppUserBloc(serviceLocator()),
  );
}

void _commonProviders() {
  serviceLocator
    ..registerFactory(() => PickMultipleImageCubit())
    ..registerFactory(() => PickSingleImageCubit());
}

void _initAuth() {
  //Auth remote data source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthremoteDataSourceImpl(),
    )
    //Auth repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
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
      () => GoogleAuthBloc(
        serviceLocator(),
      ),
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
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<UserProfileDataSource>(() => UserProfileDataSourceImpl())
    ..registerFactory<UserProfileRepository>(() =>
        UserProfileRepositoryImpl(userProfileDataSource: serviceLocator()))
    ..registerFactory(
      () => CreateUserProfileUseCase(profileRepository: serviceLocator()),
    )
    ..registerLazySingleton(
      () => ProfileBloc(serviceLocator(), serviceLocator()),
    );
}

void _initLocation() {
  serviceLocator
    ..registerFactory<LocationLocalDataSource>(
        () => LocationLocalDataSourceImpl())
    ..registerFactory<LocationRepository>(
        () => LocationRepositoryImpl(locationLocalDataSource: serviceLocator()))
    ..registerFactory(
        () => GetLocationUseCase(locationRepository: serviceLocator()))
    ..registerFactory(() => LocationBloc(serviceLocator()));
}

void _localAsset() {
  serviceLocator
    ..registerFactory<AssetLocalSource>(() => AssetLocalSourceImpl())
    ..registerFactory<AssetRepository>(
        () => AssetRepositoryImpl(assetLocalSource: serviceLocator()))
    ..registerFactory(() => LoadAssetsUseCase(serviceLocator()))
    ..registerLazySingleton(() => AssetBlocBloc(serviceLocator()));
}

void _post() {
  serviceLocator
    ..registerFactory<PostRemoteDatasource>(() => PostRemoteDataSourceImpl())
    ..registerFactory<PostRepository>(
        () => PostRepostioryImpl(serviceLocator()))
    ..registerFactory(
        () => SearchHashTagUseCase(postRepository: serviceLocator()))
    ..registerFactory(() => SearchHashtagBloc(serviceLocator()))
    ..registerFactory(
        () => CreatePostsUseCase(postRepository: serviceLocator()))
    ..registerLazySingleton(() => CreatePostBloc(serviceLocator()))
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
    ..registerLazySingleton(() => GetUserPostsBloc(serviceLocator()));
}
