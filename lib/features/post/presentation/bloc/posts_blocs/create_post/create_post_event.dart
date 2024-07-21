part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

final class CreatePostClickEvent extends CreatePostEvent {
  final String creatorUid;
  final String username;

  final String? description;
  final String userFullName;
  final String? userProfileUrl;
  final List<String> hashtags;
  final double? latitude;
  final double? longitude;
  final String? location;
  final List<SelectedByte> postPics;
  final bool isCommentOff;

  const CreatePostClickEvent(
      {required this.postPics,
      required this.creatorUid,
      required this.userFullName,
      required this.username,
      required this.isCommentOff,
      required this.description,
      required this.userProfileUrl,
      required this.hashtags,
      required this.latitude,
      required this.longitude,
      required this.location});
}
