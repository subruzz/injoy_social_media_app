import 'package:social_media_app/core/common/entities/user_entity.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.email,
    required super.hasPremium,
    super.fullName,
    super.userName,
    super.dob,
    super.phoneNumber,
    super.occupation,
    super.about,
    super.profilePic,
    super.location,
    super.latitude,
    super.longitude,
    super.followers,
    super.following,
    super.posts,
    super.interests,
   super.viewedSetupIndex,
  });

  // AppUserModel copyWith({
  //   String? id,
  //   String? email,
  //   bool? hasPremium,
  //   String? fullName,
  //   String? userName,
  //   String? dob,
  //   String? phoneNumber,
  //   String? occupation,
  //   String? about,
  //   String? profilePic,
  //   String? location,
  //   double? latitude,
  //   double? longitude,
  //   List<String>? followers,
  //   List<String>? following,
  //   List<String>? posts,
  //   List<String>? interests,
  // }) {
  //   return AppUserModel(
  //     id: id ?? this.id,
  //     email: email ?? this.email,
  //     hasPremium: hasPremium ?? this.hasPremium,
  //     fullName: fullName ?? this.fullName,
  //     userName: userName ?? this.userName,
  //     dob: dob ?? this.dob,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     occupation: occupation ?? this.occupation,
  //     about: about ?? this.about,
  //     profilePic: profilePic ?? this.profilePic,
  //     location: location ?? this.location,
  //     latitude: latitude ?? this.latitude,
  //     longitude: longitude ?? this.longitude,
  //     followers: followers ?? this.followers,
  //     following: following ?? this.following,
  //     posts: posts ?? this.posts,
  //     interests: interests ?? this.interests, isInterestPageSeen: interestp,
  //   );
  // }

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      viewedSetupIndex: json['viewedSetupIndex'],
      id: json['id'],
      email: json['email'],
      hasPremium: json['hasPremium'],
      fullName: json['fullName'],
      userName: json['userName'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      occupation: json['occupation'],
      about: json['about'],
      profilePic: json['profilePic'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      posts: List<String>.from(json['posts'] ?? []),
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'viewedSetupIndex': viewedSetupIndex,
      'id': id,
      'email': email,
      'hasPremium': hasPremium,
      'fullName': fullName,
      'userName': userName,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'about': about,
      'profilePic': profilePic,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'followers': followers,
      'following': following,
      'posts': posts,
      'interests': interests,
    };
  }
}
