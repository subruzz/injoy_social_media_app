import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final bool hasPremium;
  final String? fullName;
  final String? userName;
  final String? dob;
  final String? phoneNumber;
  final String? occupation;
  final String? about;
  final String? profilePic;
  final String? location;
  final Timestamp? lastSeen;
  final double? latitude;
  final double? longitude;
  int followersCount;
  int followingCount;
  // final List<String> followers;
  final List<String> following;
  final List<String> interests;
  final bool onlineStatus;
  final List<String> posts;
  final int viewedSetupIndex;

  AppUser({
    required this.id,
    this.viewedSetupIndex = 0,
    required this.email,
    this.lastSeen,
    required this.hasPremium,
    required this.fullName,
    required this.userName,
    required this.onlineStatus,
    required this.dob,
    required this.followersCount,
    required this.followingCount,
    this.phoneNumber,
    this.occupation,
    this.about,
    this.profilePic,
    this.location,
    this.latitude,
    this.longitude,

    // this.followers = const [],
    this.following = const [],
    this.posts = const [],
    this.interests = const [],
  });
  @override
  List<Object?> get props => [
        id,
        email,
        hasPremium,
        fullName,
        userName,
        dob, lastSeen,
        phoneNumber,
        occupation,
        about,
        profilePic,
        location,
        latitude,
        longitude, onlineStatus,
        // ...followers,
        // ...following,
        ...interests,
        ...posts,
      ];
}
