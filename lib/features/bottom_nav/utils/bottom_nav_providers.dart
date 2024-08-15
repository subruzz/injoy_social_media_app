
part of '../presentation/pages/bottom_nav.dart';



List<SingleChildWidget> _getBottomBarProviders(AppUser user) {
  return [
    BlocProvider(create: (context) {
      return serviceLocator<FollowingPostFeedBloc>()
        ..add(FollowingPostFeedGetEvent(
            isLoadMore: false,
            lastDoc: null,
            isFirst: true,
            following: user.following,
            uId: user.id));
    }),
    BlocProvider(create: (context) {
      return serviceLocator<ReelsCubit>()..getReels(user.id);
    }),
    BlocProvider(
      create: (context) => serviceLocator<GetMyStatusBloc>()
        ..add(GetAllMystatusesEvent(uId: user.id)),
    ),
    BlocProvider(
        create: (context) => serviceLocator<GetAllStatusBloc>()
          ..add(GetAllstatusesEvent(uId: user.id))),
    BlocProvider(
      create: (context) =>
          serviceLocator<ExploreAllPostsCubit>()..getAllposts(myId: user.id),
    ),
    BlocProvider(
        create: (context) =>
            serviceLocator<ChatCubit>()..getMyChats(myId: user.id)),
  ];
}
