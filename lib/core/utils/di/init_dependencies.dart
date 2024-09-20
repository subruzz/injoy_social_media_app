part of 'di.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
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
  _settingsAndActivity();
  _comment();
  _exploreApp();
  _whoVisitedPremiumFeature();
  _premiumsubscription();
  _chat();
  _aiChat();
  _reels();
  _serviceClasses();
  serviceLocator.registerLazySingleton(
    () => AppUserBloc(),
  );

  serviceLocator.registerFactory(
      () => FirebaseHelper(firestore: FirebaseFirestore.instance));
  // serviceLocator.registerFactory(() => InitialSetupCubit(
  //     getAllStatusBloc: serviceLocator(),
  //     getMyStatusBloc: serviceLocator(),
  //     followingCubit: serviceLocator(),
  //     followingPostFeedBloc: serviceLocator(),
  //     getUserPostsBloc: serviceLocator()));
}

void _serviceClasses() {
  serviceLocator.registerLazySingleton(
      () => FirebaseStorageService(firebaseStorage: FirebaseStorage.instance));
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
    ..registerFactory(
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
    ..registerFactory(
      () => LoginBloc(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => ForgotPasswordUseCase(serviceLocator()))
    ..registerFactory(
      () => ForgotPasswordBloc(serviceLocator()),
    )
    ..registerFactory(() => LogoutUserUseCase(serviceLocator()))
    ..registerLazySingleton(
        () => AuthBloc(serviceLocator(), serviceLocator(), serviceLocator()));
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
    ..registerFactory(() => UserNameCubit(serviceLocator()))
    ..registerFactory(() => ProfileBloc(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerFactory(
        () => AddInterestUseCase(profileRepository: serviceLocator()))
    ..registerFactory(() => SelectInterestCubit(serviceLocator()))
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
    ..registerFactory(() => FollowunfollowCubit(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerFactory(() => GetOtherUserPostsCubit(serviceLocator()))
    ..registerFactory(
        () => GetFollowingListUseCase(userDatRepository: serviceLocator()))
    ..registerFactory(
        () => GetFollowersListUseCase(userDatRepository: serviceLocator()))
    ..registerFactory(() => GetFollowersCubit(serviceLocator()))
    ..registerFactory(() => GetFollowingListCubit(serviceLocator()));
}

void _initLocation() {
  serviceLocator
    ..registerFactory<LocationLocalDataSource>(
        () => LocationLocalDataSourceImpl())
    ..registerFactory<SearchLocationDataSource>(
        () => SearchLocationDataSourceImpl())
    ..registerFactory(
        () => SearchLocationUseCase(locationRepository: serviceLocator()))
    ..registerFactory<LocationRepository>(() => LocationRepositoryImpl(
        locationLocalDataSource: serviceLocator(), serviceLocator()))
    ..registerFactory(() => LocationBloc(serviceLocator(), serviceLocator()))
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
    ..registerFactory(() => SearchHashtagBloc(serviceLocator()))
    ..registerFactory(
        () => CreatePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(() =>
        CreatePostBloc(serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(
        () => DeletePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(() => LikePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(
        () => UnlikePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(() => LikePostBloc(
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerFactory(() => SelectTagsCubit())
    ..registerFactory(() => SavePostUseCase(postRepository: serviceLocator()))
    ..registerFactory(() => SavePostCubit(serviceLocator()));
}

void _getUserPosts() {
  serviceLocator
    ..registerFactory<UserDataDatasource>(() => UserDataDatasourceImpl())
    ..registerFactory<UserDatRepository>(
        () => UserDataRepoImpl(userPostsRemoteDataSource: serviceLocator()))
    ..registerFactory(
        () => GetUserPostsUseCase(userPostRepository: serviceLocator()))
    ..registerFactory(
        () => UpdatePostsUseCase(postRepository: serviceLocator()))
    ..registerFactory(() => GetUserPostsBloc(serviceLocator()))
    ..registerFactory(
        () => GetMyLikedPostsUseCase(userPostRepository: serviceLocator()))
    ..registerFactory(() => GetUserLikedPostsCubit(serviceLocator()))
    ..registerFactory(
        () => GetUserShortsUseCase(userPostRepository: serviceLocator()))
    ..registerFactory(() => GetMyReelsCubit(serviceLocator()))
    ..registerFactory(() => GetOtherUserShortsCubit(serviceLocator()))
    ..registerFactory(
        () => GetStatusViewersUseCase(statusFeedRepository: serviceLocator()))
    ..registerFactory(() => StatusViewersCubit(serviceLocator()));
}

void _postFeed() {
  serviceLocator
    ..registerFactory<PostFeedRemoteDatasource>(() =>
        PostFeedRemoteDatasourceImpl(firestore: FirebaseFirestore.instance))
    ..registerFactory<PostFeedRepository>(
        () => PostFeedRepositoryImpl(feedRemoteDatasource: serviceLocator()))
    ..registerFactory(
        () => GetFollowingPostsUseCase(postFeedRepository: serviceLocator()))
    ..registerFactory(
        () => GetAllUsersUseCase(postFeedRepository: serviceLocator()))
    ..registerFactory(
        () => (FollowingPostFeedBloc(serviceLocator(), serviceLocator())))
    ..registerFactory<StatusFeedRemoteDatasource>(() =>
        StatusFeedRemoteDatasourceimpl(
            firebasefirestore: FirebaseFirestore.instance))
    ..registerFactory<StatusFeedRepository>(() =>
        StatusFeedRepositoryImpl(statusFeedRemoteDatasource: serviceLocator()))
    ..registerFactory(() => GetMyStatusUseCase(repository: serviceLocator()))
    ..registerFactory(() => GetMyStatusBloc(
          getMyStatusUseCase: serviceLocator(),
        ))
    ..registerFactory(() => GetAllStatusesUseCase(repository: serviceLocator()))
    ..registerFactory(
        () => GetAllStatusBloc(getAllStatusesUseCase: serviceLocator()))
    ..registerFactory(
        () => GetForYouPostsUseCase(postFeedRepository: serviceLocator()))
    ..registerFactory(() => ForYouPostBloc(serviceLocator()));
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
    ..registerFactory(
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
    ..registerFactory(
        () => DeleteStatusBloc(deleteStatusUseCase: serviceLocator()))
    ..registerFactory(() => (StatusBloc(
        createStatusUseCase: serviceLocator(),
        deleteStatuseCase: serviceLocator(),
        seeenStatusUpdateUseCase: serviceLocator(),
        createMultipleStatusUseCase: serviceLocator())))
    ..registerFactory(() => SelectColorCubit());
}

void _exploreApp() {
  serviceLocator
    ..registerFactory<ExploreAppDatasource>(() =>
        ExploreAppDatasourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<ExploreAppRepository>(
        () => ExploreAppRepoImpl(exploreAppDatasource: serviceLocator()))
    ..registerFactory(
        () => SearchUserUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => SearchUserCubit(serviceLocator()))
    ..registerFactory(
        () => SearchHashTagsUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => SearchHashTagCubit(serviceLocator()))
    ..registerFactory(
        () => GetRecommendedPostUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => GetRecommendedPostCubit(serviceLocator()))
    ..registerFactory(() =>
        SearchLocationsExploreUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => SearchLocationExploreCubit(serviceLocator()))
    ..registerFactory(() =>
        GetShortsOfTagOrLocationUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => GetHashtagOrLocationPostsUseCase(
        exploreAppRepository: serviceLocator()))
    ..registerFactory(() => GetTagOrLocationPostsCubit(
          serviceLocator(),
        ))
    ..registerFactory(
        () => GetAllPostsUseCase(exploreAppRepository: serviceLocator()))
    ..registerFactory(() => GetShortsHashtagOrLocationCubit(serviceLocator()))
    ..registerFactory(() => ExploreAllPostsCubit(
          serviceLocator(),
        ))
    ..registerFactory(() => GetSuggestedPostsFromPostUseCase(
        exploreAppRepository: serviceLocator()));
}

void _chat() {
  serviceLocator
    ..registerFactory<ChatRemoteDatasource>(() => ChatRemoteDatasourceImpl(
        firestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance))
    ..registerFactory<ChatRepository>(
        () => ChatRepositoryImpl(chatRemoteDatasource: serviceLocator()))
    ..registerFactory(
        () => DeleteChatUsecase(settingsRepository: serviceLocator()))
    ..registerFactory(
        () => DeleteMessageUsecase(chatRepository: serviceLocator()))
    ..registerFactory(() => GetMyChatsUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => GetSingleUserMessageUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => SeenMessageUpdateUsecase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => SendMessageUseCase(chatRepository: serviceLocator()))
    // ..registerFactory(() =>
    //     MessageInfoStoreCubit(id: serviceLocator<AppUserBloc>().appUser.id))
    // ..registerFactory(()=>RecieverChatInfoCubit())
    ..registerFactory(
        () => DeleteSingleChatUseCase(chatRepository: serviceLocator()))
    ..registerFactory(
        () => BlockUnblockChatUseCase(chatRepository: serviceLocator()))
    ..registerFactory(() => GetMessageCubit(serviceLocator()))
    ..registerFactory(() => MessageCubit(serviceLocator(), serviceLocator(),
        serviceLocator(), serviceLocator(), serviceLocator(),serviceLocator()))
    // ..registerFactory(
    //     () => MessageAttributeBloc(serviceLocator(), serviceLocator()))
    ..registerFactory(() => ChatCubit(serviceLocator(), serviceLocator()));
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
    // ..registerFactory(() => AgoraCubit())
    // ..registerFactory(() => CallCubit(
    //     getUserCallingUseCase: serviceLocator(),
    //     makeCallUseCase: serviceLocator(),
    //     messageStroreCubit: serviceLocator(),
    //     endCallUseCase: serviceLocator(),
    //     saveCallHistoryUseCase: serviceLocator()))
    ..registerFactory(() => CallHistoryCubit());
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
    ..registerFactory(() => NotificationCubit(serviceLocator(),
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
    ..registerFactory(
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
    ..registerFactory(() => WhoVisitedBloc(serviceLocator(), serviceLocator()));
}

void _settingsAndActivity() {
  serviceLocator
    ..registerFactory<SettingsDatasource>(() =>
        SettingsDatasourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<SettingsRepository>(
        () => SettingRepoImpl(settingsDatasource: serviceLocator()))
    ..registerFactory(() =>
        EditNotificationPreferenceUseCase(settingsRepository: serviceLocator()))
    ..registerFactory(() => SettingsCubit(serviceLocator(), serviceLocator()))
    ..registerFactory<LibraryDataSource>(() =>
        LibraryDataSourceImpl(firebaseFirestore: FirebaseFirestore.instance))
    ..registerFactory<LibraryRepostory>(
        () => LibraryRepoImpl(libraryDataSource: serviceLocator()))
    ..registerFactory(
        () => GetLikedPostsUseCase(libraryRepostory: serviceLocator()))
    ..registerFactory(
        () => GetSavedPostsUseCase(libraryRepostory: serviceLocator()))
    ..registerFactory(
        () => LikedOrSavedPostsCubit(serviceLocator(), serviceLocator()));
}

void _aiChat() {
  serviceLocator
    ..registerFactory<AiChatDatasource>(() => AiChatDatasourceImpl())
    ..registerFactory<AiChatRepository>(
        () => AiChatRepoImpl(aiChatDatasource: serviceLocator()))
    ..registerFactory(
        () => GenerateAiMessageUseCase(aiChatRepository: serviceLocator()))
    ..registerFactory(() => AiChatCubit(serviceLocator()));
}

void _reels() {
  serviceLocator
    ..registerFactory<ReelsDataSource>(
        () => ReelsDataSourceImpl(firestore: FirebaseFirestore.instance))
    ..registerFactory<ReelsRepository>(
        () => ReelsRepoImpl(reelsDataSource: serviceLocator()))
    ..registerFactory(() => GetReelsUseCase(reelsRepository: serviceLocator()))
    ..registerFactory(() => ReelsCubit(serviceLocator()));
}
