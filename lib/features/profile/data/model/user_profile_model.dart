import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required String fullName,
    required String userName,
    required String dob,
    String? phoneNumber,
    String? occupation,
    String? about,
    String? profilePic,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? interests,
  }) : super(
          fullName: fullName,
          userName: userName,
          dob: dob,
          phoneNumber: phoneNumber,
          occupation: occupation,
          about: about,
          profilePic: profilePic,
          location: location,
          latitude: latitude,
          longitude: longitude,
          interests: interests ?? [],
        );

  factory UserProfileModel.fromUserProfile(UserProfile userProfile) {
    return UserProfileModel(
      fullName: userProfile.fullName,
      userName: userProfile.userName,
      dob: userProfile.dob,
      phoneNumber: userProfile.phoneNumber,
      occupation: userProfile.occupation,
      about: userProfile.about,
      profilePic: userProfile.profilePic,
      location: userProfile.location,
      latitude: userProfile.latitude,
      longitude: userProfile.longitude,
      interests: userProfile.interests,
    );
  }

  UserProfileModel copyWith({
    String? fullName,
    String? userName,
    String? dob,
    String? phoneNumber,
    String? occupation,
    String? about,
    String? profilePic,
    String? location,
    double? latitude,
    double? longitude,
    List<String>? interests,
  }) {
    return UserProfileModel(
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      occupation: occupation ?? this.occupation,
      about: about ?? this.about,
      profilePic: profilePic ?? this.profilePic,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      interests: interests ?? this.interests,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      fullName: json['fullName'],
      userName: json['userName'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      occupation: json['occupation'],
      about: json['about'],
      profilePic: json['profilePic'],
      location: json['location'],
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      interests: json['interests'] != null
          ? List<String>.from(json['interests'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'interests': interests,
    };
  }
}
