import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  UserProfileModel({
    required super.fullName,
    required super.dob,
    super.phoneNumber,
    super.occupation,
    super.about,
    super.profilePic,
    super.location,
    super.latitude,
    super.longitude,
    required super.userName,
    List<String>? interests,
  }) : super(
          interests: interests ?? [],
        );

  factory UserProfileModel.fromUserProfile(UserProfile userProfile) {
    return UserProfileModel(
      fullName: userProfile.fullName,
      dob: userProfile.dob,
      userName: userProfile.userName,
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
    String? dob,
    String? phoneNumber,
    String? occupation,
    String? about,
    String? profilePic,
    String? location,
    double? latitude,
    double? longitude,
    String? userName,
    List<String>? interests,
  }) {
    return UserProfileModel(
      fullName: fullName ?? this.fullName,
      dob: dob ?? this.dob,
      userName: userName ?? this.userName,
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
      interests:
          json['interests'] != null ? List<String>.from(json['interests']) : [],
    );
  }

  Map<String, dynamic> toJson({bool edit = false}) {
    return {
      'fullName': fullName,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'occupation': occupation,
      'about': about,
      'profilePic': profilePic,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'userName': userName,
      if (!edit) 'interests': interests,
    };
  }
}
