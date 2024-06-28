// import 'dart:async';

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/common/entities/status_entity.dart';
// import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';
// import 'package:social_media_app/features/post_status_feed/data/datasource/post_feed_remote_datasource.dart';
// import 'package:social_media_app/features/post_status_feed/domain/usecases/view_current_user_status.dart';

// part 'view_status_event.dart';
// part 'view_status_state.dart';

// class ViewStatusBloc extends Bloc<ViewStatusEvent, ViewStatusState> {
//   final ViewCurrentUserStatusUseCase _currentUserStatusUseCase;
//   ViewStatusBloc(this._currentUserStatusUseCase) : super(ViewStatusInitial()) {
//     on<ViewStatusEvent>((event, emit) {
//       emit(ViewStatusLoading());
//     });
//     on<ViewCurrentUserStatusEvent>(_viewcurrentUserStatus);
//   }

//   FutureOr<void> _viewcurrentUserStatus(
//       ViewCurrentUserStatusEvent event, Emitter<ViewStatusState> emit) async {
//     try {
//       final res = await PostFeedRemoteDatasourceImpl()
//           .fetchCurrentUserAndFollowingStatuses(event.uId);

//       emit(ViewStatusSuccess(statuses: res));
//     } on Exception catch (e) {
//       emit(ViewStatusError());
//     }

//     //  _currentUserStatusUseCase(
//     //     ViewCurrentUserStatusUseCaseParams(uid: event.uId));
//     // res.fold((failure) => emit(ViewStatusError()),
//     //     (success) => emit(ViewStatusSuccess(statuses: success)));
//   }
// }
