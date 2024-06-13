import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final bool hasPremium;

  String fullName;
  String userName;
  String dob;
  int? phoneNumber;
  String? occupation;
  String? about;
  String? profilePic;
  String? location;
  double? latitude;
  double? longitude;
  List<String> followers;
  List<String> following;
  List<String> interests;
  List<String> posts;
  AppUser(
      {required this.id,
      required this.email,
      required this.hasPremium,
      required this.fullName,
      required this.userName,
      required this.dob,
      this.phoneNumber,
      this.occupation,
      this.about,
      this.profilePic,
      this.location,
      this.latitude,
      this.longitude,
      this.followers = const [],
      this.following = const [],
      this.posts = const [],
      this.interests = const []});
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
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
  @override
  List<Object?> get props => [
        id,
        email,
        hasPremium,
        fullName,
        userName,
        dob,
        phoneNumber,
        occupation,
        about,
        profilePic,
        location,
        latitude,
        longitude,
        followers,
        following,
        interests,
        posts,
      ];
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
      'followers': followers,
      'following': following,
      'posts': posts,
      'interests': interests,
    };
  }
}
