part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

final class PostDeleteEvent extends CreatePostEvent {
  final String postId;
  final List<String> postMedias;

  const PostDeleteEvent({required this.postId, required this.postMedias});
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
  final bool isReel;
  final List<Uint8List>? postImgesFromWeb;
  final bool isWeb;
  const CreatePostClickEvent(
      {required this.postPics,
      required this.creatorUid,
      required this.userFullName,
      required this.username,
      required this.isCommentOff,
      required this.description,
      required this.userProfileUrl,
      required this.isReel,
      required this.hashtags,
      this.postImgesFromWeb,
      required this.latitude,
      required this.longitude,
      this.isWeb = false,
      required this.location});
}

final class UpdatePostEvent extends CreatePostEvent {
  final List<String> hashtags;
  // final double? latitude;
  // final double? longitude;
  // final String? location;
  final String? description;
  final PartialUser user;
  final String postId;
  final List<String> oldPostHashTags;
  const UpdatePostEvent({
    required this.hashtags,
    required this.oldPostHashTags,
    required this.postId,
    required this.description,
    required this.user,
  });
}
