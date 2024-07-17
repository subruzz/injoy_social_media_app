import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

class UpdatePostModel extends UpdatePostEntity {
  UpdatePostModel({
    required super.hashtags,
    super.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'isEdited': true,
      'hashtags': hashtags,
      'description': description,
    };
  }
}
