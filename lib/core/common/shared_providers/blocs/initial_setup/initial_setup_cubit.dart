// import 'dart:developer';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
// import 'package:social_media_app/core/shared_providers/cubit/following_cubit.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
// import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
// import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
// import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';

// part 'initial_setup_state.dart';

// class InitialSetupCubit extends Cubit<InitialSetupState> {
//   final GetAllStatusBloc _getAllStatusBloc;
//   final GetMyStatusBloc _getMyStatusBloc;
//   final FollowingPostFeedBloc _followingPostFeedBloc;
//   final GetUserPostsBloc _getUserPostsBloc;
//   final FollowingCubit _followingCubit;
//   InitialSetupCubit({
//     required GetAllStatusBloc getAllStatusBloc,
//     required GetMyStatusBloc getMyStatusBloc,
//     required FollowingPostFeedBloc followingPostFeedBloc,
//     required GetUserPostsBloc getUserPostsBloc,
//     required FollowingCubit followingCubit,
//   })  : _getAllStatusBloc = getAllStatusBloc,
//         _getMyStatusBloc = getMyStatusBloc,
//         _followingPostFeedBloc = followingPostFeedBloc,
//         _getUserPostsBloc = getUserPostsBloc,
//         _followingCubit = followingCubit,
//         super(InitialSetupInitial());

//   void startInitialSetup(
//       {required String uId,
//       bool isFirstTime = false,
//       required List<String> following}) {
//     log('called the initial setup bloc');
//     _getAllStatusBloc.add(GetAllstatusesEvent(uId: uId));
//     _getMyStatusBloc.add(GetAllMystatusesEvent(uId: uId));
//     _followingPostFeedBloc.add(FollowingPostFeedGetEvent(
//         isLoadMore: false, lastDoc: null, uId: uId, following: following));
//     _followingCubit.listenToFollowing(uId);
//     // _getUserPostsBloc.add(GetUserPostsrequestedEvent(uid: uId));
//   }
// }
