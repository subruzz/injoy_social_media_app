import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

class HashtagModel extends HashTag {
  HashtagModel({
    required super.hashtagName,
    required super.count,
  });

  factory HashtagModel.fromJson(Map<String, dynamic> json) {
    return HashtagModel(
      hashtagName: json['hashtagName'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hashtagName': hashtagName,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'HashtagModel{hashtagName: $hashtagName, count: $count,}';
  }
}
