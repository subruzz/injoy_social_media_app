part of 'update_post_bloc.dart';

sealed class UpdatePostEvent extends Equatable {
  const UpdatePostEvent();

  @override
  List<Object> get props => [];
}

final class UpdatePost extends UpdatePostEvent {
  final List<String> hashtags;
  // final double? latitude;
  // final double? longitude;
  // final String? location;
  final String? description;
  final String postId;

  const UpdatePost({
    required this.hashtags,
    required this.description,
    required this.postId,
  });
}
