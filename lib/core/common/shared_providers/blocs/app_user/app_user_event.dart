import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';

sealed class AppUserEvent extends Equatable {
  const AppUserEvent();

  @override
  List<Object> get props => [];
}

final class AppUserInitial extends AppUserEvent {}

final class AppGetCurrentUser extends AppUserEvent {}

final class UpdateUserModelEvent extends AppUserEvent {
  final AppUser userModel;
  const UpdateUserModelEvent({required this.userModel});
}

final class UpdateUserSignOutEvent extends AppUserEvent {}

final class EnsureUserModelExistsEvent extends AppUserEvent {}

final class UserOnlineStatusUpdate extends AppUserEvent {
  final bool status;

  const UserOnlineStatusUpdate({required this.status});
}
