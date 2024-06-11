import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/bloc/app_user_bloc.dart';
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
import 'package:social_media_app/features/profile/data/data_source/user_profile_data_source.dart';
import 'package:social_media_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';
import 'package:social_media_app/features/profile/domain/usecases/create_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  serviceLocator.registerLazySingleton(
    () => AppUserBloc(serviceLocator()),
  );
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
      () => LoginBloc(
        serviceLocator(),
      ),
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
      () => ProfileBloc(serviceLocator()),
    );
}
