import 'package:social_media_app/core/common/entities/user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
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
  });

  AppUserModel copyWith({
    String? id,
    String? email,
    bool? hasPremium,
    String? fullName,
    String? userName,
    String? dob,
    int? phoneNumber,
    String? occupation,
    String? about,
    String? profilePic,
    String? location,
    double? latitude,
    double? longitude,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      hasPremium: hasPremium ?? this.hasPremium,
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
    );
  }

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      id: json['id'],
      email: json['email'],
      hasPremium: json['hasPremium'],
      fullName: json['fullName'],
      userName: json['userName'],
      dob: json['dob'] ,
      phoneNumber: json['phoneNumber'],
      occupation: json['occupation'],
      about: json['about'],
      profilePic: json['profilePic'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
