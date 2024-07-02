import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

class HashTagModel extends HashTag {
  HashTagModel({
    required super.posts,
    required super.hashTagName,
  });

  // Convert a HashTag object to a map
  Map<String, dynamic> toMap() {
    return {
      'posts': posts,
      'hashTagName': hashTagName,
      'count': count,
    };
  }

  // Create a HashTag object from a map
  factory HashTagModel.fromMap(Map<String, dynamic> map) {
    return HashTagModel(
      posts: List<String>.from(map['posts']),
      hashTagName: map['hashTagName'],
    );
  }

  // Create a HashTag object from a Firestore document snapshot
  factory HashTagModel.fromDocument(DocumentSnapshot doc) {
    return HashTagModel(
      posts: List<String>.from(doc['posts']),
      hashTagName: doc.id, // Assuming the document ID is the hashtag name
    );
  }

  // Convert a HashTag object to JSON
  Map<String, dynamic> toJson() {
    return {
      'posts': posts,
      'hashTagName': hashTagName,
    };
  }

  // Create a HashTag object from JSON
  factory HashTagModel.fromJson(Map<String, dynamic> json) {
    return HashTagModel(
      posts: List<String>.from(json['posts']),
      hashTagName: json['name'],
    );
  }
}
