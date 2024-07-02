import 'package:social_media_app/features/post/domain/enitities/update_post.dart';

class UpdateUserModel extends UpdatePostEntity {
  UpdateUserModel({
    required super.hashtags,
    super.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'hashtags': hashtags,
      'description': description,
    };
  }
}
